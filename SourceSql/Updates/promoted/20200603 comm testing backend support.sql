-- comm testing backend support, tmc, 3 Jun 20

-- add mapping field to duplicated hard-coded view logic
BEGIN TRANSACTION
GO
ALTER TABLE dbo.comm_plan_group_rate ADD
	disp_comm_group_cd char(6) NOT NULL CONSTRAINT DF_comm_plan_group_rate_disp_comm_group_cd DEFAULT ''
GO
ALTER TABLE dbo.comm_plan_group_rate ADD CONSTRAINT
	FK_comm_plan_group_rate_comm_group FOREIGN KEY
	(
	disp_comm_group_cd
	) REFERENCES dbo.comm_group
	(
	comm_group_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.comm_plan_group_rate SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- set default
UPDATE       comm_plan_group_rate
SET                disp_comm_group_cd = comm_group_cd 

-- set CCS
UPDATE       comm_plan_group_rate
SET                disp_comm_group_cd = 'DIGOTH'
WHERE 
	comm_plan_id like 'CCS%' AND
	comm_group_cd IN('DIGIMP', 'DIGCCS', 'DIGLAB', 'DIGOTH', 'ITMCPU', 'ITMSOF')
GO

UPDATE       comm_plan_group_rate
SET                disp_comm_group_cd = 'DIGCCC'
WHERE 
	comm_plan_id like 'CCS%' AND
	comm_group_cd IN('DIGCCC', 'DIGCIM')
GO

UPDATE       comm_plan_group_rate
SET                disp_comm_group_cd = 'DIGIMP'
WHERE 
	comm_plan_id like 'FSC%' AND
	comm_group_cd IN('DIGIMP', 'DIGCCS', 'DIGOTH', 'DIGCIM', 'DIGCCC', 'DIGLAB')
GO

-- unmap special market transform so that production item group can be used by new system
-- Legacy:  CommA -> SMCommA 
-- New:  SMCommA ->CommA -> History -> New rollup

-- add new reversal group
BEGIN TRANSACTION
GO
ALTER TABLE dbo.comm_group ADD
	SPM_comm_group_reverse_cd char(6) NOT NULL CONSTRAINT DF_comm_group_SPM_comm_group_reverse_cd DEFAULT ''
GO
ALTER TABLE dbo.comm_group ADD CONSTRAINT
	FK_comm_group_comm_group3 FOREIGN KEY
	(
	SPM_comm_group_reverse_cd
	) REFERENCES dbo.comm_group
	(
	comm_group_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.comm_group SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

