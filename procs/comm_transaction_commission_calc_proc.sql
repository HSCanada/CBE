set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[comm_transaction_commission_calc_proc] 
	@nAuditId int,
	@bDebug as smallint = 0
AS

/******************************************************************************
**	File: 
**	Name: comm_transaction_commission_calc_proc
**	Desc: Calculate commission tranaction details
**
**              
**	Return values:  @@Error
**
**	Called by:   
**             
**	Parameters:
**	Input					Output
**	----------				-----------
**	@bDebug
**
**	Auth: tmc
**	Date: 19 July 06
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**	15 May 07	tmc		Updated logic for new 2007 FSC plan
**  08 May 13   tmc		Add GP$ to calculation
**	04 Feb 15	tmc		Add Parts to EQ correction
--	29 Jan 16	tmc 	Update for 2016 Plan
**    
*******************************************************************************/

Declare @nErrorCode int, @nTranCount int
Declare @sMessage varchar(255)

Set @nErrorCode = @@Error
Set @nTranCount = @@Trancount

Declare @sCurrentFiscalYearmoNum char(6)
Declare @nBatchStatus int

Set @sCurrentFiscalYearmoNum = ''
Set @nBatchStatus = -1

-- Start transaction
if (@nTranCount = 0)
	Begin Tran mytran
Else
	Save Tran mytran

if (@bDebug <> 0)
	Print 'Lookup Current Fiscal Period (CFP)'


If (@nErrorCode = 0) 
Begin
	Select 	
		@sCurrentFiscalYearmoNum = current_fiscal_yearmo_num
	From 
		comm_configure

	Set @nErrorCode = @@Error
End

if (@bDebug <> 0)
	Print @sCurrentFiscalYearmoNum

if (@bDebug <> 0)
	Print 'Get BatchStatus for CFP'
	
If (@nErrorCode = 0) 
Begin
	Select 	
		@nBatchStatus = status_cd
	From 
		comm_batch_control
	Where
		fiscal_yearmo_num = @sCurrentFiscalYearmoNum
	
	Set @nErrorCode = @@Error
End
if (@bDebug <> 0)
	Print Convert(varchar, @nBatchStatus)


if (@bDebug <> 0)
	Print 'BatchStatus Data Verifed but not closed?'

-- Consolodate in 1 or 2 main updates...

If (@nBatchStatus >= 20 and @nBatchStatus < 999)
Begin

	if (@bDebug <> 0)
		Print 'Update FSC and Plan info'

	If (@nErrorCode = 0) 
	Begin

		Update
			comm_transaction
		Set 
			salesperson_key_id = IsNull(t.salesperson_key_id, ''), 
			comm_plan_id = IsNull(t.comm_plan_id, ''),
			status_cd = 0,

			-- GP Plan, added 15 May 13, tmc
			item_comm_rt = 0,
			customer_comm_rt = 0,
			comm_rt = 0,
--			comm_amt = 0,
			customer_comm_group_cd = '',
			item_comm_group_cd = ''
			


		From 
			comm_transaction s,
			(
			SELECT   
				record_id,  
				scm.salesperson_key_id,
				scm.comm_plan_id
			FROM         
				comm_transaction tt 
				LEFT OUTER JOIN comm_salesperson_code_map scm 
				ON tt.salesperson_cd = scm.salesperson_cd
			Where
				tt.fiscal_yearmo_num = @sCurrentFiscalYearmoNum
			) t
		Where 
			s.fiscal_yearmo_num = @sCurrentFiscalYearmoNum And
			s.record_id = t.record_id And
--			s.salesperson_key_id <> IsNull(t.salesperson_key_id, '') And
--			s.comm_plan_id <> IsNull(t.comm_plan_id, '') And
			1=1


		Set @nErrorCode = @@Error
	End

	if (@bDebug <> 0)
		Print 'Update customer info'
	
	If (@nErrorCode = 0) 
	Begin

		Update
			comm_transaction
		Set 
			customer_comm_group_cd = t.customer_comm_group_cd
		From 
			comm_transaction s,
			(
			SELECT     
				tt.record_id, 
				c.comm_group_cd AS customer_comm_group_cd
			FROM         
				comm_transaction tt 
					INNER JOIN comm_customer_master c
					ON tt.hsi_shipto_id = c.hsi_shipto_id
			Where
				tt.fiscal_yearmo_num = @sCurrentFiscalYearmoNum And
				tt.comm_plan_id <> '' And
				tt.source_cd IN ('ACCPAC', 'JDE')
			) t
		Where 
			s.fiscal_yearmo_num = @sCurrentFiscalYearmoNum And
			s.record_id = t.record_id 

		Set @nErrorCode = @@Error
	End


	if (@bDebug <> 0)
		Print 'Update Item info'

	If (@nErrorCode = 0) 
	Begin

		Update
			comm_transaction
		Set 
