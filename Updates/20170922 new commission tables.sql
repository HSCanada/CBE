SELECT 

    Top 5 
    "WSCO" AS WSCO___company,
	"WSDOCO" AS WSDOCO_salesorder_number,
	"WSDCTO" AS WSDCTO_order_type,
	"WSLNTY" AS WSLNTY_line_type,
	"WSLNID" AS WSLNID_line_number,
	"WS$OSC" AS WS$OSC_order_source_code,
	"WSAN8" AS WSAN8__billto,
	"WSSHAN" AS WSSHAN_shipto,
	"WSDGL" AS WSDGL__gl_date,
	"WSLITM" AS WSLITM_item_number,
	"WSDSC1" AS WSDSC1_description,
	"WSDSC2" AS WSDSC2_description_2,
	"WSSRP1" AS WSSRP1_major_product_class,
	"WSSRP2" AS WSSRP2_sub_major_product_class,
	"WSSRP3" AS WSSRP3_minor_product_class,
	"WSSRP6" AS WSSRP6_manufacturer,
	"WSUORG" AS WSUORG_quantity,
	"WSSOQS" AS WSSOQS_quantity_shipped,
	"WSAEXP" AS WSAEXP_extended_price,
	"WSURAT" AS WSURAT_user_reserved_amount,
	"WS$UNC" AS WS$UNC_sales_order_cost_markup,
	"WSOORN" AS WSOORN_original_order_number,
	"WSOCTO" AS WSOCTO_original_order_type,
	"WSOGNO" AS WSOGNO_original_line_number,
	"WSTRDJ" AS WSTRDJ_order_date,
	"WSVR01" AS WSVR01_reference,
	"WSVR02" AS WSVR02_reference_2,
	"WSITM" AS WSITM__item_number_short,
	"WSPROV" AS WSPROV_price_override_code,
	"WSASN" AS WSASN__adjustment_schedule,
	"WSKCO" AS WSKCO__document_company,
	"WSDOC" AS WSDOC__document_number,
	"WSDCT" AS WSDCT__document_type,
	"WSPSN" AS WSPSN__pick_slip_number,
	"WSROUT" AS WSROUT_ship_method,
	"WSZON" AS WSZON__zone_number,
	"WSFRTH" AS WSFRTH_freight_handling_code,
	"WSFRAT" AS WSFRAT_rate_code_freightmisc,
	"WSRATT" AS WSRATT_rate_type_freightmisc,
	"WSGLC" AS WSGLC__gl_offset,
	"WSSO08" AS WSSO08_price_adjustment_line_indicator,
	"WSENTB" AS WSENTB_entered_by,
	"WS$PMC" AS WS$PMC_promotion_code_price_method,
	"WSTKBY" AS WSTKBY_order_taken_by,
	"WSKTLN" AS WSKTLN_kit_master_line_number,
	"WSCOMM" AS WSCOMM_committed_hs,
	"WSEMCU" AS WSEMCU_header_business_unit,
	"WS$SPC" AS WS$SPC_supplier_code,
	"WS$VCD" AS WS$VCD_vendor_code,
	"WS$CLC" AS WS$CLC_classification_code,
	"WSCYCL" AS WSCYCL_cycle_count_category,
	"WSORD" AS WSORD__equipment_order,
	"WSORDT" AS WSORDT_order_type,
	"WSCAG" AS WSCAG__cagess_code,
	"WSEST" AS WSEST__employment_status,
	"WS$ESS" AS WS$ESS_equipment_specialist_code,
	"WS$TSS" AS WS$TSS_tech_specialist_code,
	"WS$CCS" AS WS$CCS_cadcam_specialist_code,
	"WS$NM1" AS WS$NM1__name_1,
	"WS$NM3" AS WS$NM3_researched_by,
	"WS$NM4" AS WS$NM4_completed_by,
	"WS$NM5" AS WS$NM5__name_5,
	"WS$L01" AS WS$L01_level_code_01,
	"WSSRP4" AS WSSRP4_sub_minor_product_class,
	"WSCITM" AS WSCITM_customersupplier_item_number,
	"WSSIC" AS WSSIC__speciality,
	"WSAC04" AS WSAC04_practice_type,
	"WSAC10" AS WSAC10_division_code,
	"WS$O01" AS WS$O01_number_equipment_serial_01,
	"WS$O02" AS WS$O02_number_equipment_serial_02,
	"WS$O03" AS WS$O03_number_equipment_serial_03,
	"WS$O04" AS WS$O04_number_equipment_serial_04,
	"WS$O05" AS WS$O05_number_equipment_serial_05,
	"WS$O06" AS WS$O06_number_equipment_serial_06,
	"WSDL03" AS WSDL03_description_03,
	"WS$ODS" AS WS$ODS_order_discount_amount 

