/* 4. c. Obtener los doctores que comparten ciudad con más de cinco pacientes. */

SELECT doctor_id
FROM doctors_per_patients
GROUP BY doctor_id
HAVING COUNT(patient_id) > 5;