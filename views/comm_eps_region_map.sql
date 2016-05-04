
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/******************************************************************************
**	File: 
**	Name: comm_eps_region_map
**	Desc: commission detail recordset used by Access report front-end
**
**              
**
**	Auth: tmc
**	Date: 18 Apr 16
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-------	-------		-------------------------------------------
**    
*******************************************************************************/

ALTER VIEW [dbo].[comm_eps_region_map]
AS
SELECT     

	c.hsi_shipto_id, 
	LEFT(c.ship_postal_num, 1) AS PC1, 
	r.EPS_Region AS EPS_Region
FROM         

	comm_eps_region AS r

	LEFT JOIN comm_customer_master AS c
	ON LEFT(c.ship_postal_num, 1) = r.PC1 
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- Select * from comm_eps_region_map
