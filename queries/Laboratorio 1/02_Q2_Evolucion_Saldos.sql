-- =========================================================
-- KRAF | Consulta Analítica Q2
-- Evolución del saldo promedio por tipo de cuenta
-- =========================================================

SELECT
    country_name,
    ROUND(AVG(inflation_rate), 2) AS inflacion_promedio,
    MIN(year) AS anio_inicial,
    MAX(year) AS anio_final
FROM workspace.kraf_gold.contexto_economico_pais
WHERE inflation_rate IS NOT NULL
GROUP BY country_name
ORDER BY inflacion_promedio DESC;
