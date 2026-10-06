DROP TABLE IF EXISTS soja_analytics;

CREATE TABLE soja_analytics AS

SELECT
    'primera' AS tipo_soja,
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
    anomaly_harvested_gt_planted
FROM soja_primera_clean

UNION ALL

SELECT
    'segunda' AS tipo_soja,
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
    anomaly_harvested_gt_planted
FROM soja_segunda_clean;





-- =====================================================
-- TABLA ANALYTICS
-- =====================================================

-- soja_analytics ombina conjuntos de datos de primera
-- segunda cosecha de soja mediante UNION ALL

-- tipo_soja identifica el origen de cada registro
-- 'primera' o 'segunda'.

-- Total de filas esperadas: 8211.