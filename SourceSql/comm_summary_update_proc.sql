
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[comm_summary_update_proc] 
	@bDebug as smallint = 1
AS
/******************************************************************************
**	File: 
**	Name: comm_summary_update_proc
**	Desc: Update summary table based on transaction details
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
**	Date: 19 May 06
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**	12 Jul 06	tmc		updated the Totals logic
**	04 Mar 07	tmc		update logic to include LY sales 
**	03 Jul 07	tmc		Add comm and private lable bonus 
**	12 Sept 07	tmc		Added GP summary logic
**  02 Mar 08	tmc		Added ESS summary logic & turn off total logic
**	27 Jan 10	tmc		Updated for Comm 2010
**  01 Mar 11	tmc		Add Vendor Item logic to ESS
--	20 Jan 16	tmc 	Review #FIX, note FSC status used on ESS summary logic!
--  26 Jan 16	tmc		Removed unneeded ESS Bonus logic and status filters
--	02 Feb 16	tmc		Fixed ESS Comm rollup bug (FSC amt used instead of ESS)
--	24 Feb 16	tmc		Finalize Automation, remove legacy, and set Debug to default
--  27 May 16	tmc		Fix ESS PY summary bug 

**    
*******************************************************************************/

Declare @nErrorCode int, @nTranCount int
Declare @sMessage varchar(255)

Set @nErrorCode = @@Error
Set @nTranCount = @@Trancount

Declare @sCurrentFiscalYearmoNum char(6)
Declare @nCurrentFiscalYearmoNumQty int
Declare @sRefFiscalYearmoNum char(6)
Declare @nBatchStatus int

SET NOCOUNT ON;
if (@bDebug <> 0)
	SET NOCOUNT OFF;

if (@bDebug <> 0) 
Begin
	Print '---------------------------------------------------------'
	Print 'Proc: comm_summary_update_proc'
	Print 'Desc: Update summary table based on transaction details'
	Print 'Mode: DEBUG'
	Print '---------------------------------------------------------'
End

------------------------------------------------------------------------------------------------------------
-- Init routines.  
------------------------------------------------------------------------------------------------------------

Set @sCurrentFiscalYearmoNum = ''
Set @nCurrentFiscalYearmoNumQty = 0
Set @nBatchStatus = -1

-- Start transaction
if (@nTranCount = 0)
	Begin Tran mytran
Else
	Save Tran mytran


If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
			Print 'Get Current Fiscal Month'

	Select 	
		@sCurrentFiscalYearmoNum = current_fiscal_yearmo_num
	From 
		comm_configure

	Set @nErrorCode = @@Error
End


If (@nErrorCode = 0) 
Begin

	if (@bDebug <> 0)
		Print 'Get BatchStatus'

	Select 	
		@nBatchStatus = status_cd,
		@nCurrentFiscalYearmoNumQty = fiscal_yearmo_qty
	From 
		comm_batch_control
	Where
		fiscal_yearmo_num = @sCurrentFiscalYearmoNum
	
	Set @nErrorCode = @@Error
End


If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print 'Get PY Fiscal Month'

	Select 	
		@sRefFiscalYearmoNum = fiscal_yearmo_num
	From 
		comm_batch_control
	Where
		fiscal_yearmo_qty = (@nCurrentFiscalYearmoNumQty - 12)

	Set @nErrorCode = @@Error
End

------------------------------------------------------------------------------------------------------------
-- Update routines.  
------------------------------------------------------------------------------------------------------------

if (@bDebug <> 0)
Begin
	Print 'Confirm BatchStatus NOT locked'
	Print @sCurrentFiscalYearmoNum
	Print @sRefFiscalYearmoNum
	Print @nBatchStatus
End


