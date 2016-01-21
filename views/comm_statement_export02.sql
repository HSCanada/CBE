
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/******************************************************************************
**	File: 
**	Name: comm_statement_export02
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
**	28 Mar 11	tmc		switch Biolase bonus with BDMs
**    
*******************************************************************************/

ALTER VIEW [dbo].[comm_statement_export02]
AS
SELECT   
	m.employee_num,
	RTRIM(m.salesperson_key_id) as salesperson_key_id, 
	m.salesperson_nm, 
	m.hsi_salesperson_cd,

	-- Group (01)= BONBIO
	BONBDM_QTY_CM_AMT,
	BONBDM_QTY_YTD_AMT,
	BONBDM_GP_CM_AMT,
	BONBDM_GP_YTD_AMT,

	-- Group (02)= BONE4D
	BONE4D_SALES_CM_AMT,
	BONE4D_SALES_YTD_AMT,
	BONE4D_GP_CM_AMT,
	BONE4D_GP_YTD_AMT,
	BONE4D_QTY_CM_AMT,
	BONE4D_QTY_YTD_AMT

FROM         
	(
	SELECT     
		ss.salesperson_key_id, 

		-- Group (01)= BONBIO
		-- swapped BONBIO
		Sum(Case When comm_group_cd = 'BONBDM' Then ss.sales_curr_amt Else 0 End) as					BONBDM_QTY_CM_AMT,
		Sum(Case When comm_group_cd = 'BONBDM' Then ss.sales_ytd_amt + ss.sales_curr_amt Else 0 End) as BONBDM_QTY_YTD_AMT,
		Sum(Case When comm_group_cd = 'BONBDM' Then ss.gp_curr_amt Else 0 End) as						BONBDM_GP_CM_AMT,
		Sum(Case When comm_group_cd = 'BONBDM' Then ss.gp_ytd_amt + ss.gp_curr_amt Else 0 End) as		BONBDM_GP_YTD_AMT,

		-- Group (02)= BONE4D
		Sum(Case When comm_group_cd = 'BONE4D' Then ss.sales_curr_amt Else 0 End) as					BONE4D_SALES_CM_AMT,
		Sum(Case When comm_group_cd = 'BONE4D' Then ss.sales_ytd_amt + ss.sales_curr_amt Else 0 End) as BONE4D_SALES_YTD_AMT,
		Sum(Case When comm_group_cd = 'BONE4D' Then ss.gp_curr_amt Else 0 End) as						BONE4D_GP_CM_AMT,
		Sum(Case When comm_group_cd = 'BONE4D' Then ss.gp_ytd_amt + ss.gp_curr_amt Else 0 End) as		BONE4D_GP_YTD_AMT,

		-- Use Cost for Qty field
		Sum(Case When comm_group_cd = 'BONE4D' Then ss.costs_curr_amt Else 0 End) as					BONE4D_QTY_CM_AMT,
		Sum(Case When comm_group_cd = 'BONE4D' Then ss.costs_ytd_amt + ss.costs_curr_amt Else 0 End) as	BONE4D_QTY_YTD_AMT



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
	(m.comm_plan_id like 'FSC%')
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

