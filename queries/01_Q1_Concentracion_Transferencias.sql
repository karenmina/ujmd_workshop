-- =========================================================
-- KRAF | Q1 - Concentración de transferencias por cliente
-- Identificar los clientes que concentran los mayores
-- montos de transferencias hacia otras entidades financieras.
-- =========================================================

SELECT
    c.cliente_id,
    c.nombre AS cliente,
    ef.nombre AS entidad_destino,
    COUNT(t.transferencia_id) AS cantidad_transferencias,
    SUM(t.monto) AS monto_total_transferido,
    ROUND(AVG(t.monto), 2) AS monto_promedio,
    MIN(t.fecha_hora) AS primera_transferencia,
    MAX(t.fecha_hora) AS ultima_transferencia

FROM public.cliente c

INNER JOIN public.cuenta cu
    ON c.cliente_id = cu.cliente_id

INNER JOIN public.transferencia t
    ON cu.cuenta_id = t.cuenta_id

INNER JOIN public.entidad_financiera ef
    ON t.entidad_financiera_id = ef.entidad_financiera_id

WHERE t.fecha_hora BETWEEN '2025-01-01 00:00:00'
                       AND '2025-12-31 23:59:59'
  AND t.estado = 'COMPLETADA'

GROUP BY
    c.cliente_id,
    c.nombre,
    ef.nombre

HAVING SUM(t.monto) > 1000

ORDER BY
    monto_total_transferido DESC;