-- #FIX
			-- override Customer institutional at the Sudry item level so that it gets broken out on the statement, 15 May 07, tmc.
			item_comm_group_cd =	CASE 
										WHEN s.customer_comm_group_cd = 'CUSINS' and t.item_comm_group_cd IN ('ITMSND', 'ITMTEE') 
										Then s.customer_comm_group_cd 
										Else t.item_comm_group_cd 
									End

--			item_comm_group_cd = t.item_comm_group_cd

--			disable cost update.  Use Item costs.  15 May 07, tmc
--			cost_unit_amt = t.cost_unit_amt,
--			cost_ext_amt = t.cost_ext_amt,
--			item_label_cd = t.item_label_cd
		From 
			comm_transaction s,
			(
			SELECT     
				tt.record_id, 
				i.comm_group_cd AS item_comm_group_cd, 
				i.cost_unit_amt, 
				i.cost_unit_amt * tt.shipped_qty AS cost_ext_amt, 
				i.item_label_cd
			FROM         
				comm_transaction tt 
					INNER JOIN comm_item_master i 
					ON tt.item_id = i.item_id
			Where
				tt.fiscal_yearmo_num = @sCurrentFiscalYearmoNum And
				tt.comm_plan_id <> '' And
				tt.source_cd IN ('ACCPAC', 'JDE')
			) t
		Where 
			s.fiscal_yearmo_num = @sCurrentFiscalYearmoNum And
			s.record_id = t.record_id 

	
		Set @nErrorCode = @@Error
	End

-- Fix Parts, 4 Feb 15, tmc

	if (@bDebug <> 0)
		Print 'Update Parts on EQ Orders'

	If (@nErrorCode = 0) 
	Begin

		Update
			comm_transaction
		Set 
			-- override Parts on EQ orders.  Pelton is Focus 1 and the rest Focus 3., 04 Feb 15, tmc.
			item_comm_group_cd =	CASE 
										WHEN t.manufact_cd IN ('PELTON' ) 
										Then 'ITMFO1' 
										Else 'ITMFO3' 
									End

		From 
			comm_transaction s,
			(
			SELECT     
				tt.record_id, 
				tt.item_comm_group_cd, 
				tt.manufact_cd

			FROM         
				comm_transaction tt 
			Where
				tt.fiscal_yearmo_num = @sCurrentFiscalYearmoNum And
--				tt.fiscal_yearmo_num = '201501' And
				tt.comm_plan_id <> '' And
				tt.source_cd IN ('ACCPAC', 'JDE') And
				tt.order_source_cd IN ('A','L') And		-- Astea  EQ and Service
				tt.ess_salesperson_cd <>'' And			-- Exclude Service (No ESS code)
				tt.item_comm_group_cd = 'ITMPAR' And	-- ONLY affect Parts 
				1=1
			) t
		Where 
			s.fiscal_yearmo_num = @sCurrentFiscalYearmoNum And
			s.record_id = t.record_id 


		Set @nErrorCode = @@Error
	End



	if (@bDebug <> 0)
		Print 'Update Import / Payroll info'
	
	If (@nErrorCode = 0) 
	Begin
		Update
			comm_transaction
		Set 
			item_comm_group_cd = comm_group_cd
		Where
			(fiscal_yearmo_num = @sCurrentFiscalYearmoNum) And
			(comm_plan_id like 'FSC%') And 
			(source_cd IN ('IMPORT','PAYROLL'))


		Set @nErrorCode = @@Error
	End

	
	if (@bDebug <> 0)
		Print 'Update Item and Customer rates'
	
	If (@nErrorCode = 0) 
	Begin

		Update
			comm_transaction
		Set 
			item_comm_rt = t.item_comm_rt,
			customer_comm_rt = t.customer_comm_rt
		From 
			comm_transaction s,
			(
			SELECT     
				tt.record_id, 
				ic.comm_rt AS item_comm_rt,
				cc.comm_rt AS customer_comm_rt
			FROM         
				comm_transaction tt 
					INNER JOIN comm_rate_map ic
					ON tt.comm_plan_id = ic.comm_plan_id And
						tt.item_comm_group_cd = ic.comm_group_cd And
						tt.comm_cd = ic.comm_cd

					INNER JOIN comm_rate_map cc
					ON tt.comm_plan_id = cc.comm_plan_id And
						tt.customer_comm_group_cd = cc.comm_group_cd And
						tt.comm_cd = cc.comm_cd

			Where
				tt.fiscal_yearmo_num = @sCurrentFiscalYearmoNum And
				tt.comm_plan_id like 'FSC%' And 
				tt.source_cd IN ('ACCPAC', 'JDE')
			) t
		Where 
			s.fiscal_yearmo_num = @sCurrentFiscalYearmoNum And
			s.record_id = t.record_id 


		Set @nErrorCode = @@Error
	End


	if (@bDebug <> 0)
		Print 'Determine master commission group'
	
	If (@nErrorCode = 0) 
	Begin

		Update
			comm_transaction
		Set 
			-- GP Plan, added 15 May 13, tmc
