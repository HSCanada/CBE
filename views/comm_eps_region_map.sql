
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[comm_eps_region_map]
AS
SELECT     

	c.hsi_shipto_id, 
	LEFT(c.ship_postal_num, 1) AS PC1, 
	ISNULL(r.EPS_Region, N'NONCA')  AS EPS_Region, 
	ISNULL(r.EPS_Specialist, N'') AS EPS_Specialist

FROM         

	comm_eps_region AS r

	RIGHT OUTER JOIN comm_customer_master AS c
	ON r.PC1 = LEFT(c.ship_postal_num, 1)
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
