
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/******************************************************************************
**	File: 
**	Name: comm_ess_statement_history
**	Desc: commission summary recordset used by Access report front-end Sales History
**
**              
**
**	Auth: tmc
**	Date: 02 Mar 08
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-------	-------		-------------------------------------------
**  01 Apr 13	tmc		Add ESS commission plan (to filter out retired plans
**    
*******************************************************************************/

ALTER VIEW [dbo].[comm_ess_statement_history]
AS
SELECT     
	employee_num, 
	m.salesperson_key_id as ESS_key_id, 
	salesperson_nm as ESS_nm, 
	hsi_salesperson_cd as ESS_code, 

	s.M01_HSTEQU,
	s.M02_HSTEQU,
	s.M03_HSTEQU,
	s.M04_HSTEQU,
	s.M05_HSTEQU,
	s.M06_HSTEQU,
	s.M07_HSTEQU,
	s.M08_HSTEQU,
	s.M09_HSTEQU,
	s.M10_HSTEQU,
	s.M11_HSTEQU,
	s.M12_HSTEQU,

	-- Added 1 Apr 13
	m.comm_plan_id as ESS_comm_plan_id

FROM         
	comm_salesperson_master AS m
		LEFT JOIN 
		(
		SELECT     
			sh.salesperson_key_id, 

			-- Month (01)
			Sum(Case When report_group_2_cd = 'EQUIPMENT' And	month_num = '01' Then sh.sales_amt Else 0 End) as 'M01_HSTEQU',

			-- Month (02)
			Sum(Case When report_group_2_cd = 'EQUIPMENT' And	month_num = '02' Then sh.sales_amt Else 0 End) as 'M02_HSTEQU',

			-- Month (03)
			Sum(Case When report_group_2_cd = 'EQUIPMENT' And	month_num = '03' Then sh.sales_amt Else 0 End) as 'M03_HSTEQU',

			-- Month (04)
			Sum(Case When report_group_2_cd = 'EQUIPMENT' And	month_num = '04' Then sh.sales_amt Else 0 End) as 'M04_HSTEQU',

			-- Month (05)
			Sum(Case When report_group_2_cd = 'EQUIPMENT' And	month_num = '05' Then sh.sales_amt Else 0 End) as 'M05_HSTEQU',

			-- Month (06)
			Sum(Case When report_group_2_cd = 'EQUIPMENT' And	month_num = '06' Then sh.sales_amt Else 0 End) as 'M06_HSTEQU',

			-- Month (07)
			Sum(Case When report_group_2_cd = 'EQUIPMENT' And	month_num = '07' Then sh.sales_amt Else 0 End) as 'M07_HSTEQU',

			-- Month (08)
			Sum(Case When report_group_2_cd = 'EQUIPMENT' And	month_num = '08' Then sh.sales_amt Else 0 End) as 'M08_HSTEQU',

			-- Month (09)
			Sum(Case When report_group_2_cd = 'EQUIPMENT' And	month_num = '09' Then sh.sales_amt Else 0 End) as 'M09_HSTEQU',

			-- Month (10)
			Sum(Case When report_group_2_cd = 'EQUIPMENT' And	month_num = '10' Then sh.sales_amt Else 0 End) as 'M10_HSTEQU',

			-- Month (11)
			Sum(Case When report_group_2_cd = 'EQUIPMENT' And	month_num = '11' Then sh.sales_amt Else 0 End) as 'M11_HSTEQU',

			-- Month (12)
			Sum(Case When report_group_2_cd = 'EQUIPMENT' And	month_num = '12' Then sh.sales_amt Else 0 End) as 'M12_HSTEQU'

		FROM         
			comm_sales_history AS sh 

			INNER JOIN comm_batch_control AS bc 
			ON sh.fiscal_yearmo_num = bc.fiscal_yearmo_num 

				INNER JOIN comm_group AS cg 
				ON sh.comm_group_cd = cg.comm_group_cd 

					INNER JOIN comm_configure AS cc 
					ON bc.year_num = cc.current_year_num

		WHERE     
			(cg.report_group_2_cd IN ('EQUIPMENT'))
		GROUP BY 
			sh.salesperson_key_id
		) s
		ON m.salesperson_key_id = s.salesperson_key_id
WHERE     
	(m.comm_plan_id LIKE 'ESS%')
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

