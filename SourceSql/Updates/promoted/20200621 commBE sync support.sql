--commBE sync support, tmc, 21 Jun 20

-- add cps / eps groups to item
BEGIN TRANSACTION
GO
ALTER TABLE dbo.comm_item_master ADD
	comm_group_cps_cd char(6) NOT NULL CONSTRAINT DF_comm_item_master_comm_group_cps_cd DEFAULT (''),
	comm_group_eps_cd char(6) NOT NULL CONSTRAINT DF_comm_item_master_comm_group_eps_cd DEFAULT ('')
GO
ALTER TABLE dbo.comm_item_master ADD CONSTRAINT
	FK_comm_item_master_comm_group FOREIGN KEY
	(
	comm_group_cps_cd
	) REFERENCES dbo.comm_group
	(
	comm_group_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.comm_item_master ADD CONSTRAINT
	FK_comm_item_master_comm_group1 FOREIGN KEY
	(
	comm_group_eps_cd
	) REFERENCES dbo.comm_group
	(
	comm_group_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.comm_item_master SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- add cps / eps groups
INSERT INTO [dbo].[comm_group] 
(
	[comm_group_cd]
	,[comm_group_desc]
	,[source_cd]
	,[comm_calc_rt]
	,[note_txt] 

)
SELECT
	comm_group_cd
	,comm_group_desc
	,source_cd
	,0
	,'NEW comm_legacy_sync_proc, 21 Jun 20'
FROM            [BRSales].comm.[group] s
WHERE 
	(comm_group_cd like 'EPS%' or comm_group_cd like 'CPS%' or comm_group_cd like 'SP%') AND
	NOT EXISTS (
		SELECT * FROM [dbo].[comm_group] d where d.comm_group_cd = s.comm_group_cd
	)

-- add new plans
INSERT INTO [dbo].[comm_plan]
(
	[comm_plan_id]
	,[comm_plan_nm]
)
SELECT
	[comm_plan_id]
	,[comm_plan_nm]
FROM	[BRSales].[comm].[plan] s
WHERE 
	NOT EXISTS (
		SELECT * FROM [dbo].[comm_plan] d where d.comm_plan_id = s.comm_plan_id
	)

-- add sm, eps, cps to customer

BEGIN TRANSACTION
GO
ALTER TABLE dbo.comm_customer_master ADD
	comm_status_cd char(6) NOT NULL CONSTRAINT DF_comm_customer_master_comm_status_cd DEFAULT (''),
	comm_note_txt varchar(50) NULL,
	eps_code char(6) NOT NULL CONSTRAINT DF_comm_customer_master_eps_code DEFAULT (''),
	cps_code char(6) NOT NULL CONSTRAINT DF_comm_customer_master_cps_code DEFAULT ('')
GO
ALTER TABLE dbo.comm_customer_master ADD CONSTRAINT
	FK_comm_customer_master_comm_group FOREIGN KEY
	(
	comm_status_cd
	) REFERENCES dbo.comm_group
	(
	comm_group_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.comm_customer_master ADD CONSTRAINT
	FK_comm_customer_master_comm_salesperson_code_map FOREIGN KEY
	(
	cps_code
	) REFERENCES dbo.comm_salesperson_code_map
	(
	salesperson_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.comm_customer_master ADD CONSTRAINT
	FK_comm_customer_master_comm_salesperson_code_map1 FOREIGN KEY
	(
	eps_code
	) REFERENCES dbo.comm_salesperson_code_map
	(
	salesperson_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.comm_customer_master SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--
BEGIN TRANSACTION
GO
ALTER TABLE dbo.comm_salesperson_master ADD
	CostCenter nvarchar(30) NOT NULL CONSTRAINT DF_comm_salesperson_master_CostCenter DEFAULT (''),
	salary_draw_amt money NOT NULL CONSTRAINT DF_comm_salesperson_master_salary_draw_amt DEFAULT ((0)),
	deficit_amt money NOT NULL CONSTRAINT DF_comm_salesperson_master_deficit_amt DEFAULT ((0)),
	FiscalMonth int NOT NULL CONSTRAINT DF_comm_salesperson_master_FiscalMonth DEFAULT ((0))
GO
ALTER TABLE dbo.comm_salesperson_master SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


/*
-- cleanup legacy
drop table [dbo].[comm_customer_master_ISR]
drop table [dbo].[comm_eps_productline]
drop table [dbo].[comm_eps_region]
drop table [dbo].[comm_eps_specialist_map]
drop table [dbo].[comm_salesperson_code_map_stage]
drop table [dbo].[comm_salesperson_RIS]
drop table [dbo].[comm_transaction_ISR]
drop table [dbo].[zzcomm_group_report]

drop view [dbo].[comm_eps_region_map]
drop view [dbo].[comm_salesperson_RIS_map]
drop view [dbo].[comm_salesorder_ESS_map]
drop view [dbo].[comm_salesperson_territory_map]

drop view [dbo].[zzcomm_ess_statement_export02]
drop view [dbo].[zzcomm_ess_statement_history]
drop view [dbo].[zzcomm_rate_map]
drop view [dbo].[zzcomm_salesperson_category_map]
drop view [dbo].[zzcomm_statement_detail_all]
drop view [dbo].[zzcomm_statement_export03]
drop view [dbo].[zzcomm_statement_summary]

DROP PROCEDURE [dbo].[comm_transaction_sales_history_calc_proc]

*/

INSERT INTO [dbo].[comm_branch]
(branch_cd, branch_nm)
select distinct [Branch], '' from [BRSales].[dbo].[BRS_FSC_Rollup]  s
where not exists (select * from [dbo].[comm_branch] d where d.branch_cd = s.Branch)
