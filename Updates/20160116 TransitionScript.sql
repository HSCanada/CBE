-- CommBE Transition Plan
-- 25 Jan 16

-- 1. manual data copy to PROD - DONE

-- 2. Purge 2014 data (9min / month)

-- 3. remove unneeded tables / fields

/*

drop table audit_task
drop table audit_job
drop table comm_bonus_vendor
drop table comm_customer_history

GO
ALTER TABLE dbo.comm_transaction
	DROP CONSTRAINT comm_transaction_comm_code_fk_1
ALTER TABLE dbo.comm_transaction
	DROP COLUMN comm_cd
drop table comm_code
GO

drop table comm_order_source
drop table comm_rookie_track

GO
ALTER TABLE dbo.comm_sales_history
	DROP CONSTRAINT comm_sales_history_comm_group_fk_1
ALTER TABLE dbo.comm_sales_history
	DROP CONSTRAINT comm_sales_history_comm_salesperson_master_fk_1
ALTER TABLE dbo.comm_sales_history
	DROP CONSTRAINT comm_sales_history_comm_batch_control_fk_1
GO
drop table comm_sales_history

--{UPDATE comm_source to ID old source}
drop table STAGE_HiTechMontreal
drop table zzzCustItem
drop table zzzSalesperson

GO
ALTER TABLE dbo.comm_transaction
	DROP CONSTRAINT DF_comm_transaction_report_group_1_cd
ALTER TABLE dbo.comm_transaction
	DROP CONSTRAINT DF_comm_transaction_report_group_2_cd
ALTER TABLE dbo.comm_transaction
	DROP CONSTRAINT DF_comm_transaction_report_group_3_cd
ALTER TABLE dbo.comm_transaction
	DROP CONSTRAINT DF_comm_transaction_report_group_4_cd
ALTER TABLE dbo.comm_transaction
	DROP CONSTRAINT DF_comm_transaction_gp_ext_amt1
ALTER TABLE dbo.comm_transaction
	DROP CONSTRAINT DF_comm_transaction_tagable_item_flag
ALTER TABLE dbo.comm_transaction
	DROP CONSTRAINT DF_comm_transaction_marketing_adjustment_rt

DROP INDEX comm_transaction_c_idx_1 ON dbo.comm_transaction
ALTER TABLE dbo.comm_transaction
	DROP COLUMN division_cd, location_id, report_group_1_cd, report_group_2_cd, report_group_3_cd, report_group_4_cd, ds_gp_ext_amt, tagable_item_ind, marketing_adjustment_rt
GO

GO
ALTER TABLE dbo.comm_group
	DROP CONSTRAINT DF__comm_grou__table__1D864D1D
ALTER TABLE dbo.comm_group
	DROP CONSTRAINT DF__comm_grou__field__1E7A7156
ALTER TABLE dbo.comm_group
	DROP CONSTRAINT DF__comm_grou__field__1F6E958F
ALTER TABLE dbo.comm_group
	DROP CONSTRAINT DF__comm_grou__field__2062B9C8
ALTER TABLE dbo.comm_group
	DROP CONSTRAINT DF__comm_grou__repor__24334AAC
ALTER TABLE dbo.comm_group
	DROP CONSTRAINT DF__comm_grou__comm___270FB757
ALTER TABLE dbo.comm_group
	DROP CONSTRAINT comm_group_u_idx_1
ALTER TABLE dbo.comm_group
	DROP COLUMN table_cd, field_map_1_cd, field_map_2_cd, field_map_3_cd, report_sort_id, comm_autocalc_ind

GO

ALTER TABLE dbo.comm_item_master
	DROP CONSTRAINT DF_comm_item_master_wholesale_currency_cd
ALTER TABLE dbo.comm_item_master
	DROP CONSTRAINT DF_comm_item_master_supplier_cost_amt
ALTER TABLE dbo.comm_item_master
	DROP CONSTRAINT DF_comm_item_master_cost_unit_amt
ALTER TABLE dbo.comm_item_master
	DROP CONSTRAINT DF__comm_item__item___1D5142F3
ALTER TABLE dbo.comm_item_master
	DROP CONSTRAINT DF_comm_item_master_audit_id
ALTER TABLE dbo.comm_item_master
	DROP CONSTRAINT DF_comm_item_master_hsi_item_id
ALTER TABLE dbo.comm_item_master
	DROP CONSTRAINT DF_comm_item_master_hsi_class_major_cd
ALTER TABLE dbo.comm_item_master
	DROP CONSTRAINT DF_comm_item_master_hsi_class_submajor_cd
ALTER TABLE dbo.comm_item_master
	DROP CONSTRAINT DF_comm_item_master_hsi_class_minor_cd
ALTER TABLE dbo.comm_item_master
	DROP CONSTRAINT DF_comm_item_master_hsi_class_subminor_cd
ALTER TABLE dbo.comm_item_master
	DROP CONSTRAINT DF_comm_item_master_accpac_item_id
ALTER TABLE dbo.comm_item_master
	DROP CONSTRAINT DF_comm_item_master_IMSIZE
ALTER TABLE dbo.comm_item_master
	DROP CONSTRAINT DF_comm_item_master_IMSTRN
ALTER TABLE dbo.comm_item_master
	DROP CONSTRAINT DF_comm_item_master_IMVEND
ALTER TABLE dbo.comm_item_master
	DROP CONSTRAINT DF_comm_item_master_IMPUCD
ALTER TABLE dbo.comm_item_master
	DROP CONSTRAINT DF_comm_item_master_IMAVLC
ALTER TABLE dbo.comm_item_master
	DROP COLUMN wholesale_currency_cd, supplier_cost_amt, cost_unit_amt, item_label_cd, audit_id, hsi_item_id, hsi_class_major_cd, hsi_class_submajor_cd, hsi_class_minor_cd, hsi_class_subminor_cd, accpac_item_id, IMSIZE, IMSTRN, IMVEND, IMPUCD, IMAVLC
GO

GO
ALTER TABLE dbo.comm_salesperson_master
	DROP CONSTRAINT comm_salesperson_master_comm_batch_control_fk_1
ALTER TABLE dbo.comm_salesperson_master
	DROP CONSTRAINT comm_salesperson_master_comm_salesperson_territory_fk_1
ALTER TABLE dbo.comm_salesperson_master
	DROP CONSTRAINT DF__comm_sale__sales__4A58F394
ALTER TABLE dbo.comm_salesperson_master
	DROP CONSTRAINT DF_comm_salesperson_master_fiscal_yearmo_num
ALTER TABLE dbo.comm_salesperson_master
	DROP CONSTRAINT DF_comm_salesperson_master_division_cd
ALTER TABLE dbo.comm_salesperson_master
	DROP CONSTRAINT DF_comm_salesperson_master_cost_centre_cd
ALTER TABLE dbo.comm_salesperson_master
	DROP CONSTRAINT DF_comm_salesperson_master_PMANEW_GOAL_YTD_AMT
ALTER TABLE dbo.comm_salesperson_master
	DROP CONSTRAINT DF_comm_salesperson_master_BON001_GOAL_YTD_AMT
ALTER TABLE dbo.comm_salesperson_master
	DROP CONSTRAINT DF_comm_salesperson_master_BON001_GOAL_YTD_AMT1
ALTER TABLE dbo.comm_salesperson_master
	DROP CONSTRAINT DF_comm_salesperson_master_BON001_GOAL_YTD_AMT2
ALTER TABLE dbo.comm_salesperson_master
	DROP CONSTRAINT DF_comm_salesperson_master_BON001_GOAL_YTD_AMT3
ALTER TABLE dbo.comm_salesperson_master
	DROP CONSTRAINT DF_comm_salesperson_master_BON001_GOAL_YTD_AMT4
ALTER TABLE dbo.comm_salesperson_master
	DROP COLUMN salesperson_territory_cd, email_address_nm, hh_user_id, hh_mailbox_id, nt_domain_nm, nt_user_nm, salesperson_id, begin_dt, end_dt, laptop_order_begin_num, laptop_order_end_num, laptop_service_location_id, fixed_asset_acct_num, grip_stock_acct_num, special_order_acct_num, service_parts_acct_num, fiscal_yearmo_num, master_division_cd, cost_centre_cd, PMANEW_GOAL_YTD_AMT, BON001_GOAL_YTD_AMT, BON002_GOAL_YTD_AMT, BON003_GOAL_YTD_AMT, BON004_GOAL_YTD_AMT, BON005_GOAL_YTD_AMT
GO

GO
GO
ALTER TABLE dbo.comm_salesperson_master
	DROP CONSTRAINT DF_comm_salesperson_master_hsi_salesperson_cd
ALTER TABLE dbo.comm_salesperson_master
	DROP CONSTRAINT DF_comm_salesperson_master_fsc_comm_merch_rt
ALTER TABLE dbo.comm_salesperson_master
	DROP CONSTRAINT DF_comm_salesperson_master_fsc_comm_teeth_rt
ALTER TABLE dbo.comm_salesperson_master
	DROP CONSTRAINT DF_comm_salesperson_master_REBSND_GOAL_YTD_AMT
ALTER TABLE dbo.comm_salesperson_master
	DROP CONSTRAINT DF_comm_salesperson_master_CUSINS_GOAL_YTD_AMT
ALTER TABLE dbo.comm_salesperson_master
	DROP CONSTRAINT DF_comm_salesperson_master_REBTEE_GOAL_YTD_AMT
ALTER TABLE dbo.comm_salesperson_master
	DROP CONSTRAINT DF_comm_salesperson_master_ITMCNX_GOAL_YTD_AMT
ALTER TABLE dbo.comm_salesperson_master
	DROP CONSTRAINT DF_comm_salesperson_master_ITMDET_GOAL_YTD_AMT
ALTER TABLE dbo.comm_salesperson_master
	DROP CONSTRAINT DF_comm_salesperson_master_ITMBTI_GOAL_YTD_AMT
ALTER TABLE dbo.comm_salesperson_master
	DROP CONSTRAINT DF_comm_salesperson_master_SFFFIN_GOAL_YTD_AMT
ALTER TABLE dbo.comm_salesperson_master
	DROP COLUMN hsi_salesperson_cd, fsc_comm_merch_rt, fsc_comm_teeth_rt, REBSND_GOAL_YTD_AMT, CUSINS_GOAL_YTD_AMT, REBTEE_GOAL_YTD_AMT, ITMCNX_GOAL_YTD_AMT, ITMDET_GOAL_YTD_AMT, ITMBTI_GOAL_YTD_AMT, SFFFIN_GOAL_YTD_AMT
GO

GO
ALTER TABLE dbo.comm_plan_group_rate
	DROP CONSTRAINT comm_plan_group_rate_comm_plan_fk_2
ALTER TABLE dbo.comm_plan_group_rate
	DROP CONSTRAINT DF__comm_plan__comm___4B180DA3
ALTER TABLE dbo.comm_plan_group_rate
	DROP CONSTRAINT DF__comm_plan__comm___4C0C31DC
ALTER TABLE dbo.comm_plan_group_rate
	DROP CONSTRAINT DF__comm_plan__comm___4D005615
ALTER TABLE dbo.comm_plan_group_rate
	DROP CONSTRAINT DF__comm_plan__comm___4DF47A4E
ALTER TABLE dbo.comm_plan_group_rate
	DROP CONSTRAINT DF__comm_plan__comm___4EE89E87
ALTER TABLE dbo.comm_plan_group_rate
	DROP CONSTRAINT DF_comm_plan_group_rate_clone_comm_plan_id
ALTER TABLE dbo.comm_plan_group_rate
	DROP COLUMN comm_a_rt, comm_b_rt, comm_c_rt, comm_d_rt, comm_e_rt, clone_comm_plan_id

ALTER TABLE dbo.comm_transaction
	DROP CONSTRAINT DF_comm_transaction_super_saver_ind
GO
ALTER TABLE dbo.comm_transaction
	DROP COLUMN super_saver_ind, item_org_id, org_cost_ext_amt, org_gp_ext_amt

DELETE
FROM         comm_salesperson_master
where comm_plan_id  = 'FSCGPZZ' AND
master_salesperson_cd = '' AND
salesperson_key_id <> '' AND salesperson_key_id <> 'INTERNAL'

AND NOT EXISTS(SELECT * FROM dbo.comm_salesperson_code_map m WHERE m.salesperson_key_id = comm_salesperson_master.salesperson_key_id)

ORDER BY 3

*/
-- 4. Updated comm_plan - DONE

