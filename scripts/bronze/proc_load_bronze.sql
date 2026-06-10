CREATE OR REPLACE PROCEDURE `analytics-for-beginner.dwh_bronze.load_bronze`()
BEGIN
  -- Declaración de variables para medir el tiempo
  DECLARE start_time DATETIME;
  DECLARE end_time DATETIME;
  DECLARE batch_start_time DATETIME;
  DECLARE batch_end_time DATETIME;

  DECLARE v_log_report STRING DEFAULT '';

  -- Manejo de errores nativo de BigQuery (Equivalente al TRY...CATCH)
  BEGIN
    SET batch_start_time = CURRENT_DATETIME();
    
    -- TABLA 1: crm_cust_info
    SET start_time = CURRENT_DATETIME();
    
    LOAD DATA OVERWRITE dwh_bronze.crm_cust_info
    FROM FILES (
      format = 'CSV',
      uris = ['gs://dwh_project_1/source_crm/cust_info.csv'],
      skip_leading_rows = 1,
      field_delimiter = ','
    );
    
    SET end_time = CURRENT_DATETIME();
    SET v_log_report = CONCAT(
      v_log_report,'>> crm_cust_info Load Duration: ', CAST(DATETIME_DIFF(end_time, start_time, SECOND) AS STRING), ' seconds\n');

    -- TABLA 2: crm_prd_info
    SET start_time = CURRENT_DATETIME();
    
    LOAD DATA OVERWRITE dwh_bronze.crm_prd_info
    FROM FILES (
      format = 'CSV',
      uris = ['gs://dwh_project_1/source_crm/prd_info.csv'],
      skip_leading_rows = 1,
      field_delimiter = ','
    );
    
    SET end_time = CURRENT_DATETIME();
    SET v_log_report = CONCAT(
      v_log_report,'>> crm_prd_info Load Duration: ', CAST(DATETIME_DIFF(end_time, start_time, SECOND) AS STRING), ' seconds\n');

    -- TABLA 3: crm_sales_details
    SET start_time = CURRENT_DATETIME();
    
    LOAD DATA OVERWRITE dwh_bronze.crm_sales_details
    FROM FILES (
      format = 'CSV',
      uris = ['gs://dwh_project_1/source_crm/sales_details.csv'],
      skip_leading_rows = 1,
      field_delimiter = ','
    );
    
    SET end_time = CURRENT_DATETIME();
    SET v_log_report = CONCAT(
      v_log_report,'>> crm_sales_details Load Duration: ', CAST(DATETIME_DIFF(end_time, start_time, SECOND) AS STRING), ' seconds\n');

    -- TABLA 4: erp_loc_a101
    SET start_time = CURRENT_DATETIME();
    
    LOAD DATA OVERWRITE dwh_bronze.erp_loc_a101
    FROM FILES (
      format = 'CSV',
      uris = ['gs://dwh_project_1/source_erp/LOC_A101.csv'],
      skip_leading_rows = 1,
      field_delimiter = ','
    );
    
    SET end_time = CURRENT_DATETIME();
    SET v_log_report = CONCAT(
      v_log_report,'>> erp_loc_a101 Load Duration: ', CAST(DATETIME_DIFF(end_time, start_time, SECOND) AS STRING), ' seconds\n');

    -- TABLA 5: erp_cust_az12
    SET start_time = CURRENT_DATETIME();
    
    LOAD DATA OVERWRITE dwh_bronze.erp_cust_az12
    FROM FILES (
      format = 'CSV',
      uris = ['gs://dwh_project_1/source_erp/CUST_AZ12.csv'],
      skip_leading_rows = 1,
      field_delimiter = ','
    );
    
    SET end_time = CURRENT_DATETIME();
    SET v_log_report = CONCAT(
      v_log_report,'>> erp_cust_az12 Load Duration: ', CAST(DATETIME_DIFF(end_time, start_time, SECOND) AS STRING), ' seconds\n');

    -- TABLA 6: erp_px_cat_g1v2
    SET start_time = CURRENT_DATETIME();
    
    LOAD DATA OVERWRITE dwh_bronze.erp_px_cat_g1v2
    FROM FILES (
      format = 'CSV',
      uris = ['gs://dwh_project_1/source_erp/PX_CAT_G1V2.csv'],
      skip_leading_rows = 1,
      field_delimiter = ','
    );
    
    SET end_time = CURRENT_DATETIME();
    SET v_log_report = CONCAT(
      v_log_report,'>> erp_px_cat_g1v2 Load Duration: ', CAST(DATETIME_DIFF(end_time, start_time, SECOND) AS STRING), ' seconds\n');

    -- Fin del Batch
    SET batch_end_time = CURRENT_DATETIME();
    SET v_log_report = CONCAT(
      v_log_report,'- Total Load Duration: ', CAST(DATETIME_DIFF(batch_end_time, batch_start_time, SECOND) AS STRING), ' seconds\n');

  SELECT v_log_report AS execution_summary;

  EXCEPTION WHEN ERROR THEN
    -- Bloque que captura fallos en cualquier parte del proceso
    SET v_log_report = CONCAT(v_log_report,'Error Message: ', @@error.message, '\n');
    SET v_log_report = CONCAT(v_log_report,'Error Statement: ', @@error.statement_text);

    SELECT v_log_report AS execution_summary_error;
  END;
END;