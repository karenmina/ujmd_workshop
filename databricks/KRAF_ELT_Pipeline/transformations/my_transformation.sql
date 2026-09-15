-- ============================================
-- KRAF - Pipeline ELT con Lakeflow
-- Supabase → Bronze → Silver → Gold
-- ============================================

-- BRONZE
-- Conservamos los datos provenientes de Supabase
CREATE OR REFRESH MATERIALIZED VIEW kraf_pipeline_bronze
AS
SELECT
    transferencia_id,
    cuenta_id,
    entidad_financiera_id,
    tipo_transferencia_id,
    monto,
    fecha_hora,
    cuenta_destino,
    referencia,
    canal,
    estado,
    current_timestamp() AS _ingested_at,
    'Supabase' AS _source
FROM KRAF_SUPABASE_catalog.public.transferencia;


-- SILVER
-- Validación y limpieza de los registros
CREATE OR REFRESH MATERIALIZED VIEW kraf_pipeline_silver
AS
SELECT
    transferencia_id,
    cuenta_id,
    entidad_financiera_id,
    tipo_transferencia_id,
    monto,
    fecha_hora,
    cuenta_destino,
    referencia,
    canal,
    estado,
    _ingested_at,
    _source
FROM kraf_pipeline_bronze
WHERE monto > 0
  AND transferencia_id IS NOT NULL
  AND cuenta_id IS NOT NULL
  AND fecha_hora IS NOT NULL;


-- GOLD
-- Identificación de transferencias atípicas
-- utilizando el promedio por canal
CREATE OR REFRESH MATERIALIZED VIEW kraf_pipeline_gold
AS
SELECT
    transferencia_id,
    cuenta_id,
    monto,
    fecha_hora,
    canal,
    estado,
    promedio_canal,
    CASE
        WHEN monto > promedio_canal * 2
        THEN 'ATIPICA'
        ELSE 'NORMAL'
    END AS clasificacion
FROM (
    SELECT
        transferencia_id,
        cuenta_id,
        monto,
        fecha_hora,
        canal,
        estado,
        AVG(monto) OVER (PARTITION BY canal) AS promedio_canal
    FROM kraf_pipeline_silver
);