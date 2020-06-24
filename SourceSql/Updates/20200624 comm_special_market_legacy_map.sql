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

