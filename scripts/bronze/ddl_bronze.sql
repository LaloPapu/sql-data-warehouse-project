-- 1. CREACIÓN / REEMPLAZO DEL DATASET
CREATE SCHEMA IF NOT EXISTS dwh_bronze
OPTIONS(
  location = 'us'
);

-- ====================================================================
-- TABLA 1: crm_cust_info
-- ====================================================================
CREATE OR REPLACE TABLE dwh_bronze.crm_cust_info (
    cst_id              INT64,
    cst_key             STRING,
    cst_firstname       STRING,
    cst_lastname        STRING,
    cst_marital_status  STRING,
    cst_gndr            STRING,
    cst_create_date     DATE
);

-- ====================================================================
-- TABLA 2: crm_prd_info
-- ====================================================================
CREATE OR REPLACE TABLE dwh_bronze.crm_prd_info (
    prd_id       INT64,
    prd_key      STRING,
    prd_nm       STRING,
    prd_cost     INT64,
    prd_line     STRING,
    prd_start_dt DATETIME,
    prd_end_dt   DATETIME
);

-- ====================================================================
-- TABLA 3: crm_sales_details
-- ====================================================================
CREATE OR REPLACE TABLE dwh_bronze.crm_sales_details (
    sls_ord_num  STRING,
    sls_prd_key  STRING,
    sls_cust_id  INT64,
    sls_order_dt INT64,
    sls_ship_dt  INT64,
    sls_due_dt   INT64,
    sls_sales    INT64,
    sls_quantity INT64,
    sls_price    INT64
);

-- ====================================================================
-- TABLA 4: erp_loc_a101
-- ====================================================================
CREATE OR REPLACE TABLE dwh_bronze.erp_loc_a101 (
    cid    STRING,
    cntry  STRING
);

-- ====================================================================
-- TABLA 5: erp_cust_az12
-- ====================================================================
CREATE OR REPLACE TABLE dwh_bronze.erp_cust_az12 (
    cid    STRING,
    bdate  DATE,
    gen    STRING
);

-- ====================================================================
-- TABLA 6: erp_px_cat_g1v2
-- ====================================================================
CREATE OR REPLACE TABLE dwh_bronze.erp_px_cat_g1v2 (
    id           STRING,
    cat          STRING,
    subcat       STRING,
    maintenance  STRING
);
