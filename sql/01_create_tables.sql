CREATE TABLE soja_primera_raw (
    id INTEGER,
    cultivo_nombre VARCHAR(50),
    anio INTEGER,
    campania VARCHAR(20),
    provincia_nombre VARCHAR(100),
    provincia_id INTEGER,
    departamento_nombre VARCHAR(150),
    departamento_id INTEGER,
    superficie_sembrada_ha INTEGER,
    superficie_cosechada_ha INTEGER,
    produccion_tm VARCHAR(50),
    rendimiento_kgxha VARCHAR(50)
);

CREATE TABLE soja_segunda_raw (
    cultivo_nombre VARCHAR(50),
    anio INTEGER,
    campania VARCHAR(20),
    provincia_nombre VARCHAR(100),
    provincia_id INTEGER,
    departamento_nombre VARCHAR(150),
    departamento_id INTEGER,
    superficie_sembrada_ha INTEGER,
    superficie_cosechada_ha INTEGER,
    produccion_tm INTEGER,
    rendimiento_kgxha INTEGER
);