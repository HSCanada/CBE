
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
	t.doc_id, 
	min(t.fiscal_yearmo_num) as fiscal_yearmo_num,
	min(t.ess_salesperson_cd) as ess_salesperson_cd
FROM 
	comm_transaction t
WHERE 
	(ess_comm_plan_id in ('ESSGP', 'CCSGP')) AND
	(t.source_cd='JDE') AND
	(t.fiscal_yearmo_num = (Select current_fiscal_yearmo_num from comm_configure))
GROUP BY 
	t.doc_id
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

