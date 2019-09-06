-- Improve Free Goods process to account for Calendar source to fiscal processing

-- add fiscal legacy to new xref

BEGIN TRANSACTION
GO
ALTER TABLE dbo.comm_batch_control ADD
	FiscalMonth int NOT NULL CONSTRAINT DF_comm_batch_control_FiscalMonth DEFAULT 0
GO
ALTER TABLE dbo.comm_batch_control SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- convert
UPDATE       comm_batch_control
SET                FiscalMonth = fiscal_yearmo_num

-- add unique index

BEGIN TRANSACTION
GO
CREATE UNIQUE NONCLUSTERED INDEX comm_batch_control_u_idx_01 ON dbo.comm_batch_control
	(
	FiscalMonth
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE dbo.comm_batch_control SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--
-- drop table [dbo].[comm_free_goods_redeem]

-- truncate table [dbo].[comm_free_goods_redeem]

CREATE TABLE [dbo].[comm_free_goods_redeem](
	[CalMonth] [int] NOT NULL,
	[SalesOrderNumber] [int] NOT NULL,
	[DocType] [char](2) NOT NULL,
	[Item] [char](16) NOT NULL,
	[SourceCode] [char](3) NOT NULL,
	[ShipTo] [int] NOT NULL,
	[PracticeName] [nvarchar](40) NOT NULL,
	[ItemDescription] [nvarchar](40) NOT NULL,
	[Supplier] [char](6) NOT NULL,
	[ExtFileCostCadAmt] [money] NOT NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[salesperson_cd] [char](6) NULL,
	[salesperson_ess_cd] [char](6) NULL,
	[FiscalMonth_actual] [int] NULL,
	[comm_group_cd] [char](6) NULL,
	[fsc_comm_group_cd] [char](6) NULL,
	[special_market_ind] [bit] NOT NULL,
	[equipment_opt_out_ind] [bit] NOT NULL,
	[group_equipment_opt_out_ind] [bit] NOT NULL,
	[ID_legacy] [int] NULL,
	[Note] [varchar](10) NULL
	
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[comm_free_goods_redeem] ADD  CONSTRAINT [DF_comm_free_goods_redeem_special_market_ind]  DEFAULT ((0)) FOR [special_market_ind]
GO

ALTER TABLE [dbo].[comm_free_goods_redeem] ADD  CONSTRAINT [DF_comm_free_goods_redeem_equipment_opt_out_ind]  DEFAULT ((0)) FOR [equipment_opt_out_ind]
GO

ALTER TABLE [dbo].[comm_free_goods_redeem] ADD  CONSTRAINT [DF_comm_free_goods_redeem_group_equipment_opt_out_ind]  DEFAULT ((0)) FOR [group_equipment_opt_out_ind]
GO

GO
ALTER TABLE dbo.comm_free_goods_redeem ADD
	process_status_cd smallint NOT NULL CONSTRAINT DF_comm_free_goods_redeem_process_status DEFAULT 0
GO
ALTER TABLE dbo.comm_free_goods_redeem SET (LOCK_ESCALATION = TABLE)
GO

--

BEGIN TRANSACTION
GO
ALTER TABLE dbo.comm_free_goods_redeem ADD CONSTRAINT
	PK_comm_free_goods_redeem PRIMARY KEY CLUSTERED 
	(
	CalMonth,
	SalesOrderNumber,
	DocType,
	Item,
	SourceCode
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.comm_free_goods_redeem ADD CONSTRAINT
	FK_comm_free_goods_redeem_comm_item_master FOREIGN KEY
	(
	Item
	) REFERENCES dbo.comm_item_master
	(
	item_id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.comm_free_goods_redeem ADD CONSTRAINT
	FK_comm_free_goods_redeem_comm_customer_master FOREIGN KEY
	(
	ShipTo
	) REFERENCES dbo.comm_customer_master
	(
	hsi_shipto_id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.comm_free_goods_redeem ADD CONSTRAINT
	FK_comm_free_goods_redeem_comm_free_goods_redeem FOREIGN KEY
	(
	CalMonth,
	SalesOrderNumber,
	DocType,
	Item,
	SourceCode
	) REFERENCES dbo.comm_free_goods_redeem
	(
	CalMonth,
	SalesOrderNumber,
	DocType,
	Item,
	SourceCode
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.comm_free_goods_redeem SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
GO

BEGIN TRANSACTION
GO
ALTER TABLE dbo.comm_free_goods_redeem ADD CONSTRAINT
	FK_comm_free_goods_redeem_comm_salesperson_code_map FOREIGN KEY
	(
	salesperson_cd
	) REFERENCES dbo.comm_salesperson_code_map
	(
	salesperson_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.comm_free_goods_redeem ADD CONSTRAINT
	FK_comm_free_goods_redeem_comm_salesperson_code_map1 FOREIGN KEY
	(
	salesperson_ess_cd
	) REFERENCES dbo.comm_salesperson_code_map
	(
	salesperson_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.comm_free_goods_redeem ADD CONSTRAINT
	FK_comm_free_goods_redeem_comm_batch_control FOREIGN KEY
	(
	FiscalMonth_actual
	) REFERENCES dbo.comm_batch_control
	(
	FiscalMonth
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO

ALTER TABLE dbo.comm_free_goods_redeem ADD CONSTRAINT
	FK_comm_free_goods_redeem_comm_group FOREIGN KEY
	(
	comm_group_cd
	) REFERENCES dbo.comm_group
	(
	comm_group_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.comm_free_goods_redeem ADD CONSTRAINT
	FK_comm_free_goods_redeem_comm_group1 FOREIGN KEY
	(
	fsc_comm_group_cd
	) REFERENCES dbo.comm_group
	(
	comm_group_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.comm_free_goods_redeem SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- create stage

-- drop table [dbo].[itegration_comm_free_goods_redeem]

CREATE TABLE [dbo].[itegration_comm_free_goods_redeem](
	[CalMonth] [int] NOT NULL,
	[ShipTo] [int] NOT NULL,
	[PracticeName] [nvarchar](40) NOT NULL,
	[Item] [char](16) NOT NULL,
	[ItemDescription] [nvarchar](40) NOT NULL,
	[Supplier] [char](6) NOT NULL,
	[SalesOrderNumber] [int] NOT NULL,
	[ExtFileCostCadAmt] [money] NOT NULL,
	[SourceCode] [char](3) NOT NULL,

	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Note] [varchar](10) NULL
) ON [PRIMARY]
GO

BEGIN TRANSACTION
GO
ALTER TABLE dbo.itegration_comm_free_goods_redeem ADD CONSTRAINT
	itegration_comm_free_goods_redeem_pk PRIMARY KEY CLUSTERED 
	(
	ID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.itegration_comm_free_goods_redeem SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


-- populate from Access  to SQL

--fix null item from 201706

-- add sales_day map (for performance)
-- truncate table [dbo].[comm_SalesDay]

CREATE TABLE [dbo].[comm_sales_day](
	[SalesDate] [datetime] NOT NULL,
	[FiscalMonth] [int] NOT NULL,
	[CalMonth] [int] NOT NULL,
 CONSTRAINT [comm_sales_day_c_pk] PRIMARY KEY CLUSTERED 
(
	[SalesDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

BEGIN TRANSACTION
GO
ALTER TABLE dbo.comm_sales_day ADD CONSTRAINT
	FK_comm_sales_day_comm_batch_control FOREIGN KEY
	(
	FiscalMonth
	) REFERENCES dbo.comm_batch_control
	(
	FiscalMonth
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.comm_sales_day SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
--

--truncate table dbo.comm_sales_day

insert into dbo.comm_sales_day
([SalesDate], [FiscalMonth], [CalMonth])

SELECT        SalesDate, b.FiscalMonth, (CAST(FORMAT(SalesDate, 'yyyyMM') AS INT))
FROM            BRSales.dbo.BRS_SalesDay d
inner join [dbo].[comm_batch_control] b
ON d.FiscalMonth = b.FiscalMonth
order by 1



-- Map actual (calendar)

UPDATE       comm_free_goods_redeem
SET                FiscalMonth_actual =m.fiscal_yearmo_num, process_status_cd = 1
FROM            comm_free_goods_redeem INNER JOIN
                         comm_salesorder_ESS_map AS m ON comm_free_goods_redeem.CalMonth = m.CalMonth AND 
                         comm_free_goods_redeem.SalesOrderNumber = m.SalesOrderNumber
WHERE        (comm_free_goods_redeem.CalMonth between 201701 and 201912) AND (comm_free_goods_redeem.DocType = 'AA') AND (comm_free_goods_redeem.SourceCode like 'A%')


-- Map est (fiscal)

UPDATE       comm_free_goods_redeem
SET                FiscalMonth_actual =m.fiscal_yearmo_num, process_status_cd = 1
FROM            comm_free_goods_redeem INNER JOIN
                         comm_salesorder_ESS_map AS m ON comm_free_goods_redeem.CalMonth = m.fiscal_yearmo_num AND 
                         comm_free_goods_redeem.SalesOrderNumber = m.SalesOrderNumber
WHERE        (comm_free_goods_redeem.CalMonth between 201701 and 201912) AND (comm_free_goods_redeem.DocType = 'AA') AND (comm_free_goods_redeem.SourceCode like 'E%')

