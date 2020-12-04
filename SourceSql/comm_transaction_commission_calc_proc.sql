set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[comm_transaction_commission_calc_proc] 
	@bDebug as smallint = 1
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
--	24 Feb 16	tmc		Finalize Automation (SM EQ optout, Booking), remove legacy, and set Debug to default
--	29 Feb 16	tmc		fix small but so that batch 10 is valid
--	29 Nov 20	tmc		add edge case:  Special Market, Equipment only. opt=X
**    
*******************************************************************************/

Declare @nErrorCode int, @nTranCount int
Declare @sMessage varchar(255)

Set @nErrorCode = @@Error
Set @nTranCount = @@Trancount

Declare @sCurrentFiscalYearmoNum char(6)
Declare @nBatchStatus int

SET NOCOUNT ON;
if (@bDebug <> 0)
	SET NOCOUNT OFF;

if (@bDebug <> 0) 
Begin
	Print '---------------------------------------------------------'
	Print 'Proc: comm_transaction_commission_calc_proc'
	Print 'Desc: Calculate commission tranaction details'
	Print 'Mode: DEBUG'
	Print '---------------------------------------------------------'
End

------------------------------------------------------------------------------------------------------------
-- Init routines.  
------------------------------------------------------------------------------------------------------------

Set @sCurrentFiscalYearmoNum = ''
Set @nBatchStatus = -1

-- Start transaction
if (@nTranCount = 0)
	Begin Tran mytran
Else
	Save Tran mytran

if (@bDebug <> 0)
	Print 'Get Current Fiscal Month'

If (@nErrorCode = 0) 
Begin
	Select 	
		@sCurrentFiscalYearmoNum = current_fiscal_yearmo_num
	From 
		comm_configure

	Set @nErrorCode = @@Error
End

if (@bDebug <> 0)
	Print 'Get BatchStatus'
	
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


------------------------------------------------------------------------------------------------------------
-- Update routines.  
------------------------------------------------------------------------------------------------------------

if (@bDebug <> 0)
Begin
	Print 'Confirm BatchStatus Loaded and NOT locked'
	Print @sCurrentFiscalYearmoNum
	Print Convert(varchar, @nBatchStatus)
End

--	29 Feb 16	tmc		fix small but so that batch 10 is valid
If (@nBatchStatus >= 10 and @nBatchStatus < 999)
Begin

	if (@bDebug <> 0)
		Print 'Set:  FSC SalespersonKey and Plan'

	If (@nErrorCode = 0) 
	Begin

		UPDATE    
			comm_transaction
		SET              
			salesperson_key_id = s.salesperson_key_id, 
			comm_plan_id = s.comm_plan_id
		FROM         
			comm_transaction t

			INNER JOIN comm_salesperson_code_map AS s 
			ON t.salesperson_cd = s.salesperson_cd

		WHERE     
			(t.fiscal_yearmo_num = @sCurrentFiscalYearmoNum) AND 
			(t.salesperson_cd <> '') AND 
			( (t.comm_plan_id <> s.comm_plan_id) OR (t.salesperson_key_id <> s.salesperson_key_id) )


		Set @nErrorCode = @@Error
	End

--	24 Feb 16	tmc		Finalize Automation (SM EQ optout, Booking), remove legacy, and set Debug to default

	if (@bDebug <> 0)
		Print 'Set:  ItemCommGroup Codes (with special market and Equipment opt out logic)'

	If (@nErrorCode = 0) 
	Begin

		UPDATE    
			comm_transaction
		SET              
			item_comm_group_cd =	CASE 
										WHEN 
											( (c.SPM_StatusCd = 'Y') And ( (c.SPM_EQOptOut <> 'Y') OR  ( (c.SPM_EQOptOut = 'Y') AND (g.SPM_EQOptOut<>'Y') ))) OR
											-- Special Market EQ only special case
											(( c.SPM_StatusCd = 'N') AND (c.SPM_EQOptOut = 'X') AND (g.SPM_EQOptOut = 'Y'))
										THEN 
											-- Use Special Market code
											g.SPM_comm_group_cd 
										ELSE 
											-- Use Regular code
											g.comm_group_cd 
									END
	
		FROM         

			comm_transaction t

			INNER JOIN comm_customer_master AS c 
			ON t.hsi_shipto_id = c.hsi_shipto_id 

			INNER JOIN comm_item_master AS i 
			ON t.item_id = i.item_id 

			INNER JOIN comm_group AS g 
			ON i.comm_group_cd = g.comm_group_cd

		WHERE     
			(t.fiscal_yearmo_num = @sCurrentFiscalYearmoNum) AND 
			(t.source_cd = 'JDE') AND
			(t.comm_plan_id LIKE 'FSC%') AND 
			(1=1)

		Set @nErrorCode = @@Error
	End


-- Fix Parts, 4 Feb 15, tmc
	if (@bDebug <> 0)
		Print 'Override:  ItemCommGroup for Parts on EQ Orders'

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
				tt.comm_plan_id <> '' And
				tt.source_cd = 'JDE' And
				tt.order_source_cd IN ('A','L') And		-- Astea  EQ and Service
				tt.ess_salesperson_cd <>'' And			-- Exclude Service (No ESS code)
				tt.item_comm_group_cd = 'ITMPAR' And	-- ONLY effect Parts 
				1=1
			) t
		Where 
			(s.fiscal_yearmo_num = @sCurrentFiscalYearmoNum ) AND
			(s.record_id = t.record_id) AND
			(1=1)


		Set @nErrorCode = @@Error
	End

