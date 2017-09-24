
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/******************************************************************************
**	File: 
**	Name: comm_statement_detail_all
**	Desc: commission detail recordset used for ad_hoc reporting.
**		Based on comm_statement_detail view
**
**              
**
**	Auth: tmc
**	Date: 23 Nov 06
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-------	-------		-------------------------------------------
**	18 Sept 07	tmc		Added ESS details to report and JDE data
**	10 June 08	tmc		Added JDE data
**	03 Oct  08  tmc		Added item_comm_cd
** 9 Sept 09	tmc	Added additional GP / ESS fields 
**    
*******************************************************************************/

ALTER VIEW [dbo].[comm_statement_detail_all]
AS
SELECT   
	t.record_id,

	t.salesperson_key_id, 
	t.source_cd,
	r1.report_group_1_cd, 
	r1.report_group_2_cd, 
	r1.report_group_3_cd, 

	m.salesperson_nm, 
	t.division_cd, 
	t.salesperson_cd, 
	t.comm_plan_id,
	p.comm_plan_nm, 

	t.fiscal_yearmo_num, 
	c.fiscal_begin_dt, 
	c.fiscal_end_dt, 

	r2.report_group_txt as master_report_group_txt, 
	r2.report_sort_id as master_report_sort_id, 

	r1.report_group_txt, 
	r1.report_sort_id, 

	t.doc_key_id, 
	t.line_id, 
	t.doc_id, 
	t.order_id, 

	t.transaction_dt, 

	t.customer_id, 
	t.customer_nm, 
	t.customer_comm_group_cd,

	t.item_id, 
	t.transaction_txt, 
	t.comm_cd, 
	t.comm_group_cd, 
	t.comm_rt, 
	t.transaction_amt, 
	t.comm_amt, 
	t.cost_ext_amt,

	ess_salesperson_key_id,

	t.hsi_shipto_id,
	i.hsi_item_id,

	t.item_comm_group_cd,

--	Added 9 Sept 09, tmc
	t.ess_salesperson_cd,
	t.gp_ext_amt

FROM         
comm_transaction t
	INNER JOIN comm_salesperson_master m
	ON t.salesperson_key_id = m.salesperson_key_id

	Left JOIN comm_item_master i
	ON t.item_id = i.item_id

	INNER JOIN comm_plan p
	ON m.comm_plan_id = p.comm_plan_id

	INNER JOIN comm_batch_control c
	ON t.fiscal_yearmo_num = c.fiscal_yearmo_num

	INNER JOIN comm_group g
	ON t.item_comm_group_cd = g.comm_group_cd

		INNER JOIN comm_group_report r1
		ON g.report_group_3_cd = r1.report_group_3_cd AND 
			g.report_group_2_cd = r1.report_group_2_cd AND 
			g.report_group_1_cd = r1.report_group_1_cd 

		INNER JOIN comm_group_report AS r2 
		ON r1.report_group_1_cd = r2.report_group_1_cd



WHERE     
	t.status_cd = 20 And
	r1.display_ind = 1 And
--	t.source_cd in ('ACCPAC', 'IMPORT') And
	t.source_cd in ('ACCPAC', 'JDE', 'IMPORT') And
	r2.report_group_2_cd = '' AND 
	r2.report_group_3_cd = '' AND 
    r2.display_ind = 1  AND 
	r1.display_ind = 1 And
--	t.salesperson_key_id = 'ptario' And
	1=1
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

