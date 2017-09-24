
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/******************************************************************************
**	File: 
**	Name: comm_statement_summary
**	Desc: commission summary recordset used by Access report front-end
**
**              
**
**	Auth: tmc
**	Date: 9 Aug 06
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-------	-------		-------------------------------------------
**	11 Mar 07	tmc		Added LY * LYTD to show growth
**    
*******************************************************************************/

ALTER VIEW [dbo].[comm_statement_summary]
AS
SELECT     
	m.salesperson_key_id, 
	s.report_group_1_cd, 
	s.report_group_2_cd, 
	s.report_group_3_cd, 

	m.salesperson_nm, 
	m.master_division_cd, 
	m.master_salesperson_cd, 
	m.comm_plan_id, 
	p.comm_plan_nm, 
	m.salesperson_territory_cd, 
	t.region_desc,
	c.fiscal_yearmo_num, 
	c.fiscal_begin_dt, 
	c.fiscal_end_dt, 
	r2.report_group_txt AS master_report_group_txt, 
	r1.report_group_txt, 
	r2.report_sort_id AS master_report_sort_id, 
	r1.report_sort_id, 
	s.total_sales_curr_amt, 
	s.total_costs_curr_amt, 
	s.total_comm_curr_amt, 
	s.total_sales_ytd_amt, 
	s.total_costs_ytd_amt, 
	s.total_comm_ytd_amt, 
	r2.hide_sales_ind, 
	r2.hide_commission_total_ind,

	c.fiscal_yearmo_txt,
	s.total_sales_ref_amt, 
	s.total_costs_ref_amt, 
	s.total_comm_ref_amt, 

	s.total_sales_ref_ly_amt, 
	s.total_costs_ref_ly_amt, 
	s.total_comm_ref_ly_amt

FROM         
	(
	SELECT     
		ss.salesperson_key_id, 
		g.report_group_1_cd, 
		g.report_group_2_cd, 
		g.report_group_3_cd, 
		SUM(ss.sales_curr_amt) AS total_sales_curr_amt, 
		SUM(ss.costs_curr_amt) AS total_costs_curr_amt, 
		SUM(ss.comm_curr_amt) AS total_comm_curr_amt, 

		SUM(ss.sales_ytd_amt) + SUM(ss.sales_curr_amt) AS total_sales_ytd_amt, 
		SUM(ss.costs_ytd_amt) + SUM(ss.costs_curr_amt) AS total_costs_ytd_amt, 
		SUM(ss.comm_ytd_amt)  + SUM(ss.comm_curr_amt)  AS total_comm_ytd_amt,

		-- add LY's current month and LY's YTD, 11 Mar 07
		SUM(ss.sales_ref_amt) AS total_sales_ref_amt, 
		SUM(ss.costs_ref_amt) AS total_costs_ref_amt, 
		SUM(ss.comm_ref_amt) AS total_comm_ref_amt, 

		SUM(ss.sales_ly_amt) + SUM(ss.sales_ref_amt) AS total_sales_ref_ly_amt, 
		SUM(ss.costs_ly_amt) + SUM(ss.costs_ref_amt) AS total_costs_ref_ly_amt, 
		SUM(ss.comm_ly_amt)  + SUM(ss.comm_ref_amt)  AS total_comm_ref_ly_amt

	FROM         
		comm_summary AS ss 
			INNER JOIN comm_group AS g 
			ON ss.comm_group_cd = g.comm_group_cd 

			INNER JOIN comm_salesperson_master AS m 
			ON ss.salesperson_key_id = m.salesperson_key_id
	WHERE     
		(m.comm_plan_id <>'')
	GROUP BY 
		ss.salesperson_key_id, 
		g.report_group_1_cd, 
		g.report_group_2_cd, 
		g.report_group_3_cd
	) as s
 
		INNER JOIN comm_salesperson_master m
		ON s.salesperson_key_id = m.salesperson_key_id 

		INNER JOIN comm_group_report r1
		ON s.report_group_3_cd = r1.report_group_3_cd AND 
			s.report_group_2_cd = r1.report_group_2_cd AND 
			s.report_group_1_cd = r1.report_group_1_cd

		INNER JOIN comm_group_report AS r2 
		ON s.report_group_1_cd = r2.report_group_1_cd
	                      
		INNER JOIN comm_plan p
		ON m.comm_plan_id = p.comm_plan_id

		INNER JOIN comm_batch_control c
		ON c.fiscal_yearmo_num = (Select current_fiscal_yearmo_num From comm_configure)

		LEFT JOIN comm_salesperson_territory_map t
		ON m.salesperson_territory_cd = t.salesperson_territory_cd


WHERE     
	r2.report_group_2_cd = '' AND 
	r2.report_group_3_cd = '' AND 
    r2.display_ind = 1  AND 
	r1.display_ind = 1
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