-- Add Booking rate, 24 Feb 16
	if (@bDebug <> 0)
		Print 'Override:  FSC Booking Rate GP'

	If (@nErrorCode = 0) 
	Begin
		UPDATE    
			comm_transaction
		SET              
			gp_ext_amt = t.transaction_amt * (g.booking_rt / 100.0)
		FROM         
			comm_transaction as t
			
			INNER JOIN comm_group AS g 
			ON t.item_comm_group_cd = g.comm_group_cd

		WHERE     
			(g.booking_rt > 0)  AND 
			(t.fiscal_yearmo_num = @sCurrentFiscalYearmoNum )
	End


	
	if (@bDebug <> 0)
		Print 'Set:  ItemCommGroup Rates'


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
			(t.fiscal_yearmo_num = @sCurrentFiscalYearmoNum) AND 
			(t.source_cd IN ('JDE', 'IMPORT')) AND 
			(t.comm_plan_id LIKE 'FSC%') AND 
			(1 = 1)

		Set @nErrorCode = @@Error
	End


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
			status_cd = 20
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
	Set @sMessage = 'comm_transaction_commission_calc_proc'
	Set @sMessage = @sMessage + ':  Return(' + Convert(varchar, @nErrorCode) + ')'
	Set @sMessage = @sMessage +  ', ' + convert(varchar, @bDebug)

	RAISERROR ('%s', 9, 1, @sMessage )

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


-- Debug
-- Exec comm_transaction_commission_calc_proc

-- Prod
-- Exec comm_transaction_commission_calc_proc 0

/*
-- SM Opt-out i test
SELECT     
	t.fiscal_yearmo_num, 
	t.source_cd,         
	t.salesperson_cd,
	t.salesperson_key_id, 
	t.comm_plan_id,
	t.hsi_shipto_id,
	[doc_id],
	[gp_ext_amt],

	c.SPM_StatusCd AS CustSMStatus,
	c.SPM_EQOptOut AS CustEQOpt,

	g.SPM_EQOptOut AS GroupSPM_EQOptOut,
	g.comm_group_cd,
	g.SPM_comm_group_cd AS GroupSPM_comm_group_cd,
	t.item_comm_group_cd AS item_comm_group_cd_CURR,

	CASE
		WHEN
			( (c.SPM_StatusCd = 'Y') And ( (c.SPM_EQOptOut <> 'Y') OR  ( (c.SPM_EQOptOut = 'Y') AND (g.SPM_EQOptOut<>'Y') ))) OR
			-- Special Market EQ only special case
			(( c.SPM_StatusCd = 'N') AND (c.SPM_EQOptOut = 'X') AND (g.SPM_EQOptOut = 'Y'))
		THEN 
			'SM'
		ELSE
			'REG'
	END as sm_flag,

	CASE 
		WHEN 
			( (c.SPM_StatusCd = 'Y') And ( (c.SPM_EQOptOut <> 'Y') OR  ( (c.SPM_EQOptOut = 'Y') AND (g.SPM_EQOptOut<>'Y') ))) OR
			-- Special Market EQ only special case
			(( c.SPM_StatusCd = 'N') AND (c.SPM_EQOptOut = 'X') AND (g.SPM_EQOptOut = 'Y'))
		THEN 
			-- Use Special Market code
			g.SPM_comm_group_cd 
		ELSE 
			-- Use Regular code
			g.comm_group_cd 
	END AS item_comm_group_cd_NEW

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
	(t.fiscal_yearmo_num = '202010') AND 
	(t.source_cd = 'JDE') AND
	(t.comm_plan_id LIKE 'FSC%') AND 
	-- bug
	([doc_id] = '13647728') AND

--	(c.SPM_StatusCd = 'N' ) AND
--	(c.SPM_EQOptOut = 'Y' ) AND
--	(g.SPM_EQOptOut <> 'Y' ) AND
	(1=1)
ORDER BY t.item_comm_group_cd

*/

/*
--	TEST: 29 Nov 20	tmc		add edge case:  Special Market, Equipment only. opt=X

SELECT
	t.fiscal_yearmo_num, 
	SUM(t.gp_ext_amt) AS gp,
	c.comm_status_cd, 
	c.SPM_StatusCd AS CustSMStatus, 
	c.SPM_EQOptOut AS CustEQOpt,
	g.SPM_EQOptOut AS GroupSPM_EQOptOut, 
	CASE 
		WHEN 
			((c.SPM_StatusCd = 'Y') AND ((c.SPM_EQOptOut <> 'Y') OR ((c.SPM_EQOptOut = 'Y') AND (g.SPM_EQOptOut <> 'Y')))) OR
			-- Special Market EQ only special case
			(( c.SPM_StatusCd = 'N') AND (c.SPM_EQOptOut = 'X') AND (g.SPM_EQOptOut = 'Y'))
		THEN 'SM' 
		ELSE 'REG' 
	END AS sm_flag
FROM            comm_transaction AS t INNER JOIN
                         comm_plan AS p ON t.comm_plan_id = p.comm_plan_id INNER JOIN
                         comm_customer_master AS c ON t.hsi_shipto_id = c.hsi_shipto_id INNER JOIN
                         comm_item_master AS i ON t.item_id = i.item_id INNER JOIN
                         comm_group AS g ON i.comm_group_cd = g.comm_group_cd
WHERE
	(t.comm_plan_id LIKE 'FSC%') AND 
	(t.fiscal_yearmo_num = '202010') AND 
	(t.source_cd = 'JDE') AND
	(1 = 1)
GROUP BY t.fiscal_yearmo_num, t.source_cd, c.comm_status_cd, c.SPM_StatusCd, c.SPM_EQOptOut, g.SPM_EQOptOut
*/