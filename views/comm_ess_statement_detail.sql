
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/******************************************************************************
**	File: 
**	Name: comm_ess_statement_detail
**	Desc: commission detail recordset used by Access report front-end
**
**              
**
**	Auth: tmc
**	Date: 4 Mar 08
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-------	-------		-------------------------------------------
**	26 mar 08	tmc		fixed field so ess_comm is showing, not FSC comm
**	09 Sep 09	tmc		Added additional GP / ESS fields 
**	02 Feb 10	tmc		Make consistent with comm_statement_detail for 2010 Comm Statement
**	01 Mar 10	tmc		Add cost audit information to details
**  14 Jan 11	tmc		Bug fix where post adjustments are not being included in details
**	23 Sep 13	tmc		Remove CUSINS,ITMARS,ITMTEE from Details 
**    
*******************************************************************************/
ALTER VIEW [dbo].[comm_ess_statement_detail]
AS
SELECT     t.record_id, m.salesperson_key_id, t.source_cd, r1.report_group_1_cd, r1.report_group_2_cd, r1.report_group_3_cd, m.salesperson_nm, t.division_cd, 
                      t.ess_salesperson_cd AS salesperson_cd, t.ess_comm_plan_id AS comm_plan_id, p.comm_plan_nm, t.fiscal_yearmo_num, c.fiscal_begin_dt, c.fiscal_end_dt, 
                      r2.report_group_txt AS master_report_group_txt, r2.report_sort_id AS master_report_sort_id, r1.report_group_txt, r1.report_sort_id, t.doc_key_id, t.line_id, t.doc_id, 
                      t.order_id, t.transaction_dt, t.customer_id, t.customer_nm, t.item_id, t.transaction_txt, t.comm_cd, t.ess_comm_group_cd AS item_comm_group_cd, 
                      t.ess_comm_group_cd AS comm_group_cd, t.ess_comm_rt AS comm_rt, t.transaction_amt, t.ess_comm_amt AS comm_amt, t.cost_ext_amt, t.hsi_shipto_id, 
                      t.IMITEM AS hsi_item_id, t.gp_ext_amt, t.manufact_cd AS hsi_manuf_cd, b.branch_nm, t.salesperson_key_id AS fsc_salesperson_key_id, t.order_source_cd, 
                      t.item_label_cd, t.tagable_item_ind, t.IMCLMJ, t.marketing_adjustment_rt, t.cost_unit_amt, t.shipped_qty, t.avg_cost_unit_amt, t.comm_cost_unit_amt
FROM         dbo.comm_transaction AS t INNER JOIN
                      dbo.comm_salesperson_master AS m ON t.ess_salesperson_key_id = m.salesperson_key_id LEFT OUTER JOIN
                      dbo.comm_salesperson_territory_map AS b ON m.salesperson_territory_cd = b.salesperson_territory_cd INNER JOIN
                      dbo.comm_configure AS f ON t.fiscal_yearmo_num = f.current_fiscal_yearmo_num INNER JOIN
                      dbo.comm_plan AS p ON m.comm_plan_id = p.comm_plan_id INNER JOIN
                      dbo.comm_batch_control AS c ON t.fiscal_yearmo_num = c.fiscal_yearmo_num INNER JOIN
                      dbo.comm_group AS g ON t.ess_comm_group_cd = g.comm_group_cd INNER JOIN
                      dbo.comm_group_report AS r1 ON g.report_group_3_cd = r1.report_group_3_cd AND g.report_group_2_cd = r1.report_group_2_cd AND 
                      g.report_group_1_cd = r1.report_group_1_cd INNER JOIN
                      dbo.comm_group_report AS r2 ON r1.report_group_1_cd = r2.report_group_1_cd
WHERE     (t.source_cd IN ('ACCPAC', 'JDE', 'IMPORT')) AND (t.ess_comm_group_cd NOT IN ('ITMEQ0', 'ITMSER', 'ITMPAR', 'ITMSND', 'ITMCAM', 'ITMARS', 'CUSINS', 'ITMTEE')) 
                      AND (t.status_cd = 20) AND (r1.display_ind = 1) AND (r2.report_group_2_cd = '') AND (r2.report_group_3_cd = '') AND (r2.display_ind = 1) AND (r1.display_ind = 1) AND 
                      (1 = 1)
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

