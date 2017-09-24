
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/******************************************************************************
**	File: 
**	Name: comm_ess_statement_export02
**	Desc: commission summary recordset used by Access report front-end Bonus
**
**              
**
**	Auth: tmc
**	Date: 18 June 07
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-------	-------		-------------------------------------------
**	19 Jun 07	tmc		removed LY from bonus summary as it will be stored offline
**	27 Jan 10	tmc		Updated for Comm 2010
**	02 Dec 10	tmc		Trim SalespersonID and BranchNM
**  01 Apr 13	tmc		Add ESS commission plan (to filter out retired plans
**    
*******************************************************************************/

ALTER VIEW [dbo].[comm_ess_statement_export02]
AS
SELECT   
	m.employee_num,
	RTRIM(m.salesperson_key_id) as salesperson_key_id, 
	m.salesperson_nm, 
	m.hsi_salesperson_cd,

	-- Group (01)= BONPEL
	BONPEL_SALES_CM_AMT,
	BONPEL_SALES_YTD_AMT,
	BONPEL_GP_CM_AMT,
	BONPEL_GP_YTD_AMT,


	-- Group (02)= BONKAV
	BONKAV_SALES_CM_AMT,
	BONKAV_SALES_YTD_AMT,
	BONKAV_GP_CM_AMT,
	BONKAV_GP_YTD_AMT,

	-- Group (03)= BONSIR
	BONSIR_SALES_CM_AMT,
	BONSIR_SALES_YTD_AMT,
	BONSIR_GP_CM_AMT,
	BONSIR_GP_YTD_AMT,

	-- Added 1 Apr 13
	m.comm_plan_id as ESS_comm_plan_id


FROM         
	(
	SELECT     
		ss.salesperson_key_id, 

		-- Group (01)= BONPEL
		Sum(Case When comm_group_cd = 'BONPEL' Then ss.sales_curr_amt Else 0 End) as					BONPEL_SALES_CM_AMT,
		Sum(Case When comm_group_cd = 'BONPEL' Then ss.sales_ytd_amt + ss.sales_curr_amt Else 0 End) as BONPEL_SALES_YTD_AMT,
		Sum(Case When comm_group_cd = 'BONPEL' Then ss.gp_curr_amt Else 0 End) as						BONPEL_GP_CM_AMT,
		Sum(Case When comm_group_cd = 'BONPEL' Then ss.gp_ytd_amt + ss.gp_curr_amt Else 0 End) as		BONPEL_GP_YTD_AMT,


		-- Group (02)= BONKAV
		Sum(Case When comm_group_cd = 'BONKAV' Then ss.sales_curr_amt Else 0 End) as					BONKAV_SALES_CM_AMT,
		Sum(Case When comm_group_cd = 'BONKAV' Then ss.sales_ytd_amt + ss.sales_curr_amt Else 0 End) as BONKAV_SALES_YTD_AMT,
		Sum(Case When comm_group_cd = 'BONKAV' Then ss.gp_curr_amt Else 0 End) as						BONKAV_GP_CM_AMT,
		Sum(Case When comm_group_cd = 'BONKAV' Then ss.gp_ytd_amt + ss.gp_curr_amt Else 0 End) as		BONKAV_GP_YTD_AMT,

		-- Group (03)= BONSIR
		Sum(Case When comm_group_cd = 'BONSIR' Then ss.sales_curr_amt Else 0 End) as					BONSIR_SALES_CM_AMT,
		Sum(Case When comm_group_cd = 'BONSIR' Then ss.sales_ytd_amt + ss.sales_curr_amt Else 0 End) as BONSIR_SALES_YTD_AMT,
		Sum(Case When comm_group_cd = 'BONSIR' Then ss.gp_curr_amt Else 0 End) as						BONSIR_GP_CM_AMT,
		Sum(Case When comm_group_cd = 'BONSIR' Then ss.gp_ytd_amt + ss.gp_curr_amt Else 0 End) as		BONSIR_GP_YTD_AMT



	FROM         
		comm_summary AS ss 
	WHERE   
		comm_group_cd <> '' and
		salesperson_key_id <> ''
	GROUP BY 
		ss.salesperson_key_id 
	) as s
 
		INNER JOIN comm_salesperson_master m
		ON s.salesperson_key_id = m.salesperson_key_id 

WHERE     
	(m.comm_plan_id like 'ESS%')
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

