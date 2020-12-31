SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE comm_legacy_sync_proc
	@bDebug as smallint = 1
AS
/******************************************************************************
**	File:	
**	Name: comm_legacy_sync_proc
**	Desc: sync commission groups from new to legacy
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
**	Date: 21 Jun 20
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**	04 Aug 20	tmc		fix bug where synch failed -- had AND instead of OR.  
**						missed during testing, month 1
**	28 Dec 20	tmc		remove non-core plans (EST, CPS, ISR, etc) from sync
**    
*******************************************************************************/

Declare @nErrorCode int, @nTranCount int, @nRowCount int
Declare @sMessage varchar(255)

Set @nErrorCode = @@Error
Set @nTranCount = @@Trancount
Set @nRowCount	= @@ROWCOUNT

SET NOCOUNT ON;
if (@bDebug <> 0)
	SET NOCOUNT OFF;

if (@bDebug <> 0) 
Begin
	Print '---------------------------------------------------------'
	Print 'Proc: comm_legacy_sync_proc'
	Print 'Desc: sync commission groups from new to legacy'
	Print 'Mode: DEBUG'
	Print '---------------------------------------------------------'
End

------------------------------------------------------------------------------------------------------------
-- Init routines.  
------------------------------------------------------------------------------------------------------------
SET NOCOUNT ON;

if (@bDebug <> 0)
	SET NOCOUNT OFF;

-- Start transaction
if (@nTranCount = 0)
	Begin Tran mytran
Else
	Save Tran mytran


------------------------------------------------------------------------------------------------------------
-- Update routines.  
------------------------------------------------------------------------------------------------------------

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '1. item update'
	UPDATE
		[dbo].[comm_item_master]
	SET
		[comm_group_cd]			=s.[comm_group_cd]
		,[comm_group_cps_cd]	=s.[comm_group_cps_cd]
		,[comm_group_eps_cd]	=s.[comm_group_eps_cd]
		,[note_txt]				=ISNULL(s.[comm_note_txt],'')

	FROM
		[BRSales].[dbo].[BRS_Item] AS s
	WHERE
		(s.[Item] = [dbo].[comm_item_master].[item_id]) AND
		(
			(s.[comm_group_cd] <> [dbo].[comm_item_master].[comm_group_cd]) OR
			(s.[comm_group_cps_cd] <> [dbo].[comm_item_master].[comm_group_cps_cd]) OR
			(s.[comm_group_eps_cd] <> [dbo].[comm_item_master].[comm_group_eps_cd]) OR
			(ISNULL(s.[comm_note_txt],'') <> ISNULL([dbo].[comm_item_master].note_txt,''))
		) AND
		(1=1)

	Set @nErrorCode = @@Error
End

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '2. item append'

	INSERT INTO 
		[dbo].[comm_item_master]
	(
		[item_id]
		,item_master_desc
		,[comm_group_cd]
		,[comm_group_cps_cd]
		,[comm_group_eps_cd]
		,[note_txt]
	)
	SELECT
			s.Item
			,s.ItemDescription
			,s.[comm_group_cd]
			,s.[comm_group_cps_cd]
			,s.[comm_group_eps_cd]
			,ISNULL(s.[comm_note_txt],'')
	FROM
		[BRSales].[dbo].[BRS_Item] AS s
	WHERE
		NOT EXISTS 
		(
			SELECT * 
			FROM [dbo].[comm_item_master] d
			WHERE s.[Item] = d.[item_id]
		) AND
		(1=1)

	Set @nErrorCode = @@Error
End

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '3. terr append'

	INSERT INTO 
		[dbo].[comm_salesperson_code_map]
	(
		[salesperson_cd]
		,[salesperson_nm]
	)
	SELECT
			s.[TerritoryCd]
			,s.[FSCName]
	FROM
		[BRSales].[dbo].[BRS_FSC_Rollup] AS s
	WHERE
		NOT EXISTS 
		(
			SELECT * 
			FROM [dbo].[comm_salesperson_code_map] d
			WHERE s.[TerritoryCd] = d.[salesperson_cd]
		) AND
		(1=1)

	Set @nErrorCode = @@Error
End