INTO Integration.F555115_commission_sales_extract_Staging

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		WSCO,
		WSDOCO,
		WSDCTO,
		WSLNTY,
		CAST((WSLNID)/1000.0 AS DEC(15,3)) AS WSLNID,
		WS$OSC,
		WSAN8,
		WSSHAN,
		CASE WHEN WSDGL IS NOT NULL THEN DATE(DIGITS(DEC(WSDGL+ 1900000,7,0))) ELSE NULL END AS WSDGL,
		WSLITM,
		WSDSC1,
		WSDSC2,
		WSSRP1,
		WSSRP2,
		WSSRP3,
		WSSRP6,
		WSUORG,
		WSSOQS,
		CAST((WSAEXP)/100.0 AS DEC(15,2)) AS WSAEXP,
		CAST((WSURAT)/100.0 AS DEC(15,2)) AS WSURAT,
		CAST((WS$UNC)/10000.0 AS DEC(15,4)) AS WS$UNC,
		WSOORN,
		WSOCTO,
		CAST((WSOGNO)/1000.0 AS DEC(15,3)) AS WSOGNO,
		CASE WHEN WSTRDJ IS NOT NULL THEN DATE(DIGITS(DEC(WSTRDJ+ 1900000,7,0))) ELSE NULL END AS WSTRDJ,
		WSVR01,
		WSVR02,
		WSITM,
		WSPROV,
		WSASN,
		WSKCO,
		WSDOC,
		WSDCT,
		WSPSN,
		WSROUT,
		WSZON,
		WSFRTH,
		WSFRAT,
		WSRATT,
		WSGLC,
		WSSO08,
		WSENTB,
		WS$PMC,
		WSTKBY,
		CAST((WSKTLN)/1000.0 AS DEC(15,3)) AS WSKTLN,
		WSCOMM,
		WSEMCU,
		WS$SPC,
		WS$VCD,
		WS$CLC,
		WSCYCL,
		WSORD,
		WSORDT,
		WSCAG,
		WSEST,
		WS$ESS,
		WS$TSS,
		WS$CCS,
		WS$NM1,
		WS$NM3,
		WS$NM4,
		WS$NM5,
		WS$L01,
		WSSRP4,
		WSCITM,
		WSSIC,
		WSAC04,
		WSAC10,
		WS$O01,
		WS$O02,
		WS$O03,
		WS$O04,
		WS$O05,
		WS$O06,
		WSDL03,
		CAST((WS$ODS)/100.0 AS DEC(15,2)) AS WS$ODS

	FROM
		ARCPDTA71.F555115
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')


