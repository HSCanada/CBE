
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/******************************************************************************
**	File: 
**	Name: comm_salesperson_RIS_map
**	Desc: comm_customer_master source view
**
**              
**
**	Auth: tmc
**	Date: 9 Mar 11
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-------	-------		-------------------------------------------
**	6 Feb 01	tmc		Added user defined Postal code length exceptions 
**    
*******************************************************************************/

ALTER VIEW [dbo].[comm_salesperson_RIS_map]
AS
SELECT     
	c.hsi_shipto_id, 
	c.ship_postal_num as PC3, 

	isnull(R3.RIS_nm, R1.RIS_nm) as RIS_nm,
	isnull(R3.exception_ind, 0) as RIS_override_ind,
	
	isnull(R3.PC3,'') as RIS_override_cd,
	isnull(R3.depth_qty,0) as RIS_override_num,
	R1.RIS_nm as RIS_PC1_Default_nm

FROM         
	comm_customer_master c 
		INNER JOIN comm_salesperson_RIS R1
		ON (R1.PC3 = LEFT(c.ship_postal_num, 1) AND 
			R1.exception_ind = 0)

		LEFT JOIN comm_salesperson_RIS R3
		ON (R3.PC3 = LEFT(c.ship_postal_num, R3.depth_qty) AND 
			R3.exception_ind = 1)
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