#FIX
			comm_group_cd = Case When comm_supersede_ind = 1 or customer_comm_group_cd = '' Then item_comm_group_cd Else customer_comm_group_cd End,
--			comm_group_cd = Case When comm_supersede_ind = 1 Then item_comm_group_cd Else customer_comm_group_cd End,
			status_cd = 10

		From 
			comm_transaction s,
			(
			SELECT     
				tt.record_id, 
				g.comm_supersede_ind
			FROM         
				comm_transaction tt 
					INNER JOIN comm_group g
					ON tt.item_comm_group_cd = g.comm_group_cd
			Where
				tt.fiscal_yearmo_num = @sCurrentFiscalYearmoNum And
				tt.comm_plan_id like 'FSC%' And 
				tt.source_cd IN ('ACCPAC', 'JDE')
			) t
		Where 
			s.fiscal_yearmo_num = @sCurrentFiscalYearmoNum And
			s.record_id = t.record_id 


		Set @nErrorCode = @@Error
	End

	if (@bDebug <> 0)
		Print 'Determine master default commission rate'
	
	If (@nErrorCode = 0) 
	Begin
		Update
			comm_transaction
		Set 
			comm_rt = t.comm_rt,
			-- GP Plan, added 14 May 13, tmc
-- #FIX
			comm_amt =  Case When t.calc_comm_using_gp_ind = 1 Then gp_ext_amt Else transaction_amt End *(t.comm_rt/100),
--			comm_amt =  transaction_amt*(t.comm_rt/100),
			status_cd = 20

		From 
			comm_transaction s,
			(
			SELECT     
				tt.record_id, 
				r.comm_rt,

				-- GP Plan, added 14 May 13, tmc
				p.calc_comm_using_gp_ind
			FROM         
				comm_transaction tt 
					INNER JOIN comm_rate_map r
					ON tt.comm_plan_id = r.comm_plan_id And
						tt.comm_group_cd = r.comm_group_cd And
						tt.comm_cd = r.comm_cd 

					-- GP Plan, added 14 May 13, tmc
					INNER JOIN comm_plan p
					ON tt.comm_plan_id = p.comm_plan_id 

			Where
				tt.fiscal_yearmo_num = @sCurrentFiscalYearmoNum And
				tt.comm_plan_id like 'FSC%' And 
				tt.source_cd IN ('ACCPAC', 'JDE') And
				tt.status_cd = 10 
			) t
		Where 
			s.fiscal_yearmo_num = @sCurrentFiscalYearmoNum And
			s.record_id = t.record_id 


		Set @nErrorCode = @@Error
	End




	if (@bDebug <> 0)
		Print 'Calculate IMPORT NON PMA & Financial Spiff and Mark complete'

	If (@nErrorCode = 0) 
	Begin
		Update
			comm_transaction
		Set 
			status_cd = 20,
			comm_rt = t.comm_rt,

			-- GP Plan, added 14 May 13, tmc
			comm_amt =  gp_ext_amt *(t.comm_rt/100)
