
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
**    
*******************************************************************************/

ALTER VIEW [dbo].[comm_salesorder_ESS_map]
AS
SELECT 
	t.doc_id, 
	min(t.fiscal_yearmo_num) as fiscal_yearmo_num,
	min(t.ess_salesperson_cd) as ess_salesperson_cd
FROM 
	comm_transaction t INNER JOIN 
		comm_configure c
		ON t.fiscal_yearmo_num = c.current_fiscal_yearmo_num
WHERE 
	(t.ess_salesperson_cd<>'') AND
	(t.source_cd='JDE')
GROUP BY 
	t.doc_id
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
