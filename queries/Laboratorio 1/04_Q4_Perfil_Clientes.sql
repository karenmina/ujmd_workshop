-- ============================================================
-- KRAF | Consulta Analítica Q4
-- Perfil de clientes según saldo y actividad transaccional
-- ============================================================

SELECT
    c.cliente_id,
    c.nombre AS cliente,

    COUNT(DISTINCT cu.cuenta_id) AS cantidad_cuentas,

    ROUND(SUM(cu.saldo_actual), 2) AS saldo_total,

    COUNT(DISTINCT t.transferencia_id) AS cantidad_transferencias,

    ROUND(
        COALESCE(SUM(t.monto), 0),
        2
    ) AS monto_total_transferido,

    ROUND(
        COALESCE(AVG(t.monto), 0),
        2
    ) AS monto_promedio_transferencia,

    MAX(t.fecha_hora) AS ultima_transferencia

FROM public.cliente c

INNER JOIN public.cuenta cu
    ON c.cliente_id = cu.cliente_id

LEFT JOIN public.transferencia t
    ON cu.cuenta_id = t.cuenta_id

GROUP BY
    c.cliente_id,
    c.nombre

HAVING
    SUM(cu.saldo_actual) > 5000

ORDER BY
    saldo_total DESC,
    cantidad_transferencias DESC;