--			comm_amt = transaction_amt*(t.comm_rt/100)

		From 
			comm_transaction s,
			(
			SELECT     
				tt.record_id, 
				r.comm_rt

			FROM         
				comm_transaction tt 
					INNER JOIN comm_rate_map r
					ON tt.comm_plan_id = r.comm_plan_id And
						tt.comm_group_cd = r.comm_group_cd And
						tt.comm_cd = r.comm_cd 

					-- GP Plan, added 14 May 13, tmc
					INNER JOIN comm_plan p
					ON tt.comm_plan_id = p.comm_plan_id 

			Where
				tt.fiscal_yearmo_num = @sCurrentFiscalYearmoNum And

				-- GP Plan, added 14 May 13, tmc
				p.calc_comm_using_gp_ind = 1 And
--				tt.comm_plan_id like 'FSC%' And 

				tt.source_cd = 'IMPORT' And
				tt.comm_group_cd NOT In ('PMANEW','SFFFIN')
			) t
		Where 
			s.fiscal_yearmo_num = @sCurrentFiscalYearmoNum And
			s.record_id = t.record_id 

		Set @nErrorCode = @@Error
	End


	if (@bDebug <> 0)
		Print 'Calculate PMA & Financial Spiff and Mark complete'

	If (@nErrorCode = 0) 
	Begin
		Update
			comm_transaction
		Set 
			status_cd = 20,
			comm_rt = t.comm_rt,

			-- GP Plan, added 14 May 13, tmc
			comm_amt =  Case When t.calc_comm_using_gp_ind = 1 Then gp_ext_amt Else transaction_amt End *(t.comm_rt/100)
--			comm_amt = transaction_amt*(t.comm_rt/100)

		From 
			comm_transaction s,
			(
			SELECT     
				tt.record_id, 
				r.comm_rt,

				-- GP Plan, added 14 May 13, tmc
				p.calc_comm_using_gp_ind
			FROM         
				comm_transaction tt 
					INNER JOIN comm_rate_map r
					ON tt.comm_plan_id = r.comm_plan_id And
						tt.comm_group_cd = r.comm_group_cd And
						tt.comm_cd = r.comm_cd 

					-- GP Plan, added 14 May 13, tmc
					INNER JOIN comm_plan p
					ON tt.comm_plan_id = p.comm_plan_id 

			Where
				tt.fiscal_yearmo_num = @sCurrentFiscalYearmoNum And
				tt.comm_plan_id like 'FSC%' And 
				tt.source_cd = 'IMPORT' And
				tt.comm_group_cd In ('PMANEW','SFFFIN')
			) t
		Where 
			s.fiscal_yearmo_num = @sCurrentFiscalYearmoNum And
			s.record_id = t.record_id 

		Set @nErrorCode = @@Error
	End

	if (@bDebug <> 0)
		Print 'Mark Import and Payroll transactions as complete'
	
	If (@nErrorCode = 0) 
	Begin
		Update
			comm_transaction
		Set 
			status_cd = 20

		Where
			(fiscal_yearmo_num = @sCurrentFiscalYearmoNum) And
			(comm_plan_id like 'FSC%') And 
			((source_cd = 'IMPORT' And Not comm_group_cd In ('PMANEW','SFFFIN')) or (source_cd = 'PAYROLL'))


		Set @nErrorCode = @@Error
	End



	if (@bDebug <> 0)
		Print 'Set BatchStatus to Processed'	
	
	If (@nErrorCode = 0) 
	Begin
		Update
			comm_batch_control
		Set 
			status_cd = 30
		Where 
			fiscal_yearmo_num = @sCurrentFiscalYearmoNum
	
		Set @nErrorCode = @@Error
	End

End


	if (@bDebug <> 0)
	BEGIN
		Print 'Test3 - final'
		select * from 	comm_transaction where record_id = 8166895
	END

if (@bDebug <> 0)
	Set @nErrorCode = 512

-- Call error message on Error
if (@nErrorCode <> 0)
Begin
	Set @sMessage = 'comm_transaction_commission_calc_proc'
	Set @sMessage = @sMessage + ':  Return(' + Convert(varchar, @nErrorCode) + ')'
	Set @sMessage = @sMessage +  ', ' + convert(varchar, @nAuditId)
	Set @sMessage = @sMessage +  ', ' + convert(varchar, @bDebug)

	RAISERROR (50060, 9, 1, @sMessage )

	Rollback Tran mytran

	return @nErrorCode
End

-- Commit tran on Success
if (@nTranCount = 0)
Begin
	Commit Tran
End

Return @nErrorCode


