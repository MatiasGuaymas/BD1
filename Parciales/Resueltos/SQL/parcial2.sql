/* 2da Fecha 27/11/2024: MySQL
Se dispone de una base de datos para la gestión de subastas judiciales, permitiendo registrar la
participación de oferentes, previamente inscritos, en estas. Para cada subasta se poseen diferentes
ofertas, cada una con un monto superior a la oferta previa, de estas se registra, además del monto, el 
oferente correspondiente y la fecha. En la tabla "Oferta" siempre se guarda la última oferta válida. Es 
necesario registrar un historial de cada oferta realizada. 

SUBASTA_JUDICIAL (#subasta, fecha_comienzo, fecha_fin)
INSCRIPTO_SUBASTA (#inscripto_subasta, #oferente, #subasta, fecha_inscripcion)
OFERENTE (#oferente, nombre, apellido, cuil, localidad)
OFERTA (#oferta, #subasta, monto, fecha_oferta) 
OFERTA_HISTORIAL (#oferta_historial, #oferente, #subasta, monto, fecha_oferta, fecha_auditoria) 

1) Generar un trigger que guarda la última oferta en la tabla "Oferta_Historial" antes de grabar la nueva
oferta */

DELIMITER //

CREATE TRIGGER `add_oferta_historial`
AFTER UPDATE ON oferta
FOR EACH ROW
BEGIN
    INSERT INTO oferta_historial(#oferente, #subasta, monto, fecha_oferta, fecha_auditoria)
    VALUES (OLD.#oferente, OLD.#subasta, OLD.monto, OLD.fecha_oferta, CURDATE());
END; //


DELIMITER ;
