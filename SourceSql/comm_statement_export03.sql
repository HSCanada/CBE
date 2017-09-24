
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/******************************************************************************
**	File: 
**	Name: comm_statement_export03
**	Desc: commission summary recordset used by Access report front-end Sales History
**
**              
**
**	Auth: tmc
**	Date: 24 June 07
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-------	-------		-------------------------------------------
**	02 Dec 10	tmc		Trim SalespersonID and BranchNM
**    
*******************************************************************************/

ALTER VIEW [dbo].[comm_statement_export03]
AS
SELECT     
	employee_num, 
	RTRIM(m.salesperson_key_id) as salesperson_key_id, 
	salesperson_nm, 
	hsi_salesperson_cd, 
	comm_plan_id,

	-- Month (01)
	s.M01_HSTMER,
	s.M01_HSTEQU,
	s.M01_HSTCTL,
	s.M01_HSTCTB,

	-- Month (02)
	s.M02_HSTMER,
	s.M02_HSTEQU,
	s.M02_HSTCTL,
	s.M02_HSTCTB,

	-- Month (03)
	s.M03_HSTMER,
	s.M03_HSTEQU,
	s.M03_HSTCTL,
	s.M03_HSTCTB,

	-- Month (04)
	s.M04_HSTMER,
	s.M04_HSTEQU,
	s.M04_HSTCTL,
	s.M04_HSTCTB,

	-- Month (05)
	s.M05_HSTMER,
	s.M05_HSTEQU,
	s.M05_HSTCTL,
	s.M05_HSTCTB,

	-- Month (06)
	s.M06_HSTMER,
	s.M06_HSTEQU,
	s.M06_HSTCTL,
	s.M06_HSTCTB,

	-- Month (07)
	s.M07_HSTMER,
	s.M07_HSTEQU,
	s.M07_HSTCTL,
	s.M07_HSTCTB,

	-- Month (08)
	s.M08_HSTMER,
	s.M08_HSTEQU,
	s.M08_HSTCTL,
	s.M08_HSTCTB,

	-- Month (09)
	s.M09_HSTMER,
	s.M09_HSTEQU,
	s.M09_HSTCTL,
	s.M09_HSTCTB,

	-- Month (10)
	s.M10_HSTMER,
	s.M10_HSTEQU,
	s.M10_HSTCTL,
	s.M10_HSTCTB,

	-- Month (11)
	s.M11_HSTMER,
	s.M11_HSTEQU,
	s.M11_HSTCTL,
	s.M11_HSTCTB,

	-- Month (12)
	s.M12_HSTMER,
	s.M12_HSTEQU,
	s.M12_HSTCTL,
	s.M12_HSTCTB

