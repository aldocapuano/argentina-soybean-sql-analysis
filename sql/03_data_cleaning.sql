DROP TABLE IF EXISTS soja_primera_clean;

CREATE TABLE soja_primera_clean AS
SELECT
    id,
    cultivo_nombre,
    anio,
    campania,
    provincia_nombre,
    provincia_id,
    departamento_nombre,
    departamento_id,
    superficie_sembrada_ha,
    superficie_cosechada_ha,

    CASE
        WHEN produccion_tm = 'SD' THEN NULL
        ELSE produccion_tm::INTEGER
    END AS produccion_tm,

    CASE
        WHEN rendimiento_kgxha = 'SD' THEN NULL
        ELSE rendimiento_kgxha::INTEGER
    END AS rendimiento_kgxha,

    CASE
        WHEN superficie_cosechada_ha > superficie_sembrada_ha
        THEN TRUE
        ELSE FALSE
    END AS anomaly_harvested_gt_planted

FROM soja_primera_raw;



DROP TABLE IF EXISTS soja_segunda_clean;



CREATE TABLE soja_segunda_clean AS
SELECT
    cultivo_nombre,
    anio,
    campania,
    provincia_nombre,
    provincia_id,
    departamento_nombre,
    departamento_id,
    superficie_sembrada_ha,
    superficie_cosechada_ha,
    produccion_tm,
    rendimiento_kgxha,

    CASE
        WHEN superficie_cosechada_ha > superficie_sembrada_ha
        THEN TRUE
        ELSE FALSE
    END AS anomaly_harvested_gt_planted

FROM soja_segunda_raw;


-- Verificar tablas limpias
SELECT COUNT(*)
FROM soja_primera_clean;

SELECT COUNT(*)
FROM soja_segunda_clean;


-- Ver los NULL restantes
SELECT
    COUNT(*) AS missing_production
FROM soja_primera_clean
WHERE produccion_tm IS NULL;

SELECT
	COUNT(*) AS missing_yield
FROM soja_primera_clean
WHERE rendimiento_kgxha IS NULL;


--Comprobar anomalias
SELECT
	COUNT(*) AS anomalias
FROM soja_primera_clean 
WHERE anomaly_harvested_gt_planted = 'TRUE';

SELECT COUNT(*) AS anomalias
FROM soja_segunda_clean
WHERE anomaly_harvested_gt_planted = TRUE;



-- =====================================================
-- Limpieza
-- =====================================================

-- Los valores 'SD' en produccion_tm y rendimiento_kgxha
-- fueron convertidos a NULL.

-- Los registros en los que la cosecha era mayor que la siembra
-- se conservaron y se marcaron como anomalias

-- Las tablas sin procesar permanecen sin cambios