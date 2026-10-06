-- =====================================================
-- ANÁLISIS EXPLORATORIO
-- =====================================================



--. Cantidad total de registros

SELECT COUNT(*) AS total_registros
FROM soja_analytics;


--. Cantidad de registros por tipo de soja

SELECT
    tipo_soja,
    COUNT(*) AS total_registros
FROM soja_analytics
GROUP BY tipo_soja
ORDER BY tipo_soja;


--. Producción total por tipo de soja

SELECT
    tipo_soja,
    SUM(produccion_tm) AS produccion_total_tm
FROM soja_analytics
GROUP BY tipo_soja
ORDER BY produccion_total_tm DESC;


--. Superficie sembrada total por tipo de soja

SELECT
    tipo_soja,
    SUM(superficie_sembrada_ha) AS superficie_sembrada_total_ha
FROM soja_analytics
GROUP BY tipo_soja
ORDER BY superficie_sembrada_total_ha DESC;


--. Superficie cosechada total por tipo de soja

SELECT
    tipo_soja,
    SUM(superficie_cosechada_ha) AS superficie_cosechada_total_ha
FROM soja_analytics
GROUP BY tipo_soja
ORDER BY superficie_cosechada_total_ha DESC;


--. Rendimiento promedio por tipo de soja

SELECT
    tipo_soja,
    ROUND(AVG(rendimiento_kgxha), 2) AS rendimiento_promedio_kgxha
FROM soja_analytics
GROUP BY tipo_soja
ORDER BY rendimiento_promedio_kgxha DESC;



-- =====================================================
-- DATOS
-- =====================================================

-- Producción acumulada:
-- Soja de primera: 628.598.872 toneladas
-- Soja de segunda: 151.067.417 toneladas

-- Superficie sembrada acumulada:
-- Soja de primera: 227.915.803 hectáreas
-- Soja de segunda: 70.600.648 hectáreas

-- Superficie cosechada acumulada:
-- Soja de primera: 221.932.837 hectáreas
-- Soja de segunda: 68.062.157 hectáreas

-- Rendimiento promedio simple:
-- Soja de primera: 2.480,97 kg/ha
-- Soja de segunda: 2.007,32 kg/ha




--. Evolución de la producción total por año

SELECT
    anio,
    SUM(produccion_tm) AS produccion_total_tm
FROM soja_analytics
GROUP BY anio
ORDER BY anio;



--. Producción anual por tipo de soja

SELECT
    anio,
    tipo_soja,
    SUM(produccion_tm) AS produccion_total_tm
FROM soja_analytics
GROUP BY
    anio,
    tipo_soja
ORDER BY
    anio,
    tipo_soja;



-- Evolucion de la superficie sembrada 

SELECT 	
anio,
SUM(superficie_sembrada_ha) AS superficie_sembrada
FROM soja_analytics 
GROUP BY anio
ORDER BY anio;


-- Comparacion entre tipos de soja utilizando 
-- el periodo de timepo que tienen en comun 
-- 2000 - 2016

SELECT 
tipo_soja,
SUM(produccion_tm) AS prodcuccion_total,
SUM(superficie_sembrada_ha) AS superficie_sembrada ,
SUM(superficie_cosechada_ha) AS superficie_cosechada,
ROUND(AVG(rendimiento_kgxha),2 ) AS rendimiento_promedio
FROM soja_analytics 
WHERE anio BETWEEN 2000 AND 2016
GROUP BY tipo_soja
ORDER BY tipo_soja;



-- Rendimiento por superficie cosechada 
-- Para el periodo en comun: 2000 - 2017


SELECT
tipo_soja,
ROUND(SUM(produccion_tm)::NUMERIC * 1000
/ NULLIF(SUM(superficie_cosechada_ha), 0),2) 
AS rendimiento_ponerado
FROM soja_analytics 
WHERE anio BETWEEN 2000 AND 2016
GROUP BY tipo_soja
ORDER BY tipo_soja; 





-- =====================================================
-- HALLAZGOS DEL PERÍODO COMÚN 2000-2016
-- =====================================================

-- SOJA DE PRIMERA
-- Producción total: 628.598.872 toneladas
-- Superficie sembrada: 227.915.803 hectáreas
-- Superficie cosechada: 221.932.837 hectáreas
-- Rendimiento promedio simple: 2.480,97 kg/ha
-- Rendimiento ponderado: 2.832,38 kg/ha

-- SOJA DE SEGUNDA
-- Producción total: 118.895349 toneladas
-- Superficie sembrada: 55.910.824 hectáreas
-- Superficie cosechada: 54.051.368 hectáreas
-- Rendimiento promedio simple: 1.997,70 kg/ha
-- Rendimiento ponderado: 2.199,67 kg/ha

-- INTERPRETACIÓN:
-- Durante el período común analizado, la soja de primera
-- presentó una producción acumulada y un rendimiento
-- superiores a los de la soja de segunda.
--
-- El rendimiento ponderado es mayor que el promedio simple
-- en ambos tipos de soja, lo que sugiere que las zonas con
-- mayor superficie cosechada presentan, en promedio,
-- mejores niveles de rendimiento.