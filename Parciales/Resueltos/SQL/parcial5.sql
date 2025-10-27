/* 2da Fecha 29/11/2023: MySQL
Se modificó el esquema anterior, presentado en el ejercicio de Álgebra Relacional, para agregar 
la siguiente tabla:
AUDITORIA (#auditoria, #empleado, #sanción, prioridad)
Escriba un trigger para que con cada nueva sanción registrada a un empleado, si esta es de gravedad 
“Alta”, se agregue una nueva tupla a la tabla AUDITORIA donde se registre la correspondiente 
información con la prioridad “Inmediata”. */

DELIMITER //

CREATE TRIGGER `add_auditoria`
AFTER INSERT ON recibe_sancion
FOR EACH ROW
BEGIN
    IF NEW.gravedad = 'Alta' THEN
    BEGIN
        INSERT INTO auditoria (#empleado, #sanción, prioridad)
        VALUES (NEW.#empleado, NEW.#sancion, 'Inmediata');
    END IF;
END; // 

DELIMITER ;