If (@nBatchStatus >= 10 and @nBatchStatus < 999)
Begin
	
	If (@nErrorCode = 0) 
	Begin

		if (@bDebug <> 0)
			Print 'Update Summary - Append Missing Records'

		Insert Into comm_summary 
		(
			salesperson_key_id,
			comm_group_cd,
			audit_id
		)
		SELECT     
			s.salesperson_key_id, 
			g.comm_group_cd,
			0 as audit_id
		FROM         
			comm_salesperson_master s 
				CROSS JOIN comm_group g
		Where not exists
		(
			Select 
				* 
			From 
				comm_summary m 
			Where 
				m.salesperson_key_id = s.salesperson_key_id And
				m.comm_group_cd = g.comm_group_cd
		)

	
		Set @nErrorCode = @@Error
	End

	
	If (@nErrorCode = 0) 
	Begin

		if (@bDebug <> 0)
			Print 'Update Summary - Init values to 0'

		Update
			comm_summary
		Set 
			sales_curr_amt = 0,
			costs_curr_amt = 0,
			comm_curr_amt = 0,
			gp_curr_amt = 0,

			sales_ref_amt = 0,
			costs_ref_amt = 0,
			comm_ref_amt = 0,
			gp_ref_amt = 0,

			audit_id = 0
	
		Set @nErrorCode = @@Error
	End
	
	If (@nErrorCode = 0) 
	Begin

		if (@bDebug <> 0)
			Print 'Update Summary - Build FSC'

		Update
			comm_summary
		Set 
			sales_curr_amt = t.sales_curr_amt,
			costs_curr_amt = t.costs_curr_amt,
			comm_curr_amt = t.comm_curr_amt,
			gp_curr_amt = t.gp_curr_amt

		From 
			comm_summary s,
			(SELECT     
				salesperson_key_id, 
				item_comm_group_cd as comm_group_cd, 
				SUM(transaction_amt) AS sales_curr_amt, 
				SUM(cost_ext_amt) AS costs_curr_amt, 
				SUM(comm_amt) AS comm_curr_amt,
				SUM(gp_ext_amt) AS gp_curr_amt
			FROM         
				comm_transaction
			WHERE     
				(fiscal_yearmo_num = @sCurrentFiscalYearmoNum) AND 
--				(status_cd >= 20) AND
				(1=1)
			GROUP BY 
				salesperson_key_id, 
				item_comm_group_cd) t
		Where 
			s.salesperson_key_id = t.salesperson_key_id And
			s.comm_group_cd = t.comm_group_cd
	
		Set @nErrorCode = @@Error
	End


	If (@nErrorCode = 0) 
	Begin

		if (@bDebug <> 0)
			Print 'Update Summary - Build ESS'

		Update
			comm_summary
		Set 
			sales_curr_amt = t.sales_curr_amt,
			costs_curr_amt = t.costs_curr_amt,
			comm_curr_amt = t.comm_curr_amt,
			gp_curr_amt = t.gp_curr_amt

		From 
			comm_summary s,
			(SELECT     
				ess_salesperson_key_id as salesperson_key_id, 
				ess_comm_group_cd as comm_group_cd, 
				SUM(transaction_amt) AS sales_curr_amt, 
				SUM(cost_ext_amt) AS costs_curr_amt,

--	02 Feb 16	tmc		Fixed ESS Comm rollup bug (FSC amt used instead of ESS)
				SUM(ess_comm_amt) AS comm_curr_amt,
--				SUM(comm_amt) AS comm_curr_amt,
				SUM(gp_ext_amt) AS gp_curr_amt
			FROM         
				comm_transaction
			WHERE     
				(fiscal_yearmo_num = @sCurrentFiscalYearmoNum) AND 
--				(status_cd >= 20) AND
				(1=1)
			GROUP BY 
				ess_salesperson_key_id, 
				ess_comm_group_cd) t
		Where 
			s.salesperson_key_id = t.salesperson_key_id And
			s.comm_group_cd = t.comm_group_cd
	
		Set @nErrorCode = @@Error
	End


	If (@nErrorCode = 0) 
	Begin

		if (@bDebug <> 0)
			Print 'Update Summary - Build FSC Bonus'

		Update
			comm_summary
		Set 
			sales_curr_amt = t.sales_curr_amt,
			gp_curr_amt = t.gp_curr_amt,
			-- Map Qty to Cost for E4D
			costs_curr_amt = t.shipped_qty
		From 
			comm_summary s,
			(
			SELECT     
				tr.salesperson_key_id, 
				sr.comm_group_cd as comm_group_cd,
				SUM(tr.transaction_amt) AS sales_curr_amt,
				SUM(tr.gp_ext_amt) AS gp_curr_amt,
				SUM(tr.shipped_qty) AS shipped_qty
			FROM         
				comm_transaction tr
					INNER JOIN comm_bonus_item sr
					on tr.item_id = sr.IMITEM

			WHERE     
				(fiscal_yearmo_num = @sCurrentFiscalYearmoNum) AND 
				(source_cd ='JDE') AND
				(comm_plan_id like 'FSC%') AND
				1=1
			GROUP BY 
				tr.salesperson_key_id,
				sr.comm_group_cd
			) t
		Where 
			s.salesperson_key_id = t.salesperson_key_id And
			s.comm_group_cd = t.comm_group_cd
	
		Set @nErrorCode = @@Error
	End


	
	If (@nErrorCode = 0) 
	Begin

		if (@bDebug <> 0)
			Print 'Update Summary - Build FSC PY'

		Update
			comm_summary
		Set 
			sales_ref_amt = t.sales_ref_amt,
			costs_ref_amt = t.costs_ref_amt,
			comm_ref_amt = t.comm_ref_amt,
			gp_ref_amt = t.gp_ref_amt

		From 
			comm_summary s,
			(SELECT     
				salesperson_key_id, 
				item_comm_group_cd as comm_group_cd, 
				SUM(transaction_amt) AS sales_ref_amt, 
				SUM(cost_ext_amt) AS costs_ref_amt, 
				SUM(comm_amt) AS comm_ref_amt,
				SUM(gp_ext_amt) AS gp_ref_amt
			FROM         
				comm_transaction
			WHERE     
				(fiscal_yearmo_num = @sRefFiscalYearmoNum) AND 
--				(status_cd >= 20) AND
				(1=1)
			GROUP BY 
				salesperson_key_id, 
				item_comm_group_cd) t
		Where 
			s.salesperson_key_id = t.salesperson_key_id And
			s.comm_group_cd = t.comm_group_cd
	
		Set @nErrorCode = @@Error
	End


