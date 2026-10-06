-- =====================================================
-- RANKING DE DEPARTAMENTOS DENTRO DE CADA PROVINCIA
-- =====================================================

-- Objetivo:
-- Identificar los 3 departamentos con mayor producción
-- acumulada dentro de cada provincia durante 2000-2016.


WITH produccion_departamental AS (
SELECT provincia_nombre,
departamento_nombre,
SUM(produccion_tm) AS produccion_total
FROM soja_analytics
WHERE anio BETWEEN 2000 AND 2016 
GROUP BY provincia_nombre, departamento_nombre
),

ranking AS(
SELECT provincia_nombre,
departamento_nombre,
produccion_total,

ROW_NUMBER() OVER (
	PARTITION BY provincia_nombre
	ORDER BY produccion_total DESC
) AS posicion
FROM produccion_departamental
)

SELECT 
provincia_nombre,
departamento_nombre,
produccion_total,
posicion

FROM ranking
WHERE posicion <= 3

ORDER BY provincia_nombre, posicion;


-- Top 3 departamentos de las cinco provincias
-- con mayor producción nacional


WITH top_provincias AS (
SELECT provincia_nombre,
SUM(produccion_tm) AS produccion_total
FROM soja_analytics
WHERE anio BETWEEN 2000 AND 2016
GROUP BY provincia_nombre
ORDER BY produccion_total DESC 
LIMIT 5
),

produccion_departamental AS (
SELECT 
	s.provincia_nombre,
	s.departamento_nombre,
	SUM(s.produccion_tm) AS produccion_total
	FROM soja_analytics AS s

	INNER JOIN top_provincias AS tp
		ON s.provincia_nombre = tp.provincia_nombre

	WHERE s.anio BETWEEN 2000 AND 2016

	GROUP BY 
	s.provincia_nombre,
	s.departamento_nombre
),

ranking AS (
	SELECT provincia_nombre,
	departamento_nombre,
	produccion_total,

	ROW_NUMBER() OVER (
		PARTITION BY provincia_nombre
		ORDER BY produccion_total DESC 
	
	) AS posicion
	FROM produccion_departamental
)

SELECT *
FROM ranking
WHERE posicion <= 3
ORDER BY
    provincia_nombre,
    posicion;




-- =====================================================
-- HALLAZGOS DEL RANKING DE DEPARTAMENTOS
-- =====================================================

-- BUENOS AIRES
-- 1. Pergamino
-- 2. General Villegas
-- 3. 9 de Julio

-- CÓRDOBA
-- 1. Marcos Juárez
-- 2. Unión
-- 3. Río Cuarto

-- ENTRE RÍOS
-- 1. Paraná
-- 2. Gualeguaychú
-- 3. Victoria

-- SANTA FE
-- 1. General López
-- 2. San Martín
-- 3. Iriondo

-- SANTIAGO DEL ESTERO
-- 1. Moreno
-- 2. General Taboada
-- 3. Belgrano

-- Interpretación:
-- Los principales departamentos productores se concentran
-- principalmente dentro de las provincias que lideran
-- la producción nacional de soja.
--
-- Córdoba presenta una fuerte concentración productiva
-- en Marcos Juárez, Unión y Río Cuarto, mientras que en
-- Santa Fe se destacan General López, San Martín e Iriondo.