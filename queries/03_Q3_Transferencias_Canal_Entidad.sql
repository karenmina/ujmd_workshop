-- ============================================================
-- KRAF | Consulta Analítica Q3
-- Transferencias por canal y entidad financiera
-- ============================================================

SELECT
    ef.nombre AS entidad_financiera,
    t.canal,
    COUNT(t.transferencia_id) AS cantidad_transferencias,
    
    ROUND(SUM(t.monto), 2) AS monto_total,
    
    ROUND(AVG(t.monto), 2) AS monto_promedio,
    
    COUNT(*) FILTER (
        WHERE t.estado = 'COMPLETADA'
    ) AS transferencias_completadas,
    
    COUNT(*) FILTER (
        WHERE t.estado = 'PENDIENTE'
    ) AS transferencias_pendientes,
    
    COUNT(*) FILTER (
        WHERE t.estado = 'RECHAZADA'
    ) AS transferencias_rechazadas,
    
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE t.estado = 'COMPLETADA'
        ) / COUNT(t.transferencia_id),
        2
    ) AS porcentaje_completadas

FROM public.transferencia t

INNER JOIN public.entidad_financiera ef
    ON t.entidad_financiera_id = ef.entidad_financiera_id

WHERE t.fecha_hora >= '2025-01-01 00:00:00'
  AND t.fecha_hora < '2026-01-01 00:00:00'

GROUP BY
    ef.nombre,
    t.canal

HAVING COUNT(t.transferencia_id) >= 10

ORDER BY
    monto_total DESC;
