
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/******************************************************************************
**	File: 
**	Name: comm_ess_statement_export
**	Desc: commission summary recordset used by Access report front-end
**
**              
**
**	Auth: tmc
**	Date: 02 Mar 08
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-------	-------		-------------------------------------------
**	27 Jan 10	tmc		Updated for Comm 2010
**	26 Mar 10	tmc		Added 5 generic bonus fields
**	02 Dec 10	tmc		Trim SalespersonID and BranchNM
**  01 Mar 11	tmc		Added Free Goods and BIO Biolase Focus
**	01 Feb 13	tmc		Set Free Goods to Current month instead of arrears
**  01 Apr 13	tmc		Add ESS commission plan (to filter out retired plans
**	25 Apr 14	tmc		Replace ITMCNX with ITMMID 
**    
*******************************************************************************/
ALTER VIEW [dbo].[comm_ess_statement_export]
AS
SELECT     m.employee_num, RTRIM(m.salesperson_key_id) AS ESS_key_id, m.salesperson_nm AS ESS_nm, RTRIM(t.branch_nm) AS branch_nm, RTRIM(t.zone_nm) 
                      AS zone_nm, m.hsi_salesperson_cd AS ESS_code, m.territory_start_dt AS start_dt, s.ITMFO1_SALES_CM_AMT, s.ITMFO1_SALES_LYM_AMT, s.ITMFO1_GP_CM_AMT,
                       s.ITMFO1_SALES_YTD_AMT, s.ITMFO1_GP_YTD_AMT, s.ITMFO1_SALES_LYTD_AMT, m.ITMFO1_GOAL_YTD_AMT, s.ITMFO2_SALES_CM_AMT, 
                      s.ITMFO2_SALES_LYM_AMT, s.ITMFO2_GP_CM_AMT, s.ITMFO2_SALES_YTD_AMT, s.ITMFO2_GP_YTD_AMT, s.ITMFO2_SALES_LYTD_AMT, 
                      m.ITMFO2_GOAL_YTD_AMT, s.ITMFO3_SALES_CM_AMT, s.ITMFO3_SALES_LYM_AMT, s.ITMFO3_GP_CM_AMT, s.ITMFO3_SALES_YTD_AMT, 
                      s.ITMFO3_GP_YTD_AMT, s.ITMFO3_SALES_LYTD_AMT, m.ITMFO3_GOAL_YTD_AMT, s.ITMFRT_SALES_CM_AMT, s.ITMFRT_SALES_LYM_AMT, 
                      s.ITMFRT_GP_CM_AMT, s.ITMFRT_SALES_YTD_AMT, s.ITMFRT_GP_YTD_AMT, s.ITMFRT_SALES_LYTD_AMT, m.ITMFRT_GOAL_YTD_AMT, 
                      s.ITMMID_SALES_CM_AMT, s.ITMMID_SALES_LYM_AMT, s.ITMMID_GP_CM_AMT, s.ITMMID_SALES_YTD_AMT, s.ITMMID_GP_YTD_AMT, 
                      s.ITMMID_SALES_LYTD_AMT, m.ITMCNX_GOAL_YTD_AMT AS ITMMID_GOAL_YTD_AMT, s.SPMEQU_SALES_CM_AMT, s.SPMEQU_SALES_LYM_AMT, 
                      s.SPMEQU_GP_CM_AMT, s.SPMEQU_SALES_YTD_AMT, s.SPMEQU_GP_YTD_AMT, s.SPMEQU_SALES_LYTD_AMT, 
                      m.ITMDET_GOAL_YTD_AMT AS SPMEQU_GOAL_YTD_AMT, s.ITMBTI_SALES_CM_AMT, s.ITMBTI_SALES_LYM_AMT, s.ITMBTI_GP_CM_AMT, 
                      s.ITMBTI_SALES_YTD_AMT, s.ITMBTI_GP_YTD_AMT, s.ITMBTI_SALES_LYTD_AMT, m.ITMBTI_GOAL_YTD_AMT, s.ITMISC_SALES_CM_AMT, 
                      s.ITMISC_SALES_LYM_AMT, s.ITMISC_GP_CM_AMT, s.ITMISC_SALES_YTD_AMT, s.ITMISC_GP_YTD_AMT, s.ITMISC_SALES_LYTD_AMT, 
                      m.ITMISC_GOAL_YTD_AMT, s.ITME4D_SALES_CM_AMT, s.ITME4D_SALES_LYM_AMT, s.ITME4D_GP_CM_AMT, s.ITME4D_SALES_YTD_AMT, 
                      s.ITME4D_GP_YTD_AMT, s.ITME4D_SALES_LYTD_AMT, m.ITME4D_GOAL_YTD_AMT, s.ITMCPU_SALES_CM_AMT, s.ITMCPU_SALES_LYM_AMT, 
                      s.ITMCPU_GP_CM_AMT, s.ITMCPU_SALES_YTD_AMT, s.ITMCPU_GP_YTD_AMT, s.ITMCPU_SALES_LYTD_AMT, m.ITMCPU_GOAL_YTD_AMT, 
                      s.SFFFIN_SALES_CM_AMT, s.SFFFIN_SALES_LYM_AMT, s.SFFFIN_GP_CM_AMT, s.SFFFIN_SALES_YTD_AMT, s.SFFFIN_GP_YTD_AMT, 
                      s.SFFFIN_SALES_LYTD_AMT, m.SFFFIN_GOAL_YTD_AMT, s.SFFVEN_COMM_CM_AMT, s.ADJEBU_COMM_CM_AMT, s.ADJOTH_COMM_CM_AMT, 
                      s.ADJARP_COMM_CM_AMT, s.ADJARB_COMM_CM_AMT, s.SALD30_COMM_CM_AMT, s.STMPBA_COMM_CM_AMT, s.ITMSOF_SALES_CM_AMT, 
                      s.ITMSOF_SALES_LYM_AMT, s.ITMSOF_GP_CM_AMT, s.ITMSOF_COMM_CM_AMT, s.ITMSOF_SALES_YTD_AMT, s.ITMSOF_GP_YTD_AMT, 
                      s.ITMSOF_SALES_LYTD_AMT, m.ITMSOF_GOAL_YTD_AMT, m.BON001_GOAL_YTD_AMT, m.BON002_GOAL_YTD_AMT, m.BON003_GOAL_YTD_AMT, 
                      m.BON004_GOAL_YTD_AMT, m.BON005_GOAL_YTD_AMT, s.FRESEQ_GP_CM_AMT, s.FRESEQ_COMM_CM_AMT, s.FRESEQ_GP_YTD_AMT, 
                      s.BIOFO1_SALES_CM_AMT, s.BIOFO1_GP_CM_AMT, s.BIOFO1_SALES_YTD_AMT, s.BIOFO1_GP_YTD_AMT, s.REDTAG_SALES_CM_AMT, s.REDTAG_GP_CM_AMT, 
                      s.REDTAG_SALES_YTD_AMT, s.REDTAG_GP_YTD_AMT, m.comm_plan_id AS ESS_comm_plan_id
