
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/******************************************************************************
**	File: 
**	Name: comm_statement_detail
**	Desc: commission detail recordset used by Access report front-end
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
**	7 May 07	tmc	Added JDE source to details
** 22 Jan 08	tmc Added JDE shipto and JDE item to details
** 23 Jan 08    tmc	Fixed bug intruduced from 22 Jan 08 where imports were excluded
**					(due to inner join on item table instead of left join)
** 09 Sep 09	tmc	Added additional GP / ESS fields 
** 10 Feb 10	tmc Mapped commission Group to Item Commission Group for completeness
** 01 Mar 10	tmc	Add cost audit information to details
** 04 Jun 13	tmc	Optimized to use fiscal inner join rather than fiscal filter; 3m+ -> 1 sec.
**    
*******************************************************************************/

ALTER VIEW [dbo].[comm_statement_detail]
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
	t.item_comm_group_cd as comm_group_cd, 
	t.comm_rt, 
	t.transaction_amt, 
	t.comm_amt, 
	t.cost_ext_amt,

	t.hsi_shipto_id,
	t.IMITEM as hsi_item_id,
	t.manufact_cd as hsi_manuf_cd,

--	Added 9 Sept 09, tmc
	t.item_comm_group_cd,
	t.ess_salesperson_cd,
	t.ess_salesperson_key_id,
	t.gp_ext_amt,

-- Added 01 Mar 10, tmc
	t.order_source_cd,
	t.item_label_cd,
	t.tagable_item_ind,
	t.IMCLMJ,
	t.marketing_adjustment_rt,
	t.cost_unit_amt,
	t.shipped_qty,
	t.avg_cost_unit_amt,
	t.comm_cost_unit_amt

FROM         
comm_transaction t
	INNER JOIN comm_salesperson_master m
	ON t.salesperson_key_id = m.salesperson_key_id

	-- added optimized code 4 Jun 13, tmc
	INNER JOIN dbo.comm_configure f
	ON t.fiscal_yearmo_num = f.current_fiscal_yearmo_num

--	Left JOIN comm_item_master i
--	ON t.item_id = i.item_id

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
	-- removed in place of joing optimize code 4 Jun 13, tmc
--	t.fiscal_yearmo_num = (Select current_fiscal_yearmo_num From comm_configure) AND 

	t.source_cd in ('ACCPAC', 'JDE', 'IMPORT') And

	t.status_cd = 20 And
	r1.display_ind = 1 And
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

