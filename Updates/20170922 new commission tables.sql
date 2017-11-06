

---
--------------------------------------------------------------------------------
-- DROP TABLE Integration.F55510_customer_territory_Staging
--------------------------------------------------------------------------------

SELECT 

--    Top 5 
    "WRCO" AS WRCO___company,
	"WR$GTC" AS WR$GTC_group_type_category,
	"WR$GTY" AS WR$GTY_group_type,
	"WR$VNO" AS WR$VNO_number_version,
	"WR$SLO" AS WR$SLO_sales_organization,
	"WRAC10" AS WRAC10_division_code,
	"WR$TER" AS WR$TER_territory_code,
	"WR$L01" AS WR$L01_level_code_01,
	"WR$L02" AS WR$L02_level_code_02,
	"WR$L03" AS WR$L03_level_code_03,
	"WR$L04" AS WR$L04_level_code_04,
	"WR$L05" AS WR$L05_level_code_05,
	"WR$L06" AS WR$L06_level_code_06,
	"WR$L07" AS WR$L07_level_code_07,
	"WR$L08" AS WR$L08_level_code_08,
	"WR$L09" AS WR$L09_level_code_09,
	"WR$L10" AS WR$L10_level_code_10,
	"WR$K01" AS WR$K01_level_id01,
	"WR$K02" AS WR$K02_level_id02,
	"WR$K03" AS WR$K03_level_id03,
	"WR$K04" AS WR$K04_level_id04,
	"WR$K05" AS WR$K05_level_id05,
	"WR$K06" AS WR$K06_level_id06,
	"WR$K07" AS WR$K07_level_id07,
	"WR$K08" AS WR$K08_level_id08,
	"WR$K09" AS WR$K09_level_id09,
	"WR$K10" AS WR$K10_level_id10,
	"WRTKBY" AS WRTKBY_order_taken_by,
	"WR$CGN" AS WR$CGN_customer_group,
	"WR$CLS" AS WR$CLS_classification_code,
	"WRAN8" AS WRAN8__billto,
	"WRSHAN" AS WRSHAN_shipto,
	"WRNAME" AS WRNAME_name,
	"WREFFF" AS WREFFF_effective_from_date,
	"WREFFT" AS WREFFT_effective_thru_date,
	"WRUSER" AS WRUSER_user_id,
	"WRPID" AS WRPID__program_id,
	"WRJOBN" AS WRJOBN_work_station_id,
	"WRUPMJ" AS WRUPMJ_date_updated,
	"WRUPMT" AS WRUPMT_time_last_updated 

-- INTO Integration.F55510_customer_territory_Staging

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		WRCO,
		WR$GTC,
		WR$GTY,
		WR$VNO,
		WR$SLO,
		WRAC10,
		WR$TER,
		WR$L01,
		WR$L02,
		WR$L03,
		WR$L04,
		WR$L05,
		WR$L06,
		WR$L07,
		WR$L08,
		WR$L09,
		WR$L10,
		WR$K01,
		WR$K02,
		WR$K03,
		WR$K04,
		WR$K05,
		WR$K06,
		WR$K07,
		WR$K08,
		WR$K09,
		WR$K10,
		WRTKBY,
		WR$CGN,
		WR$CLS,
		WRAN8,
		WRSHAN,
		WRNAME,
		CASE WHEN WREFFF IS NOT NULL THEN DATE(DIGITS(DEC(WREFFF+ 1900000,7,0))) ELSE NULL END AS WREFFF,
		CASE WHEN WREFFT IS NOT NULL THEN DATE(DIGITS(DEC(WREFFT+ 1900000,7,0))) ELSE NULL END AS WREFFT,
		WRUSER,
		WRPID,
		WRJOBN,
		CASE WHEN WRUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(WRUPMJ+ 1900000,7,0))) ELSE NULL END AS WRUPMJ,
		WRUPMT

	FROM
		ARCPDTA71.F55510
	WHERE
		WREFFF <= CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT DATE)),3,2)),SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE))),8,3)) AND 		
		WREFFT >= CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT DATE)),3,2)),SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE))),8,3))  		

--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')

ALTER TABLE Integration.F55510_customer_territory_Staging ADD CONSTRAINT
	idx_F55510_customer_territory_Staging_c_pk PRIMARY KEY CLUSTERED 
	(
	WRSHAN_shipto,
	WR$TER_territory_code
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA

GO


---
SELECT        WR$TER_territory_code, WRSHAN_shipto, COUNT(*) AS Expr1
FROM            Integration.F55510_customer_territory_Staging
GROUP BY WR$TER_territory_code, WRSHAN_shipto
HAVING        (COUNT(*) > 1)

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


