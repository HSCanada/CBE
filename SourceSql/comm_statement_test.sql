
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/******************************************************************************
**	File: 
**	Name: comm_statement_test
**	Desc: commission summary recordset used by Access report front-end
**
**              
**
**	Auth: tmc
**	Date: 6 Aug 20
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-------	-------		-------------------------------------------
**    
*******************************************************************************/
ALTER VIEW [dbo].[comm_statement_test]
AS
SELECT 
	m.employee_num							AS EmployeeNumber
	,comm_group_map.disp_comm_group_cd		AS CommGroupCode
--	,min(s.comm_group_cd) as mr
	,MIN(m.comm_plan_id)					AS CommPlanCode

	,SUM(s.sales_curr_amt)					AS MTD_Sales
	,SUM(s.sales_ref_amt)					AS PY_MTD_Sales

	,SUM(s.gp_curr_amt)						AS MTD_Comm
	,SUM(s.gp_ly_amt + s.gp_ref_amt)		AS PY_MTD_GP

	,SUM(s.sales_ytd_amt + s.sales_curr_amt)AS YTD_Sales
	,SUM(s.sales_ly_amt + s.sales_ref_amt)	AS PY_YTD_Sales

	,SUM(s.gp_ytd_amt + s.gp_curr_amt)		AS YTD_GP
	,SUM(s.gp_ref_amt)						AS PY_YTD_GP

	,SUM(s.comm_curr_amt)					AS COMM_CM_AMT
FROM         
	dbo.comm_summary AS s

	INNER JOIN dbo.comm_salesperson_master AS m 
	ON s.salesperson_key_id = m.salesperson_key_id 

	LEFT JOIN [CommBE].[dbo].comm_plan_group_rate as comm_group_map
	ON m.comm_plan_id = comm_group_map.comm_plan_id AND
	s.comm_group_cd = comm_group_map.comm_group_cd

WHERE      
	(m.comm_plan_id <> '') AND
	(s.comm_group_cd <> '') AND 
	(s.salesperson_key_id <> '') AND
	(ISNULL(comm_group_map.disp_comm_group_cd,'') <> '') AND
	(1=1)
GROUP BY 
    m.employee_num
	,comm_group_map.disp_comm_group_cd

GO

-- SELECT * FROM comm_statement_test