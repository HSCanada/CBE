
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
**	06 Mar 18	tmc		Add Branch Material to CCS bonus
**    
*******************************************************************************/

ALTER VIEW [dbo].[comm_ess_statement_export02]
AS
SELECT   
	''	AS ccs_employee_num
	,'' AS ccs_salesperson_key_id
	,'' AS ccs_salesperson_nm
	,'' AS ccs_salesperson_cd
	,[branch_nm] 

	-- Group (01)= BONPEL
	,BON_DIGMAT_SALES_CM_AMT
	,BON_DIGMAT_SALES_YTD_AMT
	,BON_DIGMAT_GP_CM_AMT
	,BON_DIGMAT_GP_YTD_AMT


FROM         
	(
	SELECT     
		branch_nm, 

		-- Group (01)= BONPEL
		Sum(Case When comm_group_cd = 'DIGMAT' Then ss.sales_curr_amt Else 0 End) as					BON_DIGMAT_SALES_CM_AMT,
		Sum(Case When comm_group_cd = 'DIGMAT' Then ss.sales_ytd_amt + ss.sales_curr_amt Else 0 End) as BON_DIGMAT_SALES_YTD_AMT,
		Sum(Case When comm_group_cd = 'DIGMAT' Then ss.gp_curr_amt Else 0 End) as						BON_DIGMAT_GP_CM_AMT,
		Sum(Case When comm_group_cd = 'DIGMAT' Then ss.gp_ytd_amt + ss.gp_curr_amt Else 0 End) as		BON_DIGMAT_GP_YTD_AMT

	FROM         
		comm_summary AS ss 

		INNER JOIN comm_salesperson_master m
		ON ss.salesperson_key_id = m.salesperson_key_id 

		INNER JOIN dbo.comm_branch AS b
		ON m.branch_cd = b.branch_cd 

	WHERE   
		(m.comm_plan_id like 'FSC%') AND
		ss.salesperson_key_id <> 'Internal'
	GROUP BY 
		branch_nm
	) as s
 
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- SELECT TOP 10 * FROM [comm_ess_statement_export02]
