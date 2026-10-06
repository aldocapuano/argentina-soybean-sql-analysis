-- =====================================================
-- ARGENTINA SOYBEAN PRODUCTION ANALYSIS
-- Data validation
-- =====================================================

-- Objective:
-- Inspect the raw datasets before cleaning and analysis.

--Cantidad de filas

SELECT COUNT(*) AS total_rows
FROM soja_primera_raw;

SELECT COUNT(*) AS total_rows
FROM soja_segunda_raw;

-- Rango de año

SELECT
    MIN(anio) AS first_year,
    MAX(anio) AS last_year
FROM soja_primera_raw;

SELECT
    MIN(anio) AS first_year,
    MAX(anio) AS last_year
FROM soja_segunda_raw;

-- Cantidad de provincias y departamentos


SELECT
    COUNT(DISTINCT provincia_nombre) AS total_provinces,
    COUNT(DISTINCT departamento_nombre) AS total_departments
FROM soja_primera_raw;

SELECT
    COUNT(DISTINCT provincia_nombre) AS total_provinces,
    COUNT(DISTINCT departamento_nombre) AS total_departments
FROM soja_segunda_raw;


-- id faltante de departamentos

SELECT COUNT(*) AS missing_department_ids
FROM soja_primera_raw
WHERE departamento_id IS NULL;

SELECT COUNT(*) AS missing_department_ids
FROM soja_segunda_raw
WHERE departamento_id IS NULL;


-- valores no numericas en produccion

SELECT
    produccion_tm,
    COUNT(*) AS occurrences
FROM soja_primera_raw
GROUP BY produccion_tm
HAVING produccion_tm = 'SD';

--valores no numericos de rendimiento

SELECT
    rendimiento_kgxha,
    COUNT(*) AS occurrences
FROM soja_primera_raw
GROUP BY rendimiento_kgxha
HAVING rendimiento_kgxha = 'SD';


SELECT *
FROM soja_primera_raw
WHERE produccion_tm = 'SD'
   OR rendimiento_kgxha = 'SD';


--Possibles datos duplicados

SELECT
    anio,
    provincia_nombre,
    departamento_nombre,
    COUNT(*) AS occurrences
FROM soja_primera_raw
GROUP BY
    anio,
    provincia_nombre,
    departamento_nombre
HAVING COUNT(*) > 1
ORDER BY occurrences DESC;



SELECT
    anio,
    provincia_nombre,
    departamento_nombre,
    COUNT(*) AS occurrences
FROM soja_segunda_raw
GROUP BY
    anio,
    provincia_nombre,
    departamento_nombre
HAVING COUNT(*) > 1
ORDER BY occurrences DESC;



-- . Valores negativos


SELECT *
FROM soja_segunda_raw
WHERE superficie_sembrada_ha < 0
   OR superficie_cosechada_ha < 0
   OR produccion_tm < 0
   OR rendimiento_kgxha < 0;


SELECT *
FROM soja_primera_raw
WHERE superficie_sembrada_ha < 0
   OR superficie_cosechada_ha < 0;


-- Ver si se cosecho mas de lo sembrado

SELECT *
FROM soja_primera_raw
WHERE superficie_cosechada_ha > superficie_sembrada_ha;

SELECT *
FROM soja_segunda_raw
WHERE superficie_cosechada_ha > superficie_sembrada_ha;


-- =====================================================
-- VALORES
-- =====================================================

-- SOJA PRIMERA
-- Rango de años: 2000 - 2017
-- Provincias: 15
-- Departmentos: 269
-- Faltante departamento_id: 40
-- produccion_tm = 'SD': 3
-- rendimiento_kgxha = 'SD': 3

-- SOJA SEGUNDA
-- Rango de años: 2000 - 2019
-- Provincias: 14
-- Departmentos: 230
-- Faltantes departamento_id: 9