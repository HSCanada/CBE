
-- FSC

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

-- ESS

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

/*
SELECT     comm_transaction.comm_group_cd, comm_transaction.transaction_amt, comm_transaction.gp_ext_amt, comm_transaction.gp_ext_amt / comm_transaction.transaction_amt, g.booking_rt
FROM         comm_transaction INNER JOIN
                      comm_group AS g ON comm_transaction.comm_group_cd = g.comm_group_cd
WHERE     (g.booking_act_ind = 1) AND (comm_transaction.fiscal_yearmo_num = '201412') AND comm_transaction.transaction_amt <> 0
*/