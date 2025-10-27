/* 1ra Fecha 15/11/2023: MySQL
1. Se modificó el esquema anterior, presentado en el ejercicio de Álgebra Relacional, para agregar a la 
tabla ACTIVIDAD una nueva columna llamada “cantidad_comentarios”, resultando:
ACTIVIDAD (#actividad, #proyecto, nombre, detalle_actividad, condiciones_actividad, cantidad_comentarios)
Escriba un Trigger para que con cada nuevo comentario registrado se actualice la nueva columna de 
la actividad (cantidad_comentarios).

2. Enuncie y explique dos motivos por los cuales necesitaría definir una vista. */

-- 1.

DELIMITER //

CREATE TRIGGER `update_actividad_comentarios`
AFTER INSERT ON comentario
FOR EACH ROW
BEGIN
    UPDATE actividad
    SET cantidad_comentarios = cantidad_comentarios + 1;
    WHERE #actividad = NEW.#actividad;
END; // 

DELIMITER ;

/* 2. 
- Abstracción y simplificación de consultas complejas: Usar una vista para ocultar la complejidad de consultas frecuentes (joins, agregaciones, filtros) y presentar una tabla virtual fácil de usar.
- Seguridad / control de acceso a los datos: Usar una vista para exponer solo las columnas o filas permitidas a ciertos usuarios, restringiendo el acceso a datos sensibles. */