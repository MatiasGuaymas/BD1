/* 6. Crear un Stored Procedure que realice los siguientes pasos dentro de una transacción:
a.	Realizar la siguiente consulta: cada pacient (identificado por id_patient), calcule la cantidad de appointments 
que tiene registradas. Registrar la fecha en la que se realiza esta carga y además del usuario con el se realiza.
b.	Guardar el resultado de la consulta en un cursor.
c.	Iterar el cursor e insertar los valores correspondientes en la tabla APPOINTMENTS PER PATIENT. Tenga en cuenta que last_update es la fecha en que se realiza esta carga, 
es decir la fecha actual, mientras que user es el usuario logueado actualmente, utilizar las correspondientes funciones para esto.   */

DELIMITER //

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_appointments_per_patient`()
BEGIN
    DECLARE fin INT DEFAULT 0;
    DECLARE id_patient INT;
    DECLARE total_appointments INT;

    DECLARE cur CURSOR FOR
        SELECT 
            p.patient_id,
            COUNT(a.appointment_date) AS count_appointments
        FROM patient p
        LEFT JOIN appointment a 
            ON p.patient_id = a.patient_id
        GROUP BY p.patient_id;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = 1;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM appointments_per_patient;

    OPEN cur;

    loop_cursor: LOOP
        FETCH cur INTO id_patient, total_appointments;
        IF fin = 1 THEN
            LEAVE loop_cursor;
        END IF;

        INSERT INTO appointments_per_patient 
            (id_patient, count_appointments, last_update, `user`)
        VALUES 
            (id_patient, total_appointments, NOW(), CURRENT_USER());
    END LOOP;

    CLOSE cur;

    COMMIT;
END //

DELIMITER ;

CALL insert_appointments_per_patient();
SELECT * FROM appointments_per_patient;