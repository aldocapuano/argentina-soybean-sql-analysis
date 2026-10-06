UPDATE soja_primera_clean
SET provincia_nombre = CASE
    WHEN provincia_nombre IN ('CÃ³rdoba', 'Córdoba') THEN 'Córdoba'
    WHEN provincia_nombre IN ('TucumÃ¡n', 'Tucumán') THEN 'Tucumán'
    WHEN provincia_nombre IN ('Entre RÃ­os', 'Entre Ríos') THEN 'Entre Ríos'
    ELSE provincia_nombre
END;

UPDATE soja_segunda_clean
SET provincia_nombre = CASE
    WHEN provincia_nombre IN ('CÃ³rdoba', 'Córdoba') THEN 'Córdoba'
    WHEN provincia_nombre IN ('TucumÃ¡n', 'Tucumán') THEN 'Tucumán'
    WHEN provincia_nombre IN ('Entre RÃ­os', 'Entre Ríos') THEN 'Entre Ríos'
    ELSE provincia_nombre
END;


-- =====================================================
-- NORMALIZACIÓN GEOGRÁFICA
-- =====================================================

-- Se detectaron nombres de provincias duplicados debido
-- a problemas de codificación de caracteres.

-- Ejemplos:
-- 'CÃ³rdoba'  -> 'Córdoba'
-- 'TucumÃ¡n'  -> 'Tucumán'
-- 'Entre RÃ­os' -> 'Entre Ríos'





UPDATE soja_primera_clean
SET departamento_nombre = REPLACE(
    REPLACE(
        REPLACE(
            REPLACE(
                REPLACE(
                    REPLACE(
                        REPLACE(
                            REPLACE(
                                REPLACE(
                                    REPLACE(
                                        departamento_nombre,
                                        'Ã¡', 'á'
                                    ),
                                    'Ã©', 'é'
                                ),
                                'Ã­', 'í'
                            ),
                            'Ã³', 'ó'
                        ),
                        'Ãº', 'ú'
                    ),
                    'Ã±', 'ñ'
                ),
                'Ã', 'Á'
            ),
            'Ã‰', 'É'
        ),
        'Ã“', 'Ó'
    ),
    'Ãš', 'Ú'
);


UPDATE soja_segunda_clean
SET departamento_nombre = REPLACE(
    REPLACE(
        REPLACE(
            REPLACE(
                REPLACE(
                    REPLACE(
                        REPLACE(
                            REPLACE(
                                REPLACE(
                                    REPLACE(
                                        departamento_nombre,
                                        'Ã¡', 'á'
                                    ),
                                    'Ã©', 'é'
                                ),
                                'Ã­', 'í'
                            ),
                            'Ã³', 'ó'
                        ),
                        'Ãº', 'ú'
                    ),
                    'Ã±', 'ñ'
                ),
                'Ã', 'Á'
            ),
            'Ã‰', 'É'
        ),
        'Ã“', 'Ó'
    ),
    'Ãš', 'Ú'
);


-- Corrección adicional para la diéresis

UPDATE soja_primera_clean
SET departamento_nombre = REPLACE(
    REPLACE(departamento_nombre, 'Ã¼', 'ü'),
    'Ãœ', 'Ü'
);

UPDATE soja_segunda_clean
SET departamento_nombre = REPLACE(
    REPLACE(departamento_nombre, 'Ã¼', 'ü'),
    'Ãœ', 'Ü'
);


-- =====================================================
-- NORMALIZACIÓN DE NOMBRES DE DEPARTAMENTOS
-- =====================================================

-- Se corrigen problemas de codificación de caracteres
-- detectados en departamento_nombre.