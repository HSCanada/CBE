-- comm_special_market_legacy_map, tmc, 24 Jun 20


CREATE TABLE [comm_special_market_legacy_map](
	[cust_comm_group_cd] [char](6) NOT NULL,
	[SPM_StatusCd] [char](1) NOT NULL,
	[SPM_EQOptOut] [char](1) NOT NULL

 CONSTRAINT [comm_special_market_legacy_map_c_pk] PRIMARY KEY CLUSTERED 
(
	[cust_comm_group_cd] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


--

INSERT INTO [dbo].[comm_special_market_legacy_map]
           ([cust_comm_group_cd]
           ,[SPM_StatusCd]
           ,[SPM_EQOptOut])
     VALUES
           ('','N','')
           ,('SPMALL','Y','N')
           ,('SPMSND','Y','Y')
GO

BEGIN TRANSACTION
GO
ALTER TABLE dbo.comm_special_market_legacy_map ADD CONSTRAINT
	FK_comm_special_market_legacy_map_comm_group FOREIGN KEY
	(
	cust_comm_group_cd
	) REFERENCES dbo.comm_group
	(
	comm_group_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.comm_special_market_legacy_map SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--delete from  [dbo].[comm_special_market_legacy_map] where [cust_comm_group_cd] = 'SPMEQU'

INSERT INTO [dbo].[comm_group] (
	[comm_group_cd]
      ,[comm_group_desc]
      ,[source_cd]
      ,[active_ind]
      ,[comm_calc_rt]
      ,[note_txt]
      ,[booking_rt]
      ,[SPM_comm_group_cd]
      ,[show_ind]
      ,[SPM_EQOptOut]
      ,[sort_id]
      ,[FRG_comm_group_cd]
      ,[SPM_comm_group_reverse_cd]
)
SELECT 
	'SPMEQU' AS [comm_group_cd]
      ,'Special Market Customer, EQ only' AS [comm_group_desc]
      ,[source_cd]
      ,[active_ind]
      ,[comm_calc_rt]
      ,'used by comm_legacy_sync_proc for Jaffer execpt, 26 Nov 20' as [note_txt]
      ,[booking_rt]
      ,[SPM_comm_group_cd]
      ,[show_ind]
      ,[SPM_EQOptOut]
      ,[sort_id]
      ,[FRG_comm_group_cd]
      ,[SPM_comm_group_reverse_cd]
  FROM [dbo].[comm_group] where [comm_group_cd] like 'SPMALL'

-- added 26 Nov 20
INSERT INTO [dbo].[comm_special_market_legacy_map]
           ([cust_comm_group_cd]
           ,[SPM_StatusCd]
           ,[SPM_EQOptOut])
     VALUES
           ('SPMEQU','N','Y')
GO

-- apply to prod, after SPMEQU logic fixed and tested