/* 3da Fecha 13/12/2023: MySQL
Utilizando el esquema presentado en el ejercicio de Álgebra Relacional, escriba un Store Procedure en 
MySQL llamado “nuevo_chofer”. Este debe declarar como parámetro un dni y dos fechas (licencia_desde 
y licencia_hasta), y debe generar, dentro de una transacción, un nuevo chofer con los datos recuperados 
del dueño con dni igual al recibido como parámetro. Asuma que este dni ya existe en DUEÑO (esquema 
del ej. de AR). */

DELIMITER //

CREATE PROCEDURE `nuevo_chofer`(IN DNI INTEGER, IN licencia_desde DATE, licencia_hasta DATE)
BEGIN
    DECLARE nombre_chofer VARCHAR(50);
    DECLARE teléfono_chofer VARCHAR(50);
    DECLARE dirección_chofer VARCHAR(50);

    SELECT nombre, teléfono, dirección
    INTO nombre_chofer, teléfono_chofer, dirección_chofer
    FROM dueño d
    WHERE d.dni = DNI

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;
    
    INSERT INTO chofer(nombre, teléfono, dirección, fecha_licencia_desde, fecha_licencia_hasta)
    VALUES(nombre_chofer, teléfono_chofer, dirección_chofer, licencia_desde, licencia_hasta);

    COMMIT;
END //

DELIMITER ;