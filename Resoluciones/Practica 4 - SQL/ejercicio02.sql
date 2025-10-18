/* 2.	Hallar aquellos pacientes que para todas sus consultas médicas siempre 
hayan dejado su número de teléfono primario (nunca el teléfono secundario).  */

/* NOT IN evalúa una colección completa de valores (lista),
y si alguno es NULL, se invalida toda la comparación.

NOT EXISTS evalúa cada fila individualmente,
y no se ve afectado por los NULL. */

SELECT p.patient_id, p.patient_name
FROM PATIENT p
WHERE NOT EXISTS ( 
    SELECT 1
    FROM APPOINTMENT a
    WHERE a.patient_id = p.patient_id
      AND a.contact_phone <> p.primary_phone
);