FROM         
	comm_salesperson_master AS m
		LEFT JOIN 
		(
		SELECT     
			sh.salesperson_key_id, 

			-- Month (01)
			Sum(Case When report_group_2_cd = 'SUNDRY' And		month_num = '01' Then sh.sales_amt Else 0 End) as 'M01_HSTMER',
			Sum(Case When report_group_2_cd = 'EQUIPMENT' And	month_num = '01' Then sh.sales_amt Else 0 End) as 'M01_HSTEQU',
			Sum(Case When report_group_2_cd = 'HSTCTL' And		month_num = '01' Then sh.customer_count_qty Else 0 End) as 'M01_HSTCTL',
			Sum(Case When report_group_2_cd = 'HSTCTB' And		month_num = '01' Then sh.customer_count_qty Else 0 End) as 'M01_HSTCTB',

			-- Month (02)
			Sum(Case When report_group_2_cd = 'SUNDRY' And		month_num = '02' Then sh.sales_amt Else 0 End) as 'M02_HSTMER',
			Sum(Case When report_group_2_cd = 'EQUIPMENT' And	month_num = '02' Then sh.sales_amt Else 0 End) as 'M02_HSTEQU',
			Sum(Case When report_group_2_cd = 'HSTCTL' And		month_num = '02' Then sh.customer_count_qty Else 0 End) as 'M02_HSTCTL',
			Sum(Case When report_group_2_cd = 'HSTCTB' And		month_num = '02' Then sh.customer_count_qty Else 0 End) as 'M02_HSTCTB',

			-- Month (03)
			Sum(Case When report_group_2_cd = 'SUNDRY' And		month_num = '03' Then sh.sales_amt Else 0 End) as 'M03_HSTMER',
			Sum(Case When report_group_2_cd = 'EQUIPMENT' And	month_num = '03' Then sh.sales_amt Else 0 End) as 'M03_HSTEQU',
			Sum(Case When report_group_2_cd = 'HSTCTL' And		month_num = '03' Then sh.customer_count_qty Else 0 End) as 'M03_HSTCTL',
			Sum(Case When report_group_2_cd = 'HSTCTB' And		month_num = '03' Then sh.customer_count_qty Else 0 End) as 'M03_HSTCTB',

			-- Month (04)
			Sum(Case When report_group_2_cd = 'SUNDRY' And		month_num = '04' Then sh.sales_amt Else 0 End) as 'M04_HSTMER',
			Sum(Case When report_group_2_cd = 'EQUIPMENT' And	month_num = '04' Then sh.sales_amt Else 0 End) as 'M04_HSTEQU',
			Sum(Case When report_group_2_cd = 'HSTCTL' And		month_num = '04' Then sh.customer_count_qty Else 0 End) as 'M04_HSTCTL',
			Sum(Case When report_group_2_cd = 'HSTCTB' And		month_num = '04' Then sh.customer_count_qty Else 0 End) as 'M04_HSTCTB',

			-- Month (05)
			Sum(Case When report_group_2_cd = 'SUNDRY' And		month_num = '05' Then sh.sales_amt Else 0 End) as 'M05_HSTMER',
			Sum(Case When report_group_2_cd = 'EQUIPMENT' And	month_num = '05' Then sh.sales_amt Else 0 End) as 'M05_HSTEQU',
			Sum(Case When report_group_2_cd = 'HSTCTL' And		month_num = '05' Then sh.customer_count_qty Else 0 End) as 'M05_HSTCTL',
			Sum(Case When report_group_2_cd = 'HSTCTB' And		month_num = '05' Then sh.customer_count_qty Else 0 End) as 'M05_HSTCTB',

			-- Month (06)
			Sum(Case When report_group_2_cd = 'SUNDRY' And		month_num = '06' Then sh.sales_amt Else 0 End) as 'M06_HSTMER',
			Sum(Case When report_group_2_cd = 'EQUIPMENT' And	month_num = '06' Then sh.sales_amt Else 0 End) as 'M06_HSTEQU',
			Sum(Case When report_group_2_cd = 'HSTCTL' And		month_num = '06' Then sh.customer_count_qty Else 0 End) as 'M06_HSTCTL',
			Sum(Case When report_group_2_cd = 'HSTCTB' And		month_num = '06' Then sh.customer_count_qty Else 0 End) as 'M06_HSTCTB',

			-- Month (07)
			Sum(Case When report_group_2_cd = 'SUNDRY' And		month_num = '07' Then sh.sales_amt Else 0 End) as 'M07_HSTMER',
			Sum(Case When report_group_2_cd = 'EQUIPMENT' And	month_num = '07' Then sh.sales_amt Else 0 End) as 'M07_HSTEQU',
			Sum(Case When report_group_2_cd = 'HSTCTL' And		month_num = '07' Then sh.customer_count_qty Else 0 End) as 'M07_HSTCTL',
			Sum(Case When report_group_2_cd = 'HSTCTB' And		month_num = '07' Then sh.customer_count_qty Else 0 End) as 'M07_HSTCTB',

			-- Month (08)
			Sum(Case When report_group_2_cd = 'SUNDRY' And		month_num = '08' Then sh.sales_amt Else 0 End) as 'M08_HSTMER',
			Sum(Case When report_group_2_cd = 'EQUIPMENT' And	month_num = '08' Then sh.sales_amt Else 0 End) as 'M08_HSTEQU',
			Sum(Case When report_group_2_cd = 'HSTCTL' And		month_num = '08' Then sh.customer_count_qty Else 0 End) as 'M08_HSTCTL',
			Sum(Case When report_group_2_cd = 'HSTCTB' And		month_num = '08' Then sh.customer_count_qty Else 0 End) as 'M08_HSTCTB',

			-- Month (09)
			Sum(Case When report_group_2_cd = 'SUNDRY' And		month_num = '09' Then sh.sales_amt Else 0 End) as 'M09_HSTMER',
			Sum(Case When report_group_2_cd = 'EQUIPMENT' And	month_num = '09' Then sh.sales_amt Else 0 End) as 'M09_HSTEQU',
			Sum(Case When report_group_2_cd = 'HSTCTL' And		month_num = '09' Then sh.customer_count_qty Else 0 End) as 'M09_HSTCTL',
			Sum(Case When report_group_2_cd = 'HSTCTB' And		month_num = '09' Then sh.customer_count_qty Else 0 End) as 'M09_HSTCTB',

			-- Month (10)
			Sum(Case When report_group_2_cd = 'SUNDRY' And		month_num = '10' Then sh.sales_amt Else 0 End) as 'M10_HSTMER',
			Sum(Case When report_group_2_cd = 'EQUIPMENT' And	month_num = '10' Then sh.sales_amt Else 0 End) as 'M10_HSTEQU',
			Sum(Case When report_group_2_cd = 'HSTCTL' And		month_num = '10' Then sh.customer_count_qty Else 0 End) as 'M10_HSTCTL',
			Sum(Case When report_group_2_cd = 'HSTCTB' And		month_num = '10' Then sh.customer_count_qty Else 0 End) as 'M10_HSTCTB',

			-- Month (11)
			Sum(Case When report_group_2_cd = 'SUNDRY' And		month_num = '11' Then sh.sales_amt Else 0 End) as 'M11_HSTMER',
			Sum(Case When report_group_2_cd = 'EQUIPMENT' And	month_num = '11' Then sh.sales_amt Else 0 End) as 'M11_HSTEQU',
			Sum(Case When report_group_2_cd = 'HSTCTL' And		month_num = '11' Then sh.customer_count_qty Else 0 End) as 'M11_HSTCTL',
			Sum(Case When report_group_2_cd = 'HSTCTB' And		month_num = '11' Then sh.customer_count_qty Else 0 End) as 'M11_HSTCTB',

			-- Month (12)
			Sum(Case When report_group_2_cd = 'SUNDRY' And		month_num = '12' Then sh.sales_amt Else 0 End) as 'M12_HSTMER',
			Sum(Case When report_group_2_cd = 'EQUIPMENT' And	month_num = '12' Then sh.sales_amt Else 0 End) as 'M12_HSTEQU',
			Sum(Case When report_group_2_cd = 'HSTCTL' And		month_num = '12' Then sh.customer_count_qty Else 0 End) as 'M12_HSTCTL',
			Sum(Case When report_group_2_cd = 'HSTCTB' And		month_num = '12' Then sh.customer_count_qty Else 0 End) as 'M12_HSTCTB'

		FROM         
			comm_sales_history AS sh 

			INNER JOIN comm_batch_control AS bc 
			ON sh.fiscal_yearmo_num = bc.fiscal_yearmo_num 

				INNER JOIN comm_group AS cg 
				ON sh.comm_group_cd = cg.comm_group_cd 

					INNER JOIN comm_configure AS cc 
					ON bc.year_num = cc.current_year_num

		WHERE     
			(cg.report_group_2_cd IN ('SUNDRY', 'EQUIPMENT', 'HSTCTB', 'HSTCTL'))
		GROUP BY 
			sh.salesperson_key_id
		) s
		ON m.salesperson_key_id = s.salesperson_key_id
WHERE     
	(m.comm_plan_id LIKE 'FSC%')
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