SELECT        WSDOCO_salesorder_number, WSDCTO_order_type, WSLNID_line_number, COUNT(*) AS Expr1
FROM            Integration.F555115_commission_sales_extract_Staging AS s
GROUP BY WSDOCO_salesorder_number, WSDCTO_order_type, WSLNID_line_number
HAVING        (COUNT(*) > 1)


ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	F555115_commission_sales_extract_Staging_c_pk PRIMARY KEY CLUSTERED 
	(
	WSDOCO_salesorder_number,
	WSDCTO_order_type,
	WSLNID_line_number
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA

GO


--------------------------------------------------------------------------------
-- DROP TABLE STAGE_JDE_ARCPDTA71_F5830_<instert_friendly_name_here>
--------------------------------------------------------------------------------

SELECT 

    Top 5 
    "VA$CN2" AS VA$CN2_contract_number, "VAKCOO" AS VAKCOO_order_number_document_company, "VA$EON" AS VA$EON_manufacturers_external_contract_number, "VADESC" AS VADESC_description, "VA$FD" AS VA$FD__start_date, "VA$TD" AS VA$TD__end_date, "VAEFTB" AS VAEFTB_start_effective_date, "VA$DCA" AS VA$DCA_date_contract_activated, "VAODDJ" AS VAODDJ_original_due_date, "VADGCG" AS VADGCG_change_date, "VACNDJ" AS VACNDJ_cancel_date, "VAEXDJ" AS VAEXDJ_expired_date, "VASRP6" AS VASRP6_manufacturer, "VA$MA1" AS VA$MA1_alternate_manufacturer_1, "VA$MA2" AS VA$MA2_alternate_manufacturer_2, "VA$MA3" AS VA$MA3_alternate_manufacturer_3, "VA$MA4" AS VA$MA4_alternate_manufacturer_4, "VA$MA5" AS VA$MA5_alternate_manufacturer_5, "VA$MA6" AS VA$MA6_alternate_manufacturer_6, "VAUSA1" AS VAUSA1_address_number_1_user, "VAGCNT" AS VAGCNT_contract_number, "VACRTU" AS VACRTU_created_by_user, "VACRDJ" AS VACRDJ_creation_date, "VAUPMB" AS VAUPMB_updated_by, "VA$SLM" AS VA$SLM_sales_approval, "VA$VAP" AS VA$VAP_vendor_approval, "VA$OTY" AS VA$OTY_transaction_type, "VA$PCF" AS VA$PCF_chargeback_cycle, "VA$AFC" AS VA$AFC_admin_fee_cycle, "VA$OTP" AS VA$OTP_chargeback_output_type, "VA$CST" AS VA$CST_status_chargebacks, "VA$FGY" AS VA$FGY_multi_purpose_flag, "VA$CRN" AS VA$CRN_number_contract_cross_reference, "VA$IAS" AS VA$IAS_status_include_all_sales, "VA$FMT" AS VA$FMT_edi_document_format, "VA$HIN" AS VA$HIN_hindea_required, "VA$CPT" AS VA$CPT_chargeback_payment_type, "VA$SCG" AS VA$SCG_service_charge_percent_admin_fee, "VA$PC1" AS VA$PC1_chargeback_percent_factors_1, "VA$FC1" AS VA$FC1_chargeback_dollar_factors_1, "VA$RET" AS VA$RET_retro, "VA$RPV" AS VA$RPV_retro_processed_values, "VA$RD" AS VA$RD__reset_chargeback_data, "VA$RC" AS VA$RC__recurring_chargeback, "VA$CL" AS VA$CL__chargeback_calc_type, "VA$TOC" AS VA$TOC_type_of_cost, "VA$CAL" AS VA$CAL_contract_accumulation_level, "VA$BIS" AS VA$BIS_bid_incoming_sequence_number, "VA$CLV" AS VA$CLV_contract_level, "VALINN" AS VALINN_line_number, "VABA" AS VABA___beginning_gl_account_number, "VARP07" AS VARP07_category_code_07, "VARP10" AS VARP10_category_code_10, "VA$FG1" AS VA$FG1_flag_1, "VA$CMT" AS VA$CMT_comment, "VACONC" AS VACONC_compressed_contract_name, "VAPH2" AS VAPH2__phone_number, "VAEML" AS VAEML__email_address, "VAURAT" AS VAURAT_user_reserved_amount, "VAURCD" AS VAURCD_user_reserved_code, "VAURDT" AS VAURDT_user_reserved_date, "VAURAB" AS VAURAB_user_reserved_number, "VAURRF" AS VAURRF_user_reserved_reference, "VA$RV1" AS VA$RV1_user_reserved_field, "VA$RV2" AS VA$RV2_user_reserved_field, "VA$RV3" AS VA$RV3_user_reserved_field, "VA$RV4" AS VA$RV4_user_reserved_field, "VA$RV5" AS VA$RV5_user_reserved_field, "VAURC1" AS VAURC1_user_reserved_code, "VAURC2" AS VAURC2_user_reserved_code, "VAUSD1" AS VAUSD1_user_date_1, "VAUSD2" AS VAUSD2_user_date_2, "VAUSD3" AS VAUSD3_user_date_3, "VAUDC1" AS VAUDC1_user_defined_code__1, "VAUDC2" AS VAUDC2_user_defined_code__2, "VAUDC3" AS VAUDC3_user_defined_code__3, "VA$AM1" AS VA$AM1_user_amount_future_1, "VA$AM2" AS VA$AM2_user_amount_future_2, "VA$AM3" AS VA$AM3_user_amount_future_3, "VAUSER" AS VAUSER_user_id, "VAJOBN" AS VAJOBN_work_station_id, "VAPID" AS VAPID__program_id, "VAUPMJ" AS VAUPMJ_date_updated, "VATDAY" AS VATDAY_time_of_day 

-- INTO etl.ARCPDTA71_F5830_<instert_friendly_name_here>

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		VA$CN2, VAKCOO, VA$EON, VADESC, CASE WHEN VA$FD IS NOT NULL THEN DATE(DIGITS(DEC(VA$FD+ 1900000,7,0))) ELSE NULL END AS VA$FD, CASE WHEN VA$TD IS NOT NULL THEN DATE(DIGITS(DEC(VA$TD+ 1900000,7,0))) ELSE NULL END AS VA$TD, CASE WHEN VAEFTB IS NOT NULL THEN DATE(DIGITS(DEC(VAEFTB+ 1900000,7,0))) ELSE NULL END AS VAEFTB, CASE WHEN VA$DCA IS NOT NULL THEN DATE(DIGITS(DEC(VA$DCA+ 1900000,7,0))) ELSE NULL END AS VA$DCA, CASE WHEN VAODDJ IS NOT NULL THEN DATE(DIGITS(DEC(VAODDJ+ 1900000,7,0))) ELSE NULL END AS VAODDJ, CASE WHEN VADGCG IS NOT NULL THEN DATE(DIGITS(DEC(VADGCG+ 1900000,7,0))) ELSE NULL END AS VADGCG, CASE WHEN VACNDJ IS NOT NULL THEN DATE(DIGITS(DEC(VACNDJ+ 1900000,7,0))) ELSE NULL END AS VACNDJ, CASE WHEN VAEXDJ IS NOT NULL THEN DATE(DIGITS(DEC(VAEXDJ+ 1900000,7,0))) ELSE NULL END AS VAEXDJ, VASRP6, VA$MA1, VA$MA2, VA$MA3, VA$MA4, VA$MA5, VA$MA6, VAUSA1, VAGCNT, VACRTU, CASE WHEN VACRDJ IS NOT NULL THEN DATE(DIGITS(DEC(VACRDJ+ 1900000,7,0))) ELSE NULL END AS VACRDJ, VAUPMB, VA$SLM, VA$VAP, VA$OTY, VA$PCF, VA$AFC, VA$OTP, VA$CST, VA$FGY, VA$CRN, VA$IAS, VA$FMT, VA$HIN, VA$CPT, CAST((VA$SCG)/10.0 AS DEC(15,1)) AS VA$SCG, CAST((VA$PC1)/100.0 AS DEC(15,2)) AS VA$PC1, CAST((VA$FC1)/100.0 AS DEC(15,2)) AS VA$FC1, VA$RET, VA$RPV, VA$RD, VA$RC, VA$CL, VA$TOC, VA$CAL, VA$BIS, VA$CLV, CAST((VALINN)/1000.0 AS DEC(15,3)) AS VALINN, VABA, VARP07, VARP10, VA$FG1, VA$CMT, VACONC, VAPH2, VAEML, CAST((VAURAT)/100.0 AS DEC(15,2)) AS VAURAT, VAURCD, CASE WHEN VAURDT IS NOT NULL THEN DATE(DIGITS(DEC(VAURDT+ 1900000,7,0))) ELSE NULL END AS VAURDT, VAURAB, VAURRF, VA$RV1, VA$RV2, VA$RV3, VA$RV4, VA$RV5, VAURC1, VAURC2, CASE WHEN VAUSD1 IS NOT NULL THEN DATE(DIGITS(DEC(VAUSD1+ 1900000,7,0))) ELSE NULL END AS VAUSD1, CASE WHEN VAUSD2 IS NOT NULL THEN DATE(DIGITS(DEC(VAUSD2+ 1900000,7,0))) ELSE NULL END AS VAUSD2, CASE WHEN VAUSD3 IS NOT NULL THEN DATE(DIGITS(DEC(VAUSD3+ 1900000,7,0))) ELSE NULL END AS VAUSD3, VAUDC1, VAUDC2, VAUDC3, CAST((VA$AM1)/100.0 AS DEC(15,2)) AS VA$AM1, CAST((VA$AM2)/100.0 AS DEC(15,2)) AS VA$AM2, CAST((VA$AM3)/100.0 AS DEC(15,2)) AS VA$AM3, VAUSER, VAJOBN, VAPID, CASE WHEN VAUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(VAUPMJ+ 1900000,7,0))) ELSE NULL END AS VAUPMJ, VATDAY

	FROM
		ARCPDTA71.F5830
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')