FROM         (SELECT     salesperson_key_id, SUM(CASE WHEN comm_group_cd = 'ITMFO1' THEN ss.sales_curr_amt ELSE 0 END) AS ITMFO1_SALES_CM_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITMFO1' THEN ss.sales_ref_amt ELSE 0 END) AS ITMFO1_SALES_LYM_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITMFO1' THEN ss.gp_curr_amt ELSE 0 END) AS ITMFO1_GP_CM_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITMFO1' THEN ss.comm_curr_amt ELSE 0 END) AS ITMFO1_COMM_CM_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITMFO1' THEN ss.sales_ytd_amt + ss.sales_curr_amt ELSE 0 END) AS ITMFO1_SALES_YTD_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITMFO1' THEN ss.gp_ytd_amt + ss.gp_curr_amt ELSE 0 END) AS ITMFO1_GP_YTD_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITMFO1' THEN ss.sales_ly_amt + ss.sales_ref_amt ELSE 0 END) AS ITMFO1_SALES_LYTD_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITMFO2' THEN ss.sales_curr_amt ELSE 0 END) AS ITMFO2_SALES_CM_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITMFO2' THEN ss.sales_ref_amt ELSE 0 END) AS ITMFO2_SALES_LYM_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITMFO2' THEN ss.gp_curr_amt ELSE 0 END) AS ITMFO2_GP_CM_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITMFO2' THEN ss.comm_curr_amt ELSE 0 END) AS ITMFO2_COMM_CM_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITMFO2' THEN ss.sales_ytd_amt + ss.sales_curr_amt ELSE 0 END) AS ITMFO2_SALES_YTD_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITMFO2' THEN ss.gp_ytd_amt + ss.gp_curr_amt ELSE 0 END) AS ITMFO2_GP_YTD_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITMFO2' THEN ss.sales_ly_amt + ss.sales_ref_amt ELSE 0 END) AS ITMFO2_SALES_LYTD_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITMFO3' THEN ss.sales_curr_amt ELSE 0 END) AS ITMFO3_SALES_CM_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITMFO3' THEN ss.sales_ref_amt ELSE 0 END) AS ITMFO3_SALES_LYM_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITMFO3' THEN ss.gp_curr_amt ELSE 0 END) AS ITMFO3_GP_CM_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITMFO3' THEN ss.comm_curr_amt ELSE 0 END) AS ITMFO3_COMM_CM_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITMFO3' THEN ss.sales_ytd_amt + ss.sales_curr_amt ELSE 0 END) AS ITMFO3_SALES_YTD_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITMFO3' THEN ss.gp_ytd_amt + ss.gp_curr_amt ELSE 0 END) AS ITMFO3_GP_YTD_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITMFO3' THEN ss.sales_ly_amt + ss.sales_ref_amt ELSE 0 END) AS ITMFO3_SALES_LYTD_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITMFRT' THEN ss.sales_curr_amt ELSE 0 END) AS ITMFRT_SALES_CM_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITMFRT' THEN ss.sales_ref_amt ELSE 0 END) AS ITMFRT_SALES_LYM_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITMFRT' THEN ss.gp_curr_amt ELSE 0 END) AS ITMFRT_GP_CM_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITMFRT' THEN ss.comm_curr_amt ELSE 0 END) AS ITMFRT_COMM_CM_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITMFRT' THEN ss.sales_ytd_amt + ss.sales_curr_amt ELSE 0 END) AS ITMFRT_SALES_YTD_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITMFRT' THEN ss.gp_ytd_amt + ss.gp_curr_amt ELSE 0 END) AS ITMFRT_GP_YTD_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITMFRT' THEN ss.sales_ly_amt + ss.sales_ref_amt ELSE 0 END) AS ITMFRT_SALES_LYTD_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITMMID' THEN ss.sales_curr_amt ELSE 0 END) AS ITMMID_SALES_CM_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITMMID' THEN ss.sales_ref_amt ELSE 0 END) AS ITMMID_SALES_LYM_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITMMID' THEN ss.gp_curr_amt ELSE 0 END) AS ITMMID_GP_CM_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITMMID' THEN ss.comm_curr_amt ELSE 0 END) AS ITMMID_COMM_CM_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITMMID' THEN ss.sales_ytd_amt + ss.sales_curr_amt ELSE 0 END) AS ITMMID_SALES_YTD_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITMMID' THEN ss.gp_ytd_amt + ss.gp_curr_amt ELSE 0 END) AS ITMMID_GP_YTD_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITMMID' THEN ss.sales_ly_amt + ss.sales_ref_amt ELSE 0 END) AS ITMMID_SALES_LYTD_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'SPMEQU' THEN ss.sales_curr_amt ELSE 0 END) AS SPMEQU_SALES_CM_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'SPMEQU' THEN ss.sales_ref_amt ELSE 0 END) AS SPMEQU_SALES_LYM_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'SPMEQU' THEN ss.gp_curr_amt ELSE 0 END) AS SPMEQU_GP_CM_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'SPMEQU' THEN ss.comm_curr_amt ELSE 0 END) AS SPMEQU_COMM_CM_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'SPMEQU' THEN ss.sales_ytd_amt + ss.sales_curr_amt ELSE 0 END) AS SPMEQU_SALES_YTD_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'SPMEQU' THEN ss.gp_ytd_amt + ss.gp_curr_amt ELSE 0 END) AS SPMEQU_GP_YTD_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'SPMEQU' THEN ss.sales_ly_amt + ss.sales_ref_amt ELSE 0 END) AS SPMEQU_SALES_LYTD_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITMBTI' THEN ss.sales_curr_amt ELSE 0 END) AS ITMBTI_SALES_CM_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITMBTI' THEN ss.sales_ref_amt ELSE 0 END) AS ITMBTI_SALES_LYM_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITMBTI' THEN ss.gp_curr_amt ELSE 0 END) AS ITMBTI_GP_CM_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITMBTI' THEN ss.comm_curr_amt ELSE 0 END) AS ITMBTI_COMM_CM_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITMBTI' THEN ss.sales_ytd_amt + ss.sales_curr_amt ELSE 0 END) AS ITMBTI_SALES_YTD_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITMBTI' THEN ss.gp_ytd_amt + ss.gp_curr_amt ELSE 0 END) AS ITMBTI_GP_YTD_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITMBTI' THEN ss.sales_ly_amt + ss.sales_ref_amt ELSE 0 END) AS ITMBTI_SALES_LYTD_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITMISC' THEN ss.sales_curr_amt ELSE 0 END) AS ITMISC_SALES_CM_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITMISC' THEN ss.sales_ref_amt ELSE 0 END) AS ITMISC_SALES_LYM_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITMISC' THEN ss.gp_curr_amt ELSE 0 END) AS ITMISC_GP_CM_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITMISC' THEN ss.comm_curr_amt ELSE 0 END) AS ITMISC_COMM_CM_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITMISC' THEN ss.sales_ytd_amt + ss.sales_curr_amt ELSE 0 END) AS ITMISC_SALES_YTD_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITMISC' THEN ss.gp_ytd_amt + ss.gp_curr_amt ELSE 0 END) AS ITMISC_GP_YTD_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITMISC' THEN ss.sales_ly_amt + ss.sales_ref_amt ELSE 0 END) AS ITMISC_SALES_LYTD_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITME4D' THEN ss.sales_curr_amt ELSE 0 END) AS ITME4D_SALES_CM_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITME4D' THEN ss.sales_ref_amt ELSE 0 END) AS ITME4D_SALES_LYM_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITME4D' THEN ss.gp_curr_amt ELSE 0 END) AS ITME4D_GP_CM_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITME4D' THEN ss.comm_curr_amt ELSE 0 END) AS ITME4D_COMM_CM_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITME4D' THEN ss.sales_ytd_amt + ss.sales_curr_amt ELSE 0 END) AS ITME4D_SALES_YTD_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITME4D' THEN ss.gp_ytd_amt + ss.gp_curr_amt ELSE 0 END) AS ITME4D_GP_YTD_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITME4D' THEN ss.sales_ly_amt + ss.sales_ref_amt ELSE 0 END) AS ITME4D_SALES_LYTD_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITMCPU' THEN ss.sales_curr_amt ELSE 0 END) AS ITMCPU_SALES_CM_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITMCPU' THEN ss.sales_ref_amt ELSE 0 END) AS ITMCPU_SALES_LYM_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITMCPU' THEN ss.gp_curr_amt ELSE 0 END) AS ITMCPU_GP_CM_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITMCPU' THEN ss.comm_curr_amt ELSE 0 END) AS ITMCPU_COMM_CM_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITMCPU' THEN ss.sales_ytd_amt + ss.sales_curr_amt ELSE 0 END) AS ITMCPU_SALES_YTD_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITMCPU' THEN ss.gp_ytd_amt + ss.gp_curr_amt ELSE 0 END) AS ITMCPU_GP_YTD_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITMCPU' THEN ss.sales_ly_amt + ss.sales_ref_amt ELSE 0 END) AS ITMCPU_SALES_LYTD_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'SFFFIN' THEN ss.sales_curr_amt ELSE 0 END) AS SFFFIN_SALES_CM_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'SFFFIN' THEN ss.sales_ref_amt ELSE 0 END) AS SFFFIN_SALES_LYM_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'SFFFIN' THEN ss.gp_curr_amt ELSE 0 END) AS SFFFIN_GP_CM_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'SFFFIN' THEN ss.comm_curr_amt ELSE 0 END) AS SFFFIN_COMM_CM_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'SFFFIN' THEN ss.sales_ytd_amt + ss.sales_curr_amt ELSE 0 END) AS SFFFIN_SALES_YTD_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'SFFFIN' THEN ss.gp_ytd_amt + ss.gp_curr_amt ELSE 0 END) AS SFFFIN_GP_YTD_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'SFFFIN' THEN ss.sales_ly_amt + ss.sales_ref_amt ELSE 0 END) AS SFFFIN_SALES_LYTD_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITMSOF' THEN ss.sales_curr_amt ELSE 0 END) AS ITMSOF_SALES_CM_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITMSOF' THEN ss.sales_ref_amt ELSE 0 END) AS ITMSOF_SALES_LYM_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITMSOF' THEN ss.gp_curr_amt ELSE 0 END) AS ITMSOF_GP_CM_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITMSOF' THEN ss.comm_curr_amt ELSE 0 END) AS ITMSOF_COMM_CM_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITMSOF' THEN ss.sales_ytd_amt + ss.sales_curr_amt ELSE 0 END) AS ITMSOF_SALES_YTD_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITMSOF' THEN ss.gp_ytd_amt + ss.gp_curr_amt ELSE 0 END) AS ITMSOF_GP_YTD_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ITMSOF' THEN ss.sales_ly_amt + ss.sales_ref_amt ELSE 0 END) AS ITMSOF_SALES_LYTD_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'SFFVEN' THEN ss.comm_curr_amt ELSE 0 END) AS SFFVEN_COMM_CM_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ADJEBU' THEN ss.comm_curr_amt ELSE 0 END) AS ADJEBU_COMM_CM_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ADJOTH' THEN ss.comm_curr_amt ELSE 0 END) AS ADJOTH_COMM_CM_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ADJARP' THEN ss.comm_curr_amt ELSE 0 END) AS ADJARP_COMM_CM_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'ADJARB' THEN ss.comm_curr_amt ELSE 0 END) AS ADJARB_COMM_CM_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'SALD30' THEN ss.comm_curr_amt ELSE 0 END) AS SALD30_COMM_CM_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'STMPBA' THEN ss.comm_curr_amt ELSE 0 END) AS STMPBA_COMM_CM_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'FRESEQ' THEN ss.gp_curr_amt ELSE 0 END) AS FRESEQ_GP_CM_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'FRESEQ' THEN ss.comm_curr_amt ELSE 0 END) AS FRESEQ_COMM_CM_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'FRESEQ' THEN ss.gp_ytd_amt + ss.gp_curr_amt ELSE 0 END) AS FRESEQ_GP_YTD_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'BIOFO1' THEN ss.sales_curr_amt ELSE 0 END) AS BIOFO1_SALES_CM_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'BIOFO1' THEN ss.gp_curr_amt ELSE 0 END) AS BIOFO1_GP_CM_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'BIOFO1' THEN ss.sales_ytd_amt + ss.sales_curr_amt ELSE 0 END) AS BIOFO1_SALES_YTD_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'BIOFO1' THEN ss.gp_ytd_amt + ss.gp_curr_amt ELSE 0 END) AS BIOFO1_GP_YTD_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'REDTAG' THEN ss.sales_curr_amt ELSE 0 END) AS REDTAG_SALES_CM_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'REDTAG' THEN ss.gp_curr_amt ELSE 0 END) AS REDTAG_GP_CM_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'REDTAG' THEN ss.sales_ytd_amt + ss.sales_curr_amt ELSE 0 END) AS REDTAG_SALES_YTD_AMT, 
                                              SUM(CASE WHEN comm_group_cd = 'REDTAG' THEN ss.gp_ytd_amt + ss.gp_curr_amt ELSE 0 END) AS REDTAG_GP_YTD_AMT
                       FROM          dbo.comm_summary AS ss
                       WHERE      (comm_group_cd <> '') AND (salesperson_key_id <> '')
                       GROUP BY salesperson_key_id) AS s INNER JOIN
                      dbo.comm_salesperson_master AS m ON s.salesperson_key_id = m.salesperson_key_id INNER JOIN
                      dbo.comm_salesperson_territory_map AS t ON m.salesperson_territory_cd = t.salesperson_territory_cd
WHERE     (m.comm_plan_id LIKE 'ESS%')
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

