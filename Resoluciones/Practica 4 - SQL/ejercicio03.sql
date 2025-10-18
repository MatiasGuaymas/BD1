/* 3. Crear una vista llamada ‘doctors_per_patients’ que muestre los id de los pacientes 
y los id de doctores de la ciudad donde vive el paciente.*/

DROP VIEW IF EXISTS doctors_per_patients;

CREATE VIEW doctors_per_patients AS
SELECT p.patient_id, d.doctor_id
FROM patient AS p
INNER JOIN doctor AS d
ON p.patient_city = d.doctor_city;

SELECT * FROM doctors_per_patients;