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


If (@nBatchStatus >= 20 and @nBatchStatus < 999)
Begin

	if (@bDebug <> 0)
		Print 'Update FSC SalespersonKey and FSC Plan'

	If (@nErrorCode = 0) 
	Begin

		UPDATE    
			comm_transaction
		SET              
			salesperson_key_id = s.salesperson_key_id, 
			comm_plan_id = s.comm_plan_id

--		SELECT     
--			t.fiscal_yearmo_num, 
--			t.source_cd,         
--			t.salesperson_cd,
--			t.salesperson_key_id, 
--			t.comm_plan_id,
--			s.salesperson_key_id, 
--			s.comm_plan_id

		FROM         
			comm_transaction t

			INNER JOIN comm_salesperson_code_map AS s 
			ON t.salesperson_cd = s.salesperson_cd

		WHERE     
			(t.fiscal_yearmo_num = '201601') AND 
			(t.salesperson_cd <> '') AND 
			((t.comm_plan_id <> s.comm_plan_id) OR (t.salesperson_key_id <> s.salesperson_key_id))


		Set @nErrorCode = @@Error
	End


	if (@bDebug <> 0)
		Print 'Update JDE Item Comm Group'

	If (@nErrorCode = 0) 
	Begin

-- Fix EQ Opt out !!!

		UPDATE    
			comm_transaction
		SET              
			item_comm_group_cd = CASE WHEN c.SPM_StatusCd = 'Y' THEN g.SPM_comm_group_cd ELSE g.comm_group_cd END
		FROM         

			comm_transaction t

			INNER JOIN comm_plan AS p 
			ON t.comm_plan_id = p.comm_plan_id 

			INNER JOIN comm_customer_master AS c 
			ON t.hsi_shipto_id = c.hsi_shipto_id 

			INNER JOIN comm_item_master AS i 
			ON t.item_id = i.item_id 

			INNER JOIN comm_group AS g 
			ON i.comm_group_cd = g.comm_group_cd

		WHERE     
			(t.fiscal_yearmo_num = '201601') AND 
			(t.source_cd = 'JDE') AND 
			(t.comm_plan_id LIKE 'FSC%') AND 
			(1 = 1)

-- Fix EQ Opt out
/*
		SELECT     
			t.fiscal_yearmo_num, 
			t.source_cd,         
			t.salesperson_cd,
			t.salesperson_key_id, 
			t.comm_plan_id,
			t.hsi_shipto_id,

			c.SPM_StatusCd AS CustSMStatus,
			c.SPM_EQOptOut AS CustEQOpt,

			g.SPM_EQOptOut AS GroupSPM_EQOptOut,
			g.comm_group_cd,
			g.SPM_comm_group_cd AS GroupSPM_comm_group_cd,


			t.item_comm_group_cd AS item_comm_group_cd_CURR,
			CASE WHEN c.SPM_StatusCd = 'Y' THEN g.SPM_comm_group_cd ELSE g.comm_group_cd END AS item_comm_group_cd_NEW

		FROM         
			comm_transaction t

			INNER JOIN comm_plan p
			ON t.comm_plan_id = p.comm_plan_id

			INNER JOIN comm_customer_master c
			ON t.hsi_shipto_id = c.hsi_shipto_id

			INNER JOIN comm_item_master i
			ON t.item_id = i.item_id

				INNER JOIN comm_group g
				ON i.comm_group_cd = g.comm_group_cd

		WHERE     
			(t.fiscal_yearmo_num = '201601') AND 
			(t.source_cd = 'JDE') AND
			(t.comm_plan_id LIKE 'FSC%') AND 

			(c.SPM_EQOptOut <> 'Y') AND
			(1=1)
*/
	
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
				tt.fiscal_yearmo_num = '201601' And
--				tt.fiscal_yearmo_num = @sCurrentFiscalYearmoNum And
				tt.comm_plan_id <> '' And
				tt.source_cd = 'JDE' And
				tt.order_source_cd IN ('A','L') And		-- Astea  EQ and Service
				tt.ess_salesperson_cd <>'' And			-- Exclude Service (No ESS code)
				tt.item_comm_group_cd = 'ITMPAR' And	-- ONLY affect Parts 
				1=1
			) t
		Where 
			(s.fiscal_yearmo_num = '201601' ) AND
--			(s.fiscal_yearmo_num = @sCurrentFiscalYearmoNum) AND
			(s.record_id = t.record_id) AND
			(1=1)


		Set @nErrorCode = @@Error
	End

-- Add Booking rate here !!!

	
	if (@bDebug <> 0)
		Print 'Update Item and Customer rates'
	
	If (@nErrorCode = 0) 
	Begin

		UPDATE    
			comm_transaction
		SET              
			item_comm_rt = r.comm_base_rt,
			comm_amt = t.gp_ext_amt * (r.comm_base_rt / 100.0) , 
			status_cd = 20

		FROM         
			comm_transaction t INNER JOIN

			comm_plan_group_rate AS r 
			ON t.comm_plan_id = r.comm_plan_id AND 
				t.item_comm_group_cd = r.comm_group_cd

		WHERE     
			(t.fiscal_yearmo_num = '201601') AND 
			(t.source_cd IN ('JDE', 'IMPORT')) AND 
			(t.comm_plan_id LIKE 'FSC%') AND 
			(1 = 1)

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
			fiscal_yearmo_num = '201601'
--			fiscal_yearmo_num = @sCurrentFiscalYearmoNum
	
		Set @nErrorCode = @@Error
	End

End



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


