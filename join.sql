-- Inner Join
SELECT
    patients.name AS patient_name,
    doctors.name AS doctor_name,
    doctors.specialty,
    appointments.appointment_date,
    appointments.status
FROM appointments
JOIN patients
    ON appointments.patient_id = patients.id
JOIN doctors
    ON appointments.doctor_id = doctors.id;

-- Left Join

SELECT
    patients.name AS patient_name,
    appointments.appointment_date,
    appointments.status
FROM patients
LEFT JOIN appointments
    ON patients.id = appointments.patient_id;

--Right Join

SELECT
    doctors.name AS doctor_name,
    doctors.specialty,
    appointments.appointment_date,
    appointments.status
FROM appointments
RIGHT JOIN doctors
    ON appointments.doctor_id = doctors.id;

-- Full Join

SELECT
    patients.name AS patient_name,
    appointments.appointment_date,
    appointments.status
FROM patients
FULL JOIN appointments
    ON patients.id = appointments.patient_id;

-- Cross Join
SELECT
    doctors.name AS doctor_name,
    clinic_departments.name AS department_name
FROM doctors
CROSS JOIN clinic_departments;

-- Self Join
SELECT
    child.name AS department,
    parent.name AS parent_department
FROM clinic_departments child
LEFT JOIN clinic_departments parent
    ON child.parent_id = parent.id;