-- =====================================================
-- ANÁLISIS PROVINCIAL
-- =====================================================

-- Objetivo:
-- Identificar las provincias con mayor producción,
-- superficie y rendimiento de soja durante el período
-- común 2000-2016.


-- 1. Producción total por provincia

SELECT 
provincia_nombre,
SUM(produccion_tm) AS produccion_total
FROM soja_analytics
WHERE anio BETWEEN 2000 AND 2016
GROUP BY provincia_nombre
ORDER BY produccion_total DESC;


-- Top 10 provincias por produccion

SELECT 
provincia_nombre,
tipo_soja,
SUM(produccion_tm) AS produccion_total
FROM soja_analytics
WHERE anio BETWEEN 2000 AND 2016
GROUP BY tipo_soja, provincia_nombre
ORDER BY provincia_nombre, produccion_total DESC;

-- Produccion provincial por tipo de soja

SELECT 
provincia_nombre,
tipo_soja,
SUM(produccion_tm) AS produccion_total
FROM soja_analytics
WHERE anio BETWEEN 2000 AND 2016
GROUP BY tipo_soja, provincia_nombre
ORDER BY provincia_nombre, produccion_total DESC;


-- Rendimiento ponerado por provincia

SELECT 
provincia_nombre,
ROUND(
SUM(produccion_tm)::NUMERIC * 1000
/NULLIF(SUM(superficie_cosechada_ha),0),2
) AS rendimiento_ponerado
FROM soja_analytics
WHERE anio BETWEEN 2000 AND 2016
GROUP BY provincia_nombre
ORDER BY rendimiento_ponerado;


-- Superficie sembrada acumulada por provincia

SELECT 
provincia_nombre,
SUM(superficie_sembrada_ha) AS superficie_sembrada
FROM soja_analytics
WHERE anio BETWEEN 2000 AND 2016
GROUP BY provincia_nombre
ORDER BY superficie_sembrada DESC;


-- Participacion de cada provincia en la produccion total

SELECT provincia_nombre,
SUM(produccion_tm) AS produccion_total,
ROUND(
SUM(produccion_tm)::NUMERIC * 100 / 
(
SELECT SUM(produccion_tm)
FROM soja_analytics
WHERE anio BETWEEN 2000 AND 2016
) , 2
) AS participacion_porcentaje

FROM soja_analytics
WHERE anio BETWEEN 2000 AND 2016
GROUP BY provincia_nombre
ORDER BY produccion_total DESC;


-- Participacion conjunta de las 5 provincias
-- con mayor produccion

SELECT 
ROUND(
SUM(produccion_total)::NUMERIC * 100 /
(
SELECT
SUM(produccion_tm)
FROM soja_analytics
WHERE anio BETWEEN 2000 AND 2016
) , 2
) AS participacion_top5_porcentaje

FROM (
SELECT 
provincia_nombre,
SUM(produccion_tm) AS produccion_total
FROM soja_analytics
WHERE anio BETWEEN 2000 AND 2016
GROUP BY provincia_nombre
ORDER BY produccion_total DESC
LIMIT 5
) AS top5;


-- Porcentaje de superficie sembrada que fue 
-- cosechada por provincia


SELECT
provincia_nombre,
SUM(superficie_sembrada_ha) AS superficie_sembrada,
SUM(superficie_cosechada_ha) AS superficie_cosechada,

ROUND(
SUM(superficie_cosechada_ha)::NUMERIC * 100 / 
NULLIF(SUM(superficie_sembrada_ha),0),2
) AS porcentaje_superficie_cosechada

FROM soja_analytics
WHERE anio BETWEEN 2000 AND 2016
GROUP BY provincia_nombre
ORDER BY porcentaje_superficie_cosechada DESC;



-- =====================================================
-- HALLAZGOS DEL ANÁLISIS PROVINCIAL
-- =====================================================

--Top 5 provincias por produccion:
-- Buenos Aires 
-- Cordoba
-- Santa Fe
-- Entre Rios
-- Santiago del Estero

-- Participación en la producción total:
-- Buenos Aires: 29,21
-- Córdoba: 28,34
-- Santa Fe: 22,55%
-- Entre Ríos: 6,93%
-- Santiago del Estero: 3,94%

-- Las 5 provincias con mayor producción concentran
-- el 90,93 % de la producción total analizada.

-- Mayor proporción de superficie cosechada respecto
-- de la superficie sembrada:
-- Catamarca: 99.97

-- Menor proporción:
-- Misiones: 82,25 %

-- Interpretación:
-- La producción de soja está fuertemente concentrada
-- en pocas provincias  especialmente Buenos Aires,
-- Córdoba y Santa Fe.