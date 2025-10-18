--1ra fecha

DELIMITER //
CREATE TRIGGER sumar_comentario
AFTER INSERT ON comentarios
FOR EACH ROW
BEGIN
    UPDATE actividades
    SET cantidad_comentarios = cantidad_comentarios + 1
    WHERE #actividad = NEW.#actividad;
END;
// DELIMITER ;

-- 2da fecha

DELIMITER //
CREATE TRIGGER agregar_sancion
AFTER INSERT ON recibe_sancion
FOR EACH ROW
BEGIN
    INSERT INTO auditoria (#auditoria, #empleado, #sancion, prioridad)
    VALUES (NEW.#auditoria, NEW.#empleado, NEW.#sancion, "Inmediata");
END;
// DELIMITER ;

--3ra fecha

DELIMITER //
CREATE PROCEDURE nuevo_chofer(IN dni_dueño INT, IN fecha_desde DATE, IN fecha_hasta DATE)
BEGIN
    DECLARE id_chofer INT;
    DECLARE nombre_chofer VARCHAR(127);
    DECLARE telefono_chofer VARCHAR(15);
    DECLARE direccion_chofer VARCHAR(127);
        
    SELECT id_dueño, nombre, telefono, direccion
    INTO id_chofer, nombre_chofer, telefono_chofer, direccion_chofer
    FROM dueño d
    WHERE d.dni = dni_dueño

    START TRANSACTION;
    INSERT INTO chofer (id_chofer, nombre, telefono, direccion, fecha_licencia_desde, fecha_licencia_hasta, dni)
    VALUES (id_chofer, nombre_chofer, telefono_chofer, direccion_chofer, fecha_desde, fecha_hasta, dni_dueño);
    COMMIT;
END;
// DELIMITER ;
