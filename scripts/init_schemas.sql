-- ====================================================================
-- 1. CREACIÓN DEL ESQUEMA / DATASET: BRONZE
-- ====================================================================

CREATE SCHEMA IF NOT EXISTS dwh_bronze
OPTIONS(
  location = 'us',
  description = 'Capa Bronze: Datos crudos importados directamente de las fuentes'
);

-- ====================================================================
-- 2. CREACIÓN DEL ESQUEMA / DATASET: SILVER
-- ====================================================================
CREATE SCHEMA IF NOT EXISTS dwh_silver
OPTIONS(
  location = 'us',
  description = 'Capa Silver: Datos limpios, transformados y estandarizados'
);

-- ====================================================================
-- 3. CREACIÓN DEL ESQUEMA / DATASET: GOLD
-- ====================================================================
CREATE SCHEMA IF NOT EXISTS dwh_gold
OPTIONS(
  location = 'us',
  description = 'Capa Gold: Modelos de negocio, agregaciones y tablas listas para analítica'
);
