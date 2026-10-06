-- ============================================================
-- KRAF | Consulta Analítica Q5
-- Identificación de transferencias con montos inusuales
-- ============================================================

WITH promedio_canal AS (
    SELECT
        canal,
        AVG(monto) AS monto_promedio_canal
    FROM public.transferencia
    WHERE estado = 'COMPLETADA'
      AND fecha_hora >= '2025-01-01 00:00:00'
      AND fecha_hora < '2026-01-01 00:00:00'
    GROUP BY canal
)

SELECT
    t.transferencia_id,
    c.cliente_id,
    c.nombre AS cliente,
    ef.nombre AS entidad_financiera,
    t.canal,
    t.monto,
    ROUND(pc.monto_promedio_canal, 2) AS monto_promedio_canal,

    ROUND(
        t.monto - pc.monto_promedio_canal,
        2
    ) AS diferencia_promedio,

    ROUND(
        (t.monto / pc.monto_promedio_canal) * 100,
        2
    ) AS porcentaje_sobre_promedio,

    t.fecha_hora,
    t.estado

FROM public.transferencia t

INNER JOIN public.cuenta cu
    ON t.cuenta_id = cu.cuenta_id

INNER JOIN public.cliente c
    ON cu.cliente_id = c.cliente_id

INNER JOIN public.entidad_financiera ef
    ON t.entidad_financiera_id = ef.entidad_financiera_id

INNER JOIN promedio_canal pc
    ON t.canal = pc.canal

WHERE t.estado = 'COMPLETADA'
  AND t.fecha_hora >= '2025-01-01 00:00:00'
  AND t.fecha_hora < '2026-01-01 00:00:00'
  AND t.monto > pc.monto_promedio_canal * 2

ORDER BY
    porcentaje_sobre_promedio DESC;
