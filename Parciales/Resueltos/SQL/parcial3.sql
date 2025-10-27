/* SF 2024: MySQL
Se dispone de una base de datos que registra los envíos a usuarios por parte de una empresa de 
correos. De cada envío, se sabe el usuario que lo solicita además de la información concreta del envío.
Además, la empresa dispone de un sistema de puntos para los usuarios, que luego permite otorgarle 
beneficios. La estructura de la base de datos es la siguiente:
Usuario (#usuario, nombre, emial, telefono, puntaje) 
Envio (#envio, #usuario, #direccion_entrega, fecha_solicitud, informacion_destinatario, estado_envio)
Beneficio (#beneficio, descripcion, puntos_requeridos)
Canje (#canje, #usuario, #beneficio, fecha_canje)

1) Generar un trigger que aumente en 5 puntos el puntaje del usuario luego de que este registre un
nuevo envío. */

DELIMITER //

CREATE TRIGGER `update_puntaje_usuario`
AFTER INSERT ON envio
FOR EACH ROW
BEGIN
    UPDATE usuario
    SET puntaje = puntaje + 5
    WHERE #usuario = NEW.#usuario;
END; // 

DELIMITER ;