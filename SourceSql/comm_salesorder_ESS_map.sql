
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/******************************************************************************
**	File: 
**	Name: comm_salesorder_ESS_map
**	Desc: Show ESS code attached to each Salesorder
**
**              
**
**	Auth: tmc
**	Date: 28 Mar 11
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-------	-------		-------------------------------------------
--	29 Jan 16	tmc 	Update for 2016 Plan
**    
*******************************************************************************/

ALTER VIEW [dbo].[comm_salesorder_ESS_map]
AS
SELECT 
	t.doc_id
	,d.[CalMonth]
--	,(CAST(FORMAT(t.transaction_dt, 'yyyyMM') AS INT)) as CalMonth
	,min(t.fiscal_yearmo_num)	AS fiscal_yearmo_num
	,CAST(t.doc_id AS int)		AS [SalesOrderNumber]
--	,min(t.doc_type_cd)			AS [DocType]
	,min(t.ess_salesperson_cd)	AS ess_salesperson_cd
	,min(t.salesperson_cd)		AS salesperson_cd
FROM 
	comm_transaction t

	INNER JOIN [comm_sales_day] d
	ON t.transaction_dt = d.[SalesDate]
/*
	INNER JOIN [dbo].[comm_batch_control] b
	ON t.fiscal_yearmo_num = b.fiscal_yearmo_num
*/

WHERE 
	(t.source_cd='JDE') AND
--	(t.fiscal_yearmo_num = (Select current_fiscal_yearmo_num from comm_configure))  AND
--	(ess_comm_plan_id in ('ESSGP', 'CCSGP')) AND
--	(t.doc_id='12239760') AND
	(1=1)
GROUP BY 
	t.doc_id
	,d.[CalMonth]
--	,(CAST(FORMAT(t.transaction_dt, 'yyyyMM') AS INT))
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- Select top 10 * from [comm_salesorder_ESS_map] where doc_id = '12239760'

