
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/******************************************************************************
**	File: 
**	Name: comm_salesperson_category_map
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
**    
*******************************************************************************/

ALTER VIEW [dbo].[comm_salesperson_category_map]
AS
SELECT     
	IsNull(s.salesperson_category_cd, Left(m.salesperson_category_cd, 3)) AS salesperson_category_cd, 
	m.salesperson_category_cd AS salesperson_category_major_cd, 
	m.salesperson_category_desc AS salesperson_category_major_desc, 
	IsNull(s.salesperson_category_cd, Left(m.salesperson_category_cd, 3)) AS salesperson_category_submajor_cd, 
	IsNull(s.salesperson_category_desc, 'Undefined') AS salesperson_category_submajor_desc
FROM         
	comm_salesperson_category m 
		LEFT OUTER JOIN comm_salesperson_category s 
		ON m.salesperson_category_cd = s.parent_cd AND s.depth_qty = 2
WHERE     
	(m.depth_qty = 1)
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

