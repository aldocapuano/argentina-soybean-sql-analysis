-- =====================================================
-- ANÁLISIS DEPARTAMENTAL
-- =====================================================

-- Objetivo:
-- Identificar los departamentos con mayor producción
-- y rendimiento de soja durante el período 2000-2017.


-- Top 15 departamentos por producción

SELECT
    provincia_nombre,
    departamento_nombre,
    SUM(produccion_tm) AS produccion_total_tm
FROM soja_analytics
WHERE anio BETWEEN 2000 AND 2016
GROUP BY
    provincia_nombre,
    departamento_nombre
ORDER BY produccion_total_tm DESC
LIMIT 15;

-- Top 15 departamentos por rendimiento

SELECT 
provincia_nombre,
departamento_nombre,
ROUND(
SUM(produccion_tm)::NUMERIC * 1000/
NULLIF(SUM(superficie_cosechada_ha),0),2
) AS rendimiento
FROM soja_analytics
WHERE anio BETWEEN 2000 AND 2016
GROUP BY provincia_nombre, departamento_nombre
ORDER BY rendimiento DESC NULLS LAST
LIMIT 15;


-- Top 15 departamentos por rendimiento 
-- cosiderando solo departamentos con al menos 
-- 100.000 hectareas cosechadas acumuladas

SELECT 
provincia_nombre,
departamento_nombre,
SUM(superficie_cosechada_ha) AS superficie_cosechada_total,
ROUND(
SUM(produccion_tm)::NUMERIC * 1000 /
NULLIF(SUM(superficie_cosechada_ha),0),2
) AS rendimiento
FROM soja_analytics
WHERE anio BETWEEN 2000 AND 2016
GROUP BY provincia_nombre, departamento_nombre 
HAVING SUM(superficie_cosechada_ha)>= 100000
ORDER BY rendimiento DESC
LIMIT 15;


--Participacion de los 10 departamentos
-- con mayor produccion sobre el total nacional


SELECT
SUM(produccion_tm)
FROM soja_analytics
WHERE anio BETWEEN 2000 AND 2016
) , 2
) AS participacion_top10

FROM(
SELECT 
provincia_nombre,
departamento_nombre,
SUM(produccion_tm) AS produccion_total
FROM soja_analytics
WHERE anio BETWEEN 2000 AND 2016
GROUP BY provincia_nombre, departamento_nombre
ORDER BY produccion_total DESC 
LIMIT 10
) AS top10;


-- =====================================================
-- HALLAZGOS DEL ANÁLISIS DEPARTAMENTAL
-- =====================================================

-- Departamentos con mayor producción acumulada:
-- 1. General López - Santa Fe
-- 2. Marcos Juárez - Córdoba
-- 3. Unión - Córdoba
-- 4. Río Cuarto - Córdoba
-- 5. San Justo - Córdoba

-- Departamentos con mayor rendimiento ponderado
-- considerando al menos 100.000 hectáreas cosechadas:
-- 1. Colón - Buenos Aires
-- 2. General Arenales - Buenos Aires
-- 3. Pergamino
-- 4. Rojasenos Aires
-- 5. Salto - Buenos Aires

-- Los 10 departamentos con mayor producción concentran
-- el 27,74 de la producción total analizada.

-- Interpretación:
-- La producción está mucho más concentrada a nivel provincial
-- que a nivel departamental.
--
-- Mientras que las 5 principales provincias concentran
-- más del 90 % de la producción, los 10 principales
-- departamentos representan solo el 27,74%