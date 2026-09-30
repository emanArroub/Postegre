CREATE OR REPLACE VIEW appointment_details AS
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
-->
SELECT *
FROM appointment_details
WHERE status = 'scheduled';
--
DROP VIEW IF EXISTS patient_list CASCADE;
CREATE VIEW patient_list AS 
SELECT
    id,
    name,
    phone,
    email
FROM patients;
-->
UPDATE patient_list
SET phone = '0799999999'
WHERE id = 1;
-->
SELECT * FROM patient_list;
SELECT * FROM patients;
--
CREATE OR REPLACE VIEW patient_contact AS
SELECT
    id,
    name,
    phone
FROM patient_list;
-->
SELECT * FROM patient_contact;