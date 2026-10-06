-- =========================================================
-- KRAF | Q1 - Concentración de transferencias por cliente
-- Identificar los clientes que concentran los mayores
-- montos de transferencias hacia otras entidades financieras.
-- =========================================================

SELECT
    clasificacion,
    COUNT(*) AS cantidad_transferencias,
    ROUND(AVG(monto), 2) AS monto_promedio,
    ROUND(MAX(monto), 2) AS monto_maximo
FROM workspace.kraf_gold.transferencias_riesgo
GROUP BY clasificacion
ORDER BY clasificacion;