If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '4. customer update'

	UPDATE
		[dbo].[comm_customer_master]
	SET
		[hsi_billto_id]=s.[BillTo]
		,[customer_nm]= LEFT(s.[PracticeName],30)
		,[ship_postal_num]=s.[PostalCode]
		,[sales_plan_cd]=s.[VPA]
		,[comm_status_cd]=s.[comm_status_cd]
		,[comm_note_txt]=ISNULL(s.[comm_note_txt],'')
		,[salesperson_cd]=s.[TerritoryCd]
		,[eps_code]=LEFT(s.[eps_code],5)
		,[cps_code]=LEFT(s.[cps_code],5)
	FROM
		[BRSales].[dbo].[BRS_Customer] AS s
	WHERE
		(s.ShipTo = [dbo].[comm_customer_master].[hsi_shipto_id]) AND
		(
			s.[BillTo] <> [hsi_billto_id] OR
			CAST(LEFT(s.[PracticeName],30) as varchar) <> [customer_nm] OR
			s.[PostalCode] <> [ship_postal_num] OR
			s.[VPA] <> [sales_plan_cd] OR
			s.[comm_status_cd] <> [dbo].[comm_customer_master].[comm_status_cd] OR
			ISNULL(s.[comm_note_txt],'') <> ISNULL([dbo].[comm_customer_master].[comm_note_txt],'') OR
			s.[TerritoryCd] <> LEFT([salesperson_cd],5) OR
			s.[eps_code] <> LEFT([dbo].[comm_customer_master].[eps_code],5) OR
			s.[cps_code] <> LEFT([dbo].[comm_customer_master].[cps_code],5) 
		) AND
		(1=1)

	Set @nErrorCode = @@Error
End


If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '5. customer append'

	INSERT INTO 
		[dbo].[comm_customer_master]
	(
		[hsi_shipto_id]
		,[hsi_billto_id]
		,[customer_nm]
		,[ship_postal_num]
		,[sales_plan_cd]
		,[comm_status_cd]
		,[comm_note_txt]
		,[salesperson_cd]
		,[eps_code]
		,[cps_code]
	)
	SELECT 
		s.shipto
		,s.[BillTo]
		,LEFT(s.[PracticeName],30)
		,s.[PostalCode]
		,s.[VPA]
		,s.[comm_status_cd]
		,ISNULL(s.[comm_note_txt],'')
		,s.[TerritoryCd]
		,LEFT(s.[eps_code],5)
		,LEFT(s.[cps_code],5)
	FROM
		[BRSales].[dbo].[BRS_Customer] AS s
	WHERE
		NOT EXISTS 
		(
			SELECT * 
			FROM [dbo].[comm_customer_master] d
			WHERE d.hsi_shipto_id = s.ShipTo
		) AND
		(1=1)

	Set @nErrorCode = @@Error
End

-- convert SM to legacy Y & N
If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '5b. customer SM update'

	UPDATE
		[dbo].[comm_customer_master]
	SET
		[SPM_StatusCd]=m.[SPM_StatusCd]
		,[SPM_EQOptOut]=m.[SPM_EQOptOut]
	FROM
		[dbo].[comm_special_market_legacy_map] AS m
	WHERE
		(m.[cust_comm_group_cd]=[dbo].[comm_customer_master].comm_status_cd) AND
		(
			(m.[SPM_StatusCd] <> [dbo].[comm_customer_master].[SPM_StatusCd]) OR
			(m.[SPM_EQOptOut] <> [dbo].[comm_customer_master].[SPM_EQOptOut])
		) AND
		(1=1)

	Set @nErrorCode = @@Error
End


If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '6. salesperson_master - Update'

	UPDATE 
		[dbo].[comm_salesperson_master]
	SET
		[FiscalMonth]=s.[FiscalMonth]
		,[employee_num] = s.[employee_num]
		,[master_salesperson_cd] = s.[master_salesperson_cd] 
		,[salesperson_nm] = s.[salesperson_nm]
		,[comm_plan_id] = s.[comm_plan_id]
		,territory_start_dt = s.territory_start_dt
		,[CostCenter]=s.[CostCenter]
		,[salary_draw_amt]= s.[salary_draw_amt]
		,[deficit_amt]=s.[deficit_amt]
		,[note_txt] = ISNULL(s.[note_txt],'')
		,[esend_setup_ind] = ISNULL(s.[flag_ind],0)

	-- test
--	select s.*, [comm_salesperson_master].FiscalMonth
	--
	FROM  
		[BRSales].[comm].[salesperson_master] s

	-- test
--	,[comm_salesperson_master]
	--
	WHERE
		(s.salesperson_key_id = [dbo].[comm_salesperson_master].salesperson_key_id) AND
		LEFT(ISNULL(s.comm_plan_id, ''),3) in ('FSC', 'ESS', 'CCS' ) AND

		-- test
