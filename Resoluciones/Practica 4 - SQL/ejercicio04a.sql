/* 4.	Utiliza la vista generada en el ejercicio anterior para resolver las siguientes consultas:
a.	Obtener la cantidad de doctores por cada paciente que tiene disponible en su ciudad */

SELECT patient_id, count(doctor_id)
FROM doctors_per_patients
GROUP BY patient_id;