--------------------------------------------------------------------------------
-- DROP TABLE STAGE_JDE_ARCPDTA71_F5831_<instert_friendly_name_here>
--------------------------------------------------------------------------------

SELECT 

    Top 5 
    "VB$CN2" AS VB$CN2_contract_number, "VBKCOO" AS VBKCOO_order_number_document_company, "VB$EON" AS VB$EON_manufacturers_external_contract_number, "VBSRP6" AS VBSRP6_manufacturer, "VBLITM" AS VBLITM_item_number, "VBCITM" AS VBCITM_customersupplier_item_number, "VBSRP1" AS VBSRP1_major_product_class, "VBSRP2" AS VBSRP2_sub_major_product_class, "VBSRP3" AS VBSRP3_minor_product_class, "VBSRP4" AS VBSRP4_sub_minor_product_class, "VBLINN" AS VBLINN_line_number, "VB$FD" AS VB$FD__start_date, "VB$TD" AS VB$TD__end_date, "VB$CCC" AS VB$CCC_cost_contract_cost_chargebacks, "VB$FC1" AS VB$FC1_chargeback_dollar_factors_1, "VB$PC1" AS VB$PC1_chargeback_percent_factors_1, "VB$MNC" AS VB$MNC_manual_cost_chargebacks, "VB$IS" AS VB$IS__contract_item_status, "VBCRTU" AS VBCRTU_created_by_user, "VBCRDJ" AS VBCRDJ_creation_date, "VBDGCG" AS VBDGCG_change_date, "VBUPMB" AS VBUPMB_updated_by, "VB$CRN" AS VB$CRN_number_contract_cross_reference, "VBAC10" AS VBAC10_division_code, "VBSIC" AS VBSIC__speciality, "VBURAT" AS VBURAT_user_reserved_amount, "VBURCD" AS VBURCD_user_reserved_code, "VBURDT" AS VBURDT_user_reserved_date, "VBURAB" AS VBURAB_user_reserved_number, "VBURRF" AS VBURRF_user_reserved_reference, "VB$RV1" AS VB$RV1_user_reserved_field, "VB$RV2" AS VB$RV2_user_reserved_field, "VB$RV3" AS VB$RV3_user_reserved_field, "VB$RV4" AS VB$RV4_user_reserved_field, "VB$RV5" AS VB$RV5_user_reserved_field, "VBURC1" AS VBURC1_user_reserved_code, "VBURC2" AS VBURC2_user_reserved_code, "VBUSD1" AS VBUSD1_user_date_1, "VBUSD2" AS VBUSD2_user_date_2, "VBUSD3" AS VBUSD3_user_date_3, "VBUDC1" AS VBUDC1_user_defined_code__1, "VBUDC2" AS VBUDC2_user_defined_code__2, "VBUDC3" AS VBUDC3_user_defined_code__3, "VB$AM1" AS VB$AM1_user_amount_future_1, "VB$AM2" AS VB$AM2_user_amount_future_2, "VB$AM3" AS VB$AM3_user_amount_future_3, "VBUSER" AS VBUSER_user_id, "VBJOBN" AS VBJOBN_work_station_id, "VBPID" AS VBPID__program_id, "VBUPMJ" AS VBUPMJ_date_updated, "VBTDAY" AS VBTDAY_time_of_day 

