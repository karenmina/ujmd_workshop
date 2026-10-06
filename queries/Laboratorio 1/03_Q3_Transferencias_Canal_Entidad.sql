-- ============================================================
-- KRAF | Consulta Analítica Q3
-- Transferencias por canal y entidad financiera
-- ============================================================

SELECT
    department,
    area,
    total_personas,
    ROUND(edad_promedio, 2) AS edad_promedio,
    edad_minima,
    edad_maxima
FROM workspace.kraf_gold.contexto_sociodemografico_sv
ORDER BY total_personas DESC;
