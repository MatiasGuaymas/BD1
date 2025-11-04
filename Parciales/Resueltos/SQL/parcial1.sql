/* 1ra Fecha 13/11/2024: MySQL
Se ha creado una base de datos siguiendo el esquema definido en el ejercicio de Algebra Relacional, 
con una relación uno a uno para las tablas y atributos. En esta base de datos, crear un stored procedure 
que sirva para agregar, de forma transaccional, un nuevo siniestro, junto al registro del perito, 
que realiza el peritaje. El stored procedure debe recibir los siguientes parámetros: 
#póliza, descripcion_siniestro, #taller, #perito, nombre_perito, apellido_perito, evaluación. 
El #siniestro es un autoincremental. La fecha_denuncia será la fecha actual. */

DELIMITER //

CREATE PROCEDURE `agregar_siniestro`(IN póliza INTEGER, IN descripcion_siniestro VARCHAR(45), IN taller INTEGER, IN perito INTEGER, IN nombre_perito VARCHAR(30), IN apellido_perito VARCHAR(30), IN evaluación VARCHAR(30))
BEGIN
    DECLARE current_date_only DATE;
    DECLARE last_id INTEGER;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;
    SET current_date_only = CURDATE();

    INSERT INTO siniestro(fecha_denuncia, descripcion_siniestro, #taller, #póliza)
    VALUES(current_date_only, descripcion_siniestro, taller, póliza); 
    
    SET last_id = LAST_INSERT_ID();

    -- Como me mandan #perito, nombre_perito y apellido_perito entiendo que el perito no existe y necesito insertarlo.
    INSERT INTO perito(#perito, nombre_perito, apellido_perito)
    VALUES(perito, nombre_perito, apellido_perito);
    
    INSERT INTO peritaje(fecha_peritaje, #perito, #siniestro, evaluación)
    VALUES(current_date_only, perito, last_id, evaluación);

    COMMIT;
END //

DELIMITER ;