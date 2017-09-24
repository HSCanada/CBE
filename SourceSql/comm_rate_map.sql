
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/******************************************************************************
**	File: 
**	Name: comm_rate_map
**	Desc: 
**
**              
**
**	Auth: tmc
**	Date: 14 Mar 06
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-------	-------		-------------------------------------------
**    
*******************************************************************************/

ALTER VIEW [dbo].[comm_rate_map]
AS
-- Commission Base
SELECT  
	comm_plan_id,
	comm_group_cd,
   
	' ' AS comm_cd, 
	comm_base_rt AS comm_rt
FROM         
	comm_plan_group_rate
Where
	active_ind = 1

Union All

-- Commission A
SELECT     
	comm_plan_id,
	comm_group_cd,

	'A' AS comm_cd, 
	comm_a_rt AS comm_rt
FROM         
	comm_plan_group_rate
Where
	active_ind = 1


Union All

-- Commission B
SELECT     
	comm_plan_id,
	comm_group_cd,

	'B' AS comm_cd, 
	comm_b_rt AS comm_rt
FROM         
	comm_plan_group_rate
Where
	active_ind = 1


Union All

-- Commission C
SELECT     
	comm_plan_id,
	comm_group_cd,

	'C' AS comm_cd, 
	comm_c_rt AS comm_rt
FROM         
	comm_plan_group_rate
Where
	active_ind = 1

Union All

-- Commission D
SELECT     
	comm_plan_id,
	comm_group_cd,

	'D' AS comm_cd, 
	comm_d_rt AS comm_rt
FROM         
	comm_plan_group_rate
Where
	active_ind = 1

Union All

-- Commission E
SELECT     
	comm_plan_id,
	comm_group_cd,

	'E' AS comm_cd, 
	comm_e_rt AS comm_rt
FROM         
	comm_plan_group_rate
Where
	active_ind = 1
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

