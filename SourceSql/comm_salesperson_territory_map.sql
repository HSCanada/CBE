
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/******************************************************************************
**	File: 
**	Name: comm_salesperson_territory_map
**	Desc: 
**
**              
**
**	Auth: tmc
**	Date: 27 Apr 04
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-------	-------		-------------------------------------------
**	18 May 07	tmc		Added short names to Zone and Region
**    
*******************************************************************************/

ALTER VIEW [dbo].[comm_salesperson_territory_map]
AS
SELECT     
	IsNull(r.salesperson_territory_cd, IsNull(z.salesperson_territory_cd, Left(d.salesperson_territory_cd, 1)) ) AS salesperson_territory_cd, 

	-- Division
	d.salesperson_territory_cd AS division_cd, 
	d.salesperson_territory_desc AS division_desc, 
	IsNull(d.manager_key_id, 'Unassigned') AS division_manager_id, 

	-- Zone
	IsNull(z.salesperson_territory_cd, Left(d.salesperson_territory_cd, 1)) AS zone_cd, 
	IsNull(z.salesperson_territory_desc, 'Unassigned') AS zone_desc, 
	IsNull(z.manager_key_id, 'Unassigned') AS zone_manager_id, 

	-- Region
	IsNull(r.salesperson_territory_cd, IsNull(z.salesperson_territory_cd, Left(d.salesperson_territory_cd, 1)) ) AS region_cd, 
	IsNull(r.salesperson_territory_desc, 'Unassigned') AS region_desc, 
	IsNull(r.manager_key_id, 'Unassigned') AS region_manager_id,

	-- Short names, added 18 May 07, tmc
	IsNull(z.short_nm, 'Unassigned') AS zone_nm, 
	IsNull(r.short_nm, 'Unassigned') AS branch_nm



FROM         
	comm_salesperson_territory d 
		Left JOIN comm_salesperson_territory z 
		ON d.salesperson_territory_cd = z.parent_cd   AND 
			z.depth_qty = 2

			Left JOIN comm_salesperson_territory r 
			ON r.parent_cd = z.salesperson_territory_cd AND 
				r.depth_qty = 3
WHERE     
	d.depth_qty = 1
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

