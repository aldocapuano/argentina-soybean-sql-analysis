-- =====================================================
-- AÑOS RÉCORD POR PROVINCIA
-- =====================================================

-- Objetivo:
-- Identificar el año de mayor producción de cada provincia
-- durante el período común 2000-2016.


WITH produccion_provincia_anio AS (
SELECT 
provincia_nombre,
anio,
SUM(produccion_tm) AS produccion_total
FROM soja_analytics
WHERE anio BETWEEN 2000 AND 2016
GROUP BY provincia_nombre , anio
),

ranking AS (
SELECT 
provincia_nombre,
anio,
produccion_total,

ROW_NUMBER() OVER (
PARTITION BY provincia_nombre
ORDER BY produccion_total DESC
) AS posicion

FROM produccion_provincia_anio
)

SELECT provincia_nombre,
anio AS mejor_anio,
produccion_total
FROM ranking
WHERE posicion = 1
ORDER BY produccion_total DESC ;



-- Top 3 años de producción de cada provincia

WITH produccion_provincia_anio AS (
SELECT 
provincia_nombre,
anio,
SUM(produccion_tm) AS produccion_total
FROM soja_analytics
WHERE anio BETWEEN 2000 AND 2016
GROUP BY provincia_nombre , anio
),

ranking AS (
SELECT 
provincia_nombre,
anio,
produccion_total,

ROW_NUMBER() OVER (
PARTITION BY provincia_nombre
ORDER BY produccion_total DESC
) AS posicion

FROM produccion_provincia_anio
)

SELECT provincia_nombre,
anio ,
produccion_total,
posicion
FROM ranking
WHERE posicion <= 3
ORDER BY provincia_nombre, posicion ;


-- =====================================================
-- HALLAZGOS DE AÑOS RÉCORD POR PROVINCIA
-- =====================================================

-- Buenos Aires: 2015
-- Córdoba: 2014
-- Santa Fe: 2009
-- Entre Ríos: 2014
-- Santiago del Estero: 2016

-- Interpretación:
-- Los años récord no coinciden entre provincias,
-- lo que refleja comportamientos productivos regionales
-- diferentes dentro del período analizado.