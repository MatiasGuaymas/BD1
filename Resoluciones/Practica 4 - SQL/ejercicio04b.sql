/* 4. b. Obtener los nombres de los pacientes sin doctores en su ciudad */

SELECT p.patient_name
FROM PATIENT p
LEFT JOIN doctors_per_patients dp ON p.patient_id = dp.patient_id
WHERE dp.doctor_id IS NULL;