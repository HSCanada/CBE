
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/******************************************************************************
**	File: 
**	Name: comm_transaction_ts
**	Desc: map commission fields to better join to newer DS tables
**
**              
**
**	Auth: tmc
**	Date: 29 Nov 16
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-------	-------		-------------------------------------------
*******************************************************************************/

ALTER VIEW [dbo].[comm_transaction_ts]
AS
SELECT     
	record_id, 

	fiscal_yearmo_num, 
	CAST (fiscal_yearmo_num AS int) as FiscalMonth,

	salesperson_key_id, 
	ess_salesperson_key_id, 
	order_source_cd, 
	reference_order_txt, 
	doc_id, 
	CAST (doc_id AS int) as SalesOrderNumber,

	item_id, 
	transaction_txt, 

	item_comm_group_cd, 
	shipped_qty, 
	transaction_amt, 
	gp_ext_amt, 

	transaction_dt, 

	source_cd, 
	doc_key_id, 
	line_id, 

	salesperson_cd, 
	customer_nm, 
	comm_plan_id, 

	doc_type_cd, 
	hsi_shipto_id, 
	ess_salesperson_cd, 
	hsi_shipto_div_cd,  
	manufact_cd, 
	sales_category_cd, 
	customer_po_num,
	IMCLMJ

FROM         
	comm_transaction AS t

WHERE     
	t.source_cd = 'JDE' AND
	t.fiscal_yearmo_num = (SELECT current_fiscal_yearmo_num FROM comm_configure) AND

--	t.salesperson_key_id = 'ptario' And
	1=1
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- SELECT * FROM [comm_transaction_ts]