-- =====================================================
-- ANÁLISIS TEMPORAL
-- =====================================================

-- Objetivo:
-- Analizar cómo evolucionaron la producción,
-- la superficie y el rendimiento a lo largo del tiempo.


-- Producción total por año

SELECT
anio,
SUM(produccion_tm) AS produccion_total_tm
FROM soja_analytics
WHERE anio BETWEEN 2000 AND 2016
GROUP BY anio
ORDER BY anio;


-- Superficie sembrada por año

SELECT
anio,
SUM(superficie_sembrada_ha) AS superficie_sembrada_total_ha
FROM soja_analytics
WHERE anio BETWEEN 2000 AND 2016
GROUP BY anio
ORDER BY anio;


-- Superficie cosechada por año

SELECT
anio,
 SUM(superficie_cosechada_ha) AS superficie_cosechada_total_ha
FROM soja_analytics
WHERE anio BETWEEN 2000 AND 2016
GROUP BY anio
ORDER BY anio;


-- Rendimiento ponderado por año

SELECT
anio,
ROUND(
     SUM(produccion_tm)::NUMERIC * 1000
     / NULLIF(SUM(superficie_cosechada_ha), 0),
     2
    ) AS rendimiento_ponderado_kgxha
FROM soja_analytics
WHERE anio BETWEEN 2000 AND 2016
GROUP BY anio
ORDER BY anio;


-- Variacion interanual de la produccion 

WITH produccion_anual AS (
SELECT
anio,
SUM(produccion_tm) AS produccion_total
 FROM soja_analytics
  WHERE anio BETWEEN 2000 AND 2016
   GROUP BY anio
)

SELECT 
anio,
produccion_total ,
LAG(produccion_total) OVER(ORDER BY anio) AS produccion_anio_anterior,
ROUND(
(
produccion_total - LAG(produccion_total) OVER (ORDER BY anio)
):: NUMERIC * 100 /
NULLIF (
LAG(produccion_total) OVER (ORDER BY anio), 0
),2
) AS variacion_interanual_porcentaje

FROM produccion_anual
ORDER BY anio;


-- Año con mayor produccion

SELECT 
anio,
SUM(produccion_tm) AS produccion_total
FROM soja_analytics
WHERE anio BETWEEN 2000 AND 2016
GROUP BY anio
ORDER BY produccion_total DESC
LIMIT 1;


-- Año con mayor rendimiento 

SELECT anio,
ROUND(
SUM(produccion_tm)::NUMERIC * 1000 /
NULLIF(SUM(Superficie_cosechada_ha),0),2
) AS rendimiento
FROM soja_analytics
WHERE anio BETWEEN 2000 AND 2016
GROUP BY anio
ORDER BY rendimiento
LIMIT 1;


-- =====================================================
-- HALLAZGOS DEL ANÁLISIS TEMPORAL
-- =====================================================

-- Año con mayor producción total:
-- 2014: 61.398.277 toneladas

-- Año con mayor rendimiento ponderado:
-- 2008: 1.897,70 kg/ha

-- Mayor crecimiento interanual de la producción:
-- 2009: +67,89 %

-- Mayor caída interanual de la producción:
-- 2008: -31,28 %

-- Interpretación:
-- La serie presenta variaciones importantes entre campañas.
-- La fuerte caída de 2008 fue seguida por una recuperación
-- significativa en 2009.
--
-- El año 2014 registró la mayor producción total del período
-- común analizado.