--		s.salesperson_key_id = 'afolk' AND
		--
		(
			(s.[employee_num] <> s.[employee_num]) OR
			(s.[master_salesperson_cd] <> s.[master_salesperson_cd]) OR
			(s.FiscalMonth <> [dbo].[comm_salesperson_master].[FiscalMonth]) OR
			(s.[salesperson_nm] <> [dbo].[comm_salesperson_master].[salesperson_nm]) OR
			(s.[comm_plan_id] <> [dbo].[comm_salesperson_master].[comm_plan_id]) OR
			(s.territory_start_dt <> [dbo].[comm_salesperson_master].territory_start_dt) OR
			(s.[CostCenter] <> [dbo].[comm_salesperson_master].[CostCenter]) OR
			(s.[salary_draw_amt] <> [dbo].[comm_salesperson_master].[salary_draw_amt]) OR
			(s.[deficit_amt] <> [dbo].[comm_salesperson_master].[deficit_amt]) OR
			(ISNULL(s.[note_txt],'') <>LEFT(ISNULL([dbo].[comm_salesperson_master].[note_txt],''),50)) OR
			(ISNULL(s.[flag_ind],0) <> [esend_setup_ind]) 
--			(1=1)
		) AND
		(1=1)

	Set @nErrorCode = @@Error
End


If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '7. salesperson_master - Add'

	INSERT INTO [dbo].[comm_salesperson_master]
	(
		[salesperson_key_id]
		,[salesperson_nm]
		,[salesperson_category_cd]
		,[comm_plan_id]
		,[note_txt]
		,[master_salesperson_cd]
		,[territory_start_dt]
		,[esend_setup_ind]
		,[employee_num]
		,[CostCenter]
		,[salary_draw_amt]
		,[deficit_amt]
		,[FiscalMonth]
	)
	SELECT        
		[salesperson_key_id]
		,[salesperson_nm]
		,''
		,[comm_plan_id]
		,[note_txt]
		,[master_salesperson_cd]
		,territory_start_dt
		,ISNULL([flag_ind],0)
		,[employee_num]
		,[CostCenter]
		,[salary_draw_amt]
		,[deficit_amt]
		,[FiscalMonth]
	FROM
		[BRSales].[comm].[salesperson_master] s
	WHERE 
		salesperson_key_id <> '' AND 
		-- synch core plans only
		LEFT(ISNULL(s.comm_plan_id, ''),3) in ('FSC', 'ESS', 'CCS' ) AND
		NOT EXISTS
		(
			SELECT * FROM [dbo].[comm_salesperson_master] d
			WHERE (s.salesperson_key_id = d.salesperson_key_id) 
		)

	Set @nErrorCode = @@Error
End

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '8. terr update'

	UPDATE
		[dbo].[comm_salesperson_code_map]
	SET
		[salesperson_nm]		= s.[FSCName]
		,[salesperson_id]		= s.[order_taken_by]
		,[branch_cd]			= s.[Branch]
		,[salesperson_key_id]	= ISNULL(s.[comm_salesperson_key_id],'')
		,[comm_plan_id]			= ISNULL(m.comm_plan_id, '')
	FROM
		[BRSales].[dbo].[BRS_FSC_Rollup] AS s
		LEFT JOIN [BRSales].[comm].[salesperson_master] m
		ON m.salesperson_key_id = s.comm_salesperson_key_id
	WHERE
		-- synch core plans only
		LEFT(ISNULL(m.comm_plan_id, ''),3) in ('FSC', 'ESS', 'CCS' ) AND
		(s.TerritoryCd = [dbo].[comm_salesperson_code_map].[salesperson_cd]) AND
		(
			(s.[FSCName] <> [dbo].[comm_salesperson_code_map].[salesperson_nm]) OR
			(s.[order_taken_by] <> [salesperson_id]) OR
			(s.[Branch] <> [branch_cd]) OR
			(ISNULL(s.[comm_salesperson_key_id],'') <> [comm_salesperson_key_id])
		) AND
		(1=1)

	Set @nErrorCode = @@Error
End


------------------------------------------------------------------------------------------------------------
-- Wrap-up routines.  
------------------------------------------------------------------------------------------------------------

-- force error in debug
if (@bDebug <> 0 AND @nErrorCode = 0)
	Set @nErrorCode = 512

-- Call error message on Error
if (@nErrorCode <> 0)
Begin
	Set @sMessage = 'comm_sync_proc'
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

-- Prod
-- EXEC comm_legacy_sync_proc @bDebug=0

-- Debug, 40s
-- EXEC comm_legacy_sync_proc @bDebug=1