-- 5. Update comm_group - DONE; remap history groups  CUSINS - DONE
/*
SELECT     t.fiscal_yearmo_num, t.source_cd, t.comm_plan_id, t.salesperson_key_id, t.item_id, t.transaction_txt, i.comm_group_cd AS comm_NEW, t.comm_group_cd, 
                      t.item_comm_group_cd, t.transaction_amt, t.gp_ext_amt
FROM         comm_transaction AS t INNER JOIN
                      comm_item_master AS i ON t.item_id = i.item_id AND t.comm_group_cd <> i.comm_group_cd
WHERE     (i.comm_group_cd LIKE 'DIG%') AND (t.salesperson_key_id NOT IN ('internal', ''))
ORDER BY 10 desc

UPDATE    comm_transaction
SET              comm_group_cd = i.comm_group_cd, item_comm_group_cd = i.comm_group_cd
FROM         comm_transaction INNER JOIN
                      comm_item_master AS i ON comm_transaction.item_id = i.item_id AND comm_transaction.comm_group_cd <> i.comm_group_cd
WHERE     (i.comm_group_cd LIKE 'DIG%') AND (comm_transaction.salesperson_key_id NOT IN ('internal', ''))

-- ess

SELECT     t .fiscal_yearmo_num, t .source_cd, t .ess_comm_plan_id, t .ess_salesperson_key_id, t .item_id, t .transaction_txt, i.comm_group_cd AS comm_NEW, 
                      t .ess_comm_group_cd, t.transaction_amt, t .gp_ext_amt
FROM         comm_transaction AS t INNER JOIN
                      comm_item_master AS i ON t .item_id = i.item_id AND t .ess_comm_group_cd <> i.comm_group_cd
WHERE     (i.comm_group_cd LIKE 'DIG%') and t.ess_salesperson_key_id <>''
ORDER BY t .transaction_amt DESC

UPDATE    comm_transaction
SET              ess_comm_group_cd = i.comm_group_cd
FROM         comm_transaction INNER JOIN
                      comm_item_master AS i ON comm_transaction.item_id = i.item_id AND comm_transaction.ess_comm_group_cd <> i.comm_group_cd
WHERE     (i.comm_group_cd LIKE 'DIG%') AND (comm_transaction.ess_salesperson_key_id <> '')
*/

-- 6. Update dbo.comm_item_master (Eric list) - DONE

-- 7. DATA (copy 20512 to 201601) & Test - DONE

-- 8. Rebuild summary - DONE

-- 9. Update views FSC / ESS + CCS

-- 10. Update Plan rates

-- 11. Update Calc procs

-- 12. Test FSC / ESS / CCS with Suzanne












