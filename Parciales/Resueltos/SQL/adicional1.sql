/* Cliente(#cliente, nombre, email)
Libro(#libro, titulo, autor, precio)
Compra(#compra, fecha_compra, #cliente)
DetalleCompra(#compra, #libro, cantidad) */

-- ||||||||| PARTE A |||||||||
-- 1.
SELECT DISTINCT c.nombre, c.email
FROM cliente c
INNER JOIN compra cr ON c.#cliente = cr.#cliente
INNER JOIN detallecompra dc ON cr.#compra = dc.#compra
INNER JOIN libro l ON dc.#libro = l.#libro
WHERE l.titulo = 'Borges';

-- 2.
SELECT l.titulo
FROM libro l
WHERE l.#libro NOT IN (
    SELECT dc.#libro
    FROM detallecompra dc
);

-- 3.
SELECT c.nombre, SUM(dc.cantidad * l.precio)
FROM cliente c
INNER JOIN compra cr ON c.#cliente = cr.#cliente
INNER JOIN detallecompra dc ON cr.#compra = dc.#compra
INNER JOIN libro l ON dc.#libro = l.#libro
GROUP BY c.#cliente, c.nombre;

-- 4.
SELECT l.autor, SUM (dc.cantidad) as cantTotal
FROM libro l
INNER JOIN detallecompra dc ON l.#libro = dc.#libro
GROUP BY l.autor
ORDER BY cantTotal DESC
LIMIT 1;

-- ||||||||| PARTE B |||||||||
DELIMITER //

CREATE PROCEDURE `registrar_compra` (IN p_cliente INTEGER, IN p_libro INTEGER, IN p_cantidad INTEGER)
BEGIN
    DECLARE last_id INTEGER;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    INSERT INTO compra(fecha_compra, #cliente)
    VALUES (CURDATE(), p_cliente);

    SET last_id = LAST_INSERT_ID();

    INSERT INTO detallecompra(#compra, #libro, #cantidad)
    VALUES(last_id, p_libro, p_cantidad);

    COMMIT;
END //

DELIMITER ;

-- ||||||||| PARTE C |||||||||
DELIMITER //

CREATE TRIGGER `update_precio_promedio`
AFTER INSERT ON detallecompra
FOR EACH ROW
BEGIN
    IF EXISTS (SELECT 1 FROM estadisticalibro WHERE #libro = NEW.#libro) THEN 
        UPDATE estadisticalibro
        SET cant_vendida = cant_vendida + NEW.cantidad,
            total_recaudado = total_recaudado + (NEW.cantidad * (SELECT precio FROM libro WHERE #libro = NEW.#libro))
        WHERE #libro = NEW.#libro;
    ELSE
        INSERT INTO estadisticalibro (#libro, cant_vendida, total_recaudado)
        VALUES (NEW.#libro, NEW.cantidad, (NEW.cantidad * (SELECT precio FROM libro WHERE #libro = NEW.#libro)));
    END IF;
END; //

DELIMITER ;