--
--
		
	If (@nErrorCode = 0) 
	Begin

		if (@bDebug <> 0)
			Print 'Update Summary - Build ESS PY'


		Update
			comm_summary
		Set 
			sales_ref_amt = t.sales_ref_amt,
			costs_ref_amt = t.costs_ref_amt,
			comm_ref_amt = t.comm_ref_amt,
			gp_ref_amt = t.gp_ref_amt

		From 
			comm_summary s,
			(SELECT     
--  27 May 16	tmc		Fix ESS PY summary bug 
				ess_salesperson_key_id as salesperson_key_id, 
				ess_comm_group_cd as comm_group_cd, 
--				salesperson_key_id, 
--				item_comm_group_cd as comm_group_cd, 

				SUM(transaction_amt) AS sales_ref_amt, 
				SUM(cost_ext_amt) AS costs_ref_amt, 

--  27 May 16	tmc		Fix ESS PY summary bug 
				SUM(ess_comm_amt) AS comm_ref_amt,
--				SUM(comm_amt) AS comm_ref_amt,

				SUM(gp_ext_amt) AS gp_ref_amt
			FROM         
				comm_transaction
			WHERE     
				(fiscal_yearmo_num = @sRefFiscalYearmoNum) AND 
				(1=1)
			GROUP BY 
--  27 May 16	tmc		Fix ESS PY summary bug 
				ess_salesperson_key_id, 
				ess_comm_group_cd
--				salesperson_key_id, 
--				item_comm_group_cd
			) t
		Where 
			s.salesperson_key_id = t.salesperson_key_id And
			s.comm_group_cd = t.comm_group_cd
	
		Set @nErrorCode = @@Error
	End

--
--

------------------------------------------------------------------------------------------------------------
-- Wrap-up routines.  
------------------------------------------------------------------------------------------------------------

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
	Set @nErrorCode = 512

-- Call error message on Error
if (@nErrorCode <> 0)
Begin
	Set @sMessage = 'comm_summary_update_proc'
	Set @sMessage = @sMessage + ':  Return(' + Convert(varchar, @nErrorCode) + ')'
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
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- Debug
-- Exec comm_summary_update_proc

-- Prod
-- Exec comm_summary_update_proc 0
