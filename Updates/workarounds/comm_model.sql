SELECT   
--	top 10

	s.supplier_nm + ' | ' + s.Supplier as supplier,
	t.item_comm_group_cd + ' | ' + g.comm_group_desc as comm_group,
	cr.category_rollup_desc as product_category,
	t.comm_plan_id,
	t.ess_comm_plan_id,

	SUM(t.transaction_amt) sales, 
	SUM(t.gp_ext_amt) gp_comm

FROM         
	comm_transaction t

	INNER JOIN BRSales.dbo.BRS_Item i
	ON t.item_id = i.item

	INNER JOIN BRSales.[dbo].[BRS_ItemCategory] c
	ON i.MinorProductClass = c.MinorProductClass

	INNER JOIN BRSales.[dbo].[BRS_ItemCategoryRollup] cr
	ON c.CategoryRollup = cr.CategoryRollup

	INNER JOIN BRSales.[dbo].[BRS_ItemSupplier] s
	ON i.Supplier = s.Supplier

	INNER JOIN [dbo].[comm_group] g
	ON t.item_comm_group_cd = g.comm_group_cd



WHERE     
--	t.source_cd in ('JDE') AND
	t.source_cd in ('JDE', 'IMPORT') AND
	t.item_comm_group_cd in('DIGCCC', 'DIGCCS', 'DIGCIM', 'DIGIMP', 'DIGLAB', 'DIGOTH', 
		'ITMCPU', 'ITMEQ0', 'ITMFO1', 'ITMFO2', 'ITMFO3', 'ITMISC', 'ITMSOF', 
		'SPMFO1', 'SPMFO2', 'SPMFO3') AND
	t.fiscal_yearmo_num between 201901 AND 201912 AND
	(1=1)

GROUP BY
	s.supplier_nm + ' | ' + s.Supplier,
	t.item_comm_group_cd + ' | ' + g.comm_group_desc,
	cr.category_rollup_desc,
	t.comm_plan_id,
	t.ess_comm_plan_id


GO
