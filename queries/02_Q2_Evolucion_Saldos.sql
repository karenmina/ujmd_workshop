-- =========================================================
-- KRAF | Consulta Analítica Q2
-- Evolución del saldo promedio por tipo de cuenta
-- =========================================================

SELECT
    tc.nombre AS tipo_cuenta,
    DATE_TRUNC('month', sh.fecha)::date AS mes,
    COUNT(DISTINCT c.cuenta_id) AS cantidad_cuentas,
    ROUND(AVG(sh.saldo_inicial), 2) AS saldo_promedio_inicial,
    ROUND(AVG(sh.saldo_final), 2) AS saldo_promedio_final,
    ROUND(AVG(sh.saldo_final - sh.saldo_inicial), 2) AS variacion_promedio
FROM public.saldo_historico sh
INNER JOIN public.cuenta c
    ON sh.cuenta_id = c.cuenta_id
INNER JOIN public.tipo_cuenta tc
    ON c.tipo_cuenta_id = tc.tipo_cuenta_id
WHERE sh.fecha >= '2025-01-01'
  AND sh.fecha < '2026-01-01'
GROUP BY
    tc.nombre,
    DATE_TRUNC('month', sh.fecha)
HAVING COUNT(DISTINCT c.cuenta_id) >= 2
ORDER BY
    mes,
    saldo_promedio_final DESC;
