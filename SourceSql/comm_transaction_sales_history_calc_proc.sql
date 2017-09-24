
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[comm_transaction_sales_history_calc_proc] 
	@nAuditId int,
	@bDebug as smallint = 0
AS
/******************************************************************************
**	File: 
**	Name: comm_transaction_sales_history_calc_proc
**	Desc: generate sales history file 
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
**	Date: 3 Aug 06
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**	02 Mar 08	tmc		Added ESS data
**  04 Feb 11	tmc		Fixed FSC / ESS History to include adjustments
--	20 Jan 16	tmc 	Review #FIX 
**    
*******************************************************************************/

Declare @nErrorCode int, @nTranCount int
Declare @sMessage varchar(255)
Declare @nRecalc int

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

If (@nErrorCode = 0) 
Begin

	if (@bDebug <> 0)
		Print 'Lookup Current Fiscal Period (CFP)'

	Select 	
		@sCurrentFiscalYearmoNum = current_fiscal_yearmo_num
	From 
		comm_configure

	Set @nErrorCode = @@Error
End

if (@bDebug <> 0)
	Print 'Fiscal month = ' + @sCurrentFiscalYearmoNum
	
If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print 'Get BatchStatus for CFP'

	Select 	
		@nBatchStatus = status_cd
	From 
		comm_batch_control
	Where
		fiscal_yearmo_num = @sCurrentFiscalYearmoNum
	
	Set @nErrorCode = @@Error

	if (@bDebug <> 0)
		Print 'Batch Status = ' + Convert(varchar, @nBatchStatus)
End


if (@nErrorCode = 0)
Begin
	if (@bDebug <> 0)
		Print 'BatchStatus loaded and calculated?'

	If (@nBatchStatus >= 30)
	Begin
		if (@bDebug <> 0)
			Print 'clear month data'

		Delete from 
			comm_sales_history
		where 
			(fiscal_yearmo_num =@sCurrentFiscalYearmoNum) and
			(comm_group_cd <> 'HSTCTL') and
			1=1

		Select @nRecalc = @@Rowcount, @nErrorCode = @@Error

		if (@bDebug <> 0)
			Print 'Recalc = ' + Convert(varchar, @nRecalc)

		if (@nErrorCode = 0)
		Begin
			if (@bDebug <> 0)
				Print 'add FSC data'

			INSERT INTO comm_sales_history
			(
				fiscal_yearmo_num, 
				salesperson_key_id, 
				comm_group_cd, 
				sales_amt
			)
			SELECT     
				fiscal_yearmo_num, 
				salesperson_key_id, 
				item_comm_group_cd AS comm_group_cd, 
				SUM(transaction_amt) AS sales_amt
			FROM         
				comm_transaction
			WHERE     
				(fiscal_yearmo_num =@sCurrentFiscalYearmoNum) And
				(status_cd = 20) And
				(source_cd in ('JDE', 'IMPORT')) And 
--				(comm_plan_id LIKE 'FSC%') And
				1=1
			GROUP BY 
				fiscal_yearmo_num, 
				salesperson_key_id, 
				item_comm_group_cd

			Set @nErrorCode = @@Error
		End
	
		if (@nErrorCode = 0)
		Begin
			if (@bDebug <> 0)
				Print 'add ESS data'

			INSERT INTO comm_sales_history
			(
				fiscal_yearmo_num, 
				salesperson_key_id, 
				comm_group_cd, 
				sales_amt
			)
			SELECT     
				fiscal_yearmo_num, 
				ess_salesperson_key_id, 
				ess_comm_group_cd AS comm_group_cd, 
				SUM(transaction_amt) AS sales_amt
			FROM         
				comm_transaction
			WHERE     
				(fiscal_yearmo_num =@sCurrentFiscalYearmoNum) And
--				(fiscal_yearmo_num ='201001') And
				(status_cd = 20) And
				(source_cd in ('JDE', 'IMPORT')) And
				(ess_salesperson_key_id<>'') And
--				(ess_comm_plan_id LIKE 'ESS%') And
				1=1
			GROUP BY 
				fiscal_yearmo_num, 
				ess_salesperson_key_id, 
				ess_comm_group_cd

			Set @nErrorCode = @@Error
		END

		if (@nErrorCode = 0)
		Begin
			if (@bDebug <> 0)
				Print 'customers with merchandise purchases'

			INSERT INTO comm_sales_history
			(
				fiscal_yearmo_num, 
				salesperson_key_id, 
				comm_group_cd, 
				customer_count_qty
			)
			SELECT     
				fiscal_yearmo_num, 
				salesperson_key_id, 
				'HSTCTB' AS comm_group_cd, 
				COUNT(DISTINCT (division_cd + customer_id)) AS customer_count_qty
			FROM         
				comm_transaction
			WHERE     
				(comm_plan_id LIKE 'FSC%') AND 
				(source_cd IN ('ACCPAC', 'JDE')) AND 
-- #FIX HC
				(item_comm_group_cd in ('CUSINS', 'ITMSND')) AND
				(fiscal_yearmo_num =@sCurrentFiscalYearmoNum)
			GROUP BY 
				fiscal_yearmo_num, 
				salesperson_key_id
			HAVING
				Sum(transaction_amt) > 0
			Set @nErrorCode = @@Error
		END

		if (@nErrorCode = 0)
		Begin
			if @nRecalc = 0
			BEGIN
				if (@bDebug <> 0)
					Print 'customers on territory list (if first time run)'
				INSERT INTO comm_sales_history
				(
					fiscal_yearmo_num, 
					salesperson_key_id, 
					comm_group_cd, 
					customer_count_qty
				)
				SELECT     
					cc.current_fiscal_yearmo_num, 
					sm.salesperson_key_id, 
					'HSTCTL' AS comm_group_cd, 
					COUNT(s.customer_id) AS customer_count_qty

				FROM         
					comm_configure AS cc CROSS JOIN
						comm_customer_master AS s INNER JOIN
							comm_salesperson_code_map AS sm 
							ON s.salesperson_cd = sm.salesperson_cd
				WHERE     
					sm.comm_plan_id LIKE 'FSC%'
				GROUP BY 
					cc.current_fiscal_yearmo_num, 
					sm.salesperson_key_id
				Set @nErrorCode = @@Error
			END
		END
	END
END

if (@bDebug <> 0)
	Set @nErrorCode = 512

-- Call error message on Error
if (@nErrorCode <> 0)
Begin
	Set @sMessage = 'comm_transaction_sales_history_calc_proc'
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
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

