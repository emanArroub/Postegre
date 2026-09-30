DROP MATERIALIZED VIEW IF EXISTS doctor_appointment_summary;

CREATE MATERIALIZED VIEW doctor_appointment_summary AS
SELECT
    doctors.name AS doctor_name,
    doctors.specialty,
    COUNT(appointments.id) AS appointment_count
FROM doctors
LEFT JOIN appointments
    ON doctors.id = appointments.doctor_id
GROUP BY doctors.id, doctors.name, doctors.specialty;

--
SELECT * FROM doctor_appointment_summary;

-- REFRESH MATERIALIZED VIEW doctor_appointment_summary;
-- SELECT * FROM doctor_appointment_summary;