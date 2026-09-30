DROP TABLE IF EXISTS appointments CASCADE;
DROP TABLE IF EXISTS appointment_log CASCADE;
DROP TABLE IF EXISTS patients CASCADE;
DROP TABLE IF EXISTS doctors CASCADE;

CREATE TABLE patients (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100),
    birth_date DATE
);

CREATE TABLE doctors (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    specialty VARCHAR(100) NOT NULL,
    phone VARCHAR(20)
);

CREATE TABLE appointments (
    id SERIAL PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date TIMESTAMP NOT NULL,
    status VARCHAR(30) DEFAULT 'scheduled',

    CONSTRAINT fk_patient
        FOREIGN KEY (patient_id)
        REFERENCES patients(id),

    CONSTRAINT fk_doctor
        FOREIGN KEY (doctor_id)
        REFERENCES doctors(id)
);

CREATE TABLE appointment_log (
    id SERIAL PRIMARY KEY,
    appointment_id INT,
    action VARCHAR(50),
    action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE doctors
ADD COLUMN consultation_fee NUMERIC(10,2);

ALTER TABLE doctors
ADD COLUMN updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

INSERT INTO patients (name, phone, email, birth_date)
VALUES
('Ahmad Ali', '0791111111', 'ahmad@gmail.com', '1995-05-10'),
('Sara Omar', '0792222222', 'sara@gmail.com', '1998-08-20'),
('Lina Khaled', '0793333333', 'lina@gmail.com', '2001-02-15'),
('Omar Saleh', '0794444444', 'omar@gmail.com', '1990-11-12');


INSERT INTO doctors (name, specialty, phone)
VALUES
('Dr. Mohammad Hassan', 'Cardiology', '0781111111'),
('Dr. Rana Ahmad', 'Dermatology', '0782222222'),
('Dr. Omar Khalil', 'Dentistry', '0783333333'),
('Dr. Nour Sami', 'Neurology', '0784444444');

INSERT INTO appointments
    (patient_id, doctor_id, appointment_date, status)
VALUES
    (1, 1, '2026-09-25 10:00:00', 'scheduled'),
    (2, 2, '2026-09-25 11:30:00', 'scheduled'),
    (3, 3, '2026-09-26 09:00:00', 'scheduled'),
    (2, 1, '2026-09-27 14:00:00', 'scheduled'),
    (1, 4, '2026-09-28 10:00:00', 'scheduled'),
    (3, 4, '2026-09-29 11:00:00', 'scheduled'),
    (1, 2, '2026-10-01 10:00:00', 'scheduled');

UPDATE doctors
SET consultation_fee = 25
WHERE id = 1;

UPDATE doctors
SET consultation_fee = 20
WHERE id = 2;

UPDATE doctors
SET consultation_fee = 30
WHERE id = 3;

UPDATE doctors
SET consultation_fee = 35
WHERE id = 4;

SELECT *
FROM appointments
WHERE status = 'scheduled';

SELECT *
FROM appointments
WHERE appointment_date >= '2026-09-25';

SELECT AVG(consultation_fee) AS average_fee
FROM doctors;

SELECT MAX(consultation_fee) AS highest_fee
FROM doctors;

SELECT MIN(consultation_fee) AS lowest_fee
FROM doctors;

SELECT *
FROM appointments
WHERE appointment_date
BETWEEN '2026-09-25' AND '2026-09-27 23:59:59';

SELECT *
FROM patients
WHERE id IN (1, 3);

SELECT *
FROM patients
WHERE name LIKE 'A%';

SELECT *
FROM appointments
ORDER BY appointment_date DESC
LIMIT 2;

SELECT *
FROM patients
ORDER BY id
OFFSET 2;

SELECT
    doctors.name AS doctor_name,
    COUNT(appointments.id) AS appointment_count,
    CASE
        WHEN COUNT(appointments.id) = 0 THEN 'No appointments'
        WHEN COUNT(appointments.id) = 1 THEN 'One appointment'
        ELSE 'Multiple appointments'
    END AS appointment_status
FROM doctors
LEFT JOIN appointments
    ON doctors.id = appointments.doctor_id
GROUP BY doctors.id, doctors.name;

WITH doctor_counts AS (
    SELECT
        doctor_id,
        COUNT(*) AS appointment_count
    FROM appointments
    GROUP BY doctor_id
)
SELECT *
FROM doctor_counts;

SELECT
    doctors.name AS doctor_name,
    COUNT(appointments.id) AS appointment_count
FROM doctors
LEFT JOIN appointments
    ON doctors.id = appointments.doctor_id
GROUP BY doctors.id, doctors.name
HAVING COUNT(appointments.id) > 1;

SELECT COUNT(*) AS total_patients
FROM patients;

SELECT
    doctor_id,
    COUNT(*) AS appointment_count
FROM appointments
GROUP BY doctor_id;

SELECT
    doctors.name AS doctor_name,
    COUNT(appointments.id) AS appointment_count
FROM doctors
LEFT JOIN appointments
    ON doctors.id = appointments.doctor_id
GROUP BY doctors.id, doctors.name;

SELECT
    status,
    COUNT(*) AS appointment_count
FROM appointments
GROUP BY status;

SELECT name
FROM patients
WHERE id NOT IN (
    SELECT patient_id
    FROM appointments
);

SELECT name
FROM patients
WHERE id IN (
    SELECT patient_id
    FROM appointments
);

SELECT
    doctors.name AS doctor_name,
    COUNT(appointments.id) AS appointment_count
FROM doctors
LEFT JOIN appointments
    ON doctors.id = appointments.doctor_id
GROUP BY doctors.id, doctors.name
HAVING COUNT(appointments.id) > 1;

SELECT *
FROM (
    SELECT
        doctor_id,
        COUNT(*) AS appointment_count
    FROM appointments
    GROUP BY doctor_id
) AS doctor_counts
WHERE appointment_count > 1;