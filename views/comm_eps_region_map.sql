
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[comm_eps_region_map]
AS
SELECT     dbo.comm_customer_master.hsi_shipto_id, LEFT(dbo.comm_customer_master.ship_postal_num, 1) AS PC1, ISNULL(dbo.comm_eps_region.EPS_Region, N'NONCA') 
                      AS EPS_Region, ISNULL(dbo.comm_eps_region.EPS_Specialist, N'') AS EPS_Specialist
FROM         dbo.comm_eps_region RIGHT OUTER JOIN
                      dbo.comm_customer_master ON dbo.comm_eps_region.PC1 = LEFT(dbo.comm_customer_master.ship_postal_num, 1)
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