-- INTO etl.ARCPDTA71_F5831_<instert_friendly_name_here>

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		VB$CN2, VBKCOO, VB$EON, VBSRP6, VBLITM, VBCITM, VBSRP1, VBSRP2, VBSRP3, VBSRP4, CAST((VBLINN)/1000.0 AS DEC(15,3)) AS VBLINN, CASE WHEN VB$FD IS NOT NULL THEN DATE(DIGITS(DEC(VB$FD+ 1900000,7,0))) ELSE NULL END AS VB$FD, CASE WHEN VB$TD IS NOT NULL THEN DATE(DIGITS(DEC(VB$TD+ 1900000,7,0))) ELSE NULL END AS VB$TD, CAST((VB$CCC)/100.0 AS DEC(15,2)) AS VB$CCC, CAST((VB$FC1)/100.0 AS DEC(15,2)) AS VB$FC1, CAST((VB$PC1)/100.0 AS DEC(15,2)) AS VB$PC1, CAST((VB$MNC)/100.0 AS DEC(15,2)) AS VB$MNC, VB$IS, VBCRTU, CASE WHEN VBCRDJ IS NOT NULL THEN DATE(DIGITS(DEC(VBCRDJ+ 1900000,7,0))) ELSE NULL END AS VBCRDJ, CASE WHEN VBDGCG IS NOT NULL THEN DATE(DIGITS(DEC(VBDGCG+ 1900000,7,0))) ELSE NULL END AS VBDGCG, VBUPMB, VB$CRN, VBAC10, VBSIC, CAST((VBURAT)/100.0 AS DEC(15,2)) AS VBURAT, VBURCD, CASE WHEN VBURDT IS NOT NULL THEN DATE(DIGITS(DEC(VBURDT+ 1900000,7,0))) ELSE NULL END AS VBURDT, VBURAB, VBURRF, VB$RV1, VB$RV2, VB$RV3, VB$RV4, VB$RV5, VBURC1, VBURC2, CASE WHEN VBUSD1 IS NOT NULL THEN DATE(DIGITS(DEC(VBUSD1+ 1900000,7,0))) ELSE NULL END AS VBUSD1, CASE WHEN VBUSD2 IS NOT NULL THEN DATE(DIGITS(DEC(VBUSD2+ 1900000,7,0))) ELSE NULL END AS VBUSD2, CASE WHEN VBUSD3 IS NOT NULL THEN DATE(DIGITS(DEC(VBUSD3+ 1900000,7,0))) ELSE NULL END AS VBUSD3, VBUDC1, VBUDC2, VBUDC3, CAST((VB$AM1)/100.0 AS DEC(15,2)) AS VB$AM1, CAST((VB$AM2)/100.0 AS DEC(15,2)) AS VB$AM2, CAST((VB$AM3)/100.0 AS DEC(15,2)) AS VB$AM3, VBUSER, VBJOBN, VBPID, CASE WHEN VBUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(VBUPMJ+ 1900000,7,0))) ELSE NULL END AS VBUPMJ, VBTDAY

	FROM
		ARCPDTA71.F5831
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')

