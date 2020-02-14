/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [item_id]
      ,[comm_group_cd]
      ,[note_txt]
	  ,e.Supplier

  FROM [CommBE].[dbo].[comm_item_master] i
  INNER JOIN [BRSales].[eps].[Item] e on 
  i.item_id = e.[Item_Number]

  where comm_group_cd = 'ITMSND' AND
  (1=1)

/****** Script for SelectTopNRows command from SSMS  ******/
UPDATE       comm_item_master
SET                comm_group_cd = 'ITMEPS', note_txt = 'Moved from Sundry to EPS as per 2020 plan, tmc, 2 Feb 20'
FROM            comm_item_master INNER JOIN
                         BRSales.eps.Item AS e ON comm_item_master.item_id = e.Item_Number
WHERE        (comm_item_master.comm_group_cd = 'ITMSND') AND (1 = 1)


-- update history from SND to EPS
SELECT        top 100 t.fiscal_yearmo_num, t.item_id, t.item_comm_group_cd, i.comm_group_cd, t.source_cd
FROM            comm_transaction t INNER JOIN
                         comm_item_master AS i ON i.item_id = t.item_id
WHERE        
(fiscal_yearmo_num BETWEEN '201901' AND '201912') AND 
(t.item_id > '')  AND
(t.item_comm_group_cd = 'ITMSND') AND 
(i.comm_group_cd = 'ITMEPS') AND 
--(t.source_cd = 'JDE') AND 
(1 = 1)

-- update history from SND to EPS
UPDATE       comm_transaction
SET                item_comm_group_cd = 'ITMEPS'
FROM            comm_transaction INNER JOIN
                         comm_item_master AS i ON i.item_id = comm_transaction.item_id
WHERE        (comm_transaction.fiscal_yearmo_num BETWEEN '201901' AND '201912') AND (comm_transaction.item_id > '') AND (comm_transaction.item_comm_group_cd = 'ITMSND') AND (i.comm_group_cd = 'ITMEPS') AND (1 = 1)