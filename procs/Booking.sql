
-- FSC
/*
UPDATE    
	comm_transaction
SET              
	gp_ext_amt = comm_transaction.transaction_amt * (g.booking_rt / 100.0)
FROM         
	comm_transaction 
	
	INNER JOIN comm_group AS g 
	ON comm_transaction.item_comm_group_cd = g.comm_group_cd

WHERE     
	(g.booking_rt > 0)  AND 
	(comm_transaction.fiscal_yearmo_num = '201601' )



-- ESS -- add to Access, done 29 Feb 16

GO

UPDATE    
	comm_transaction
SET              
	gp_ext_amt = comm_transaction.transaction_amt * (g.booking_rt / 100.0)
FROM         
	comm_transaction 
	
	INNER JOIN comm_group AS g 
	ON comm_transaction.ess_comm_group_cd = g.comm_group_cd

WHERE     
	(g.booking_rt > 0)  AND 
	(comm_transaction.fiscal_yearmo_num = '201601' )

GO

*/