CREATE OR REPLACE FUNCTION log_new_appointment()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO appointment_log (appointment_id, action)
    VALUES (NEW.id, 'New appointment');

    RETURN NEW;
END;
$$;

CREATE TRIGGER after_appointment_insert
AFTER INSERT ON appointments
FOR EACH ROW
EXECUTE FUNCTION log_new_appointment();
--
CREATE OR REPLACE FUNCTION validate_appointment_status()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF NEW.status NOT IN ('scheduled', 'completed', 'cancelled') THEN
        RAISE EXCEPTION 'Invalid appointment status';
    END IF;

    RETURN NEW;
END;
$$;

CREATE TRIGGER check_appointment_status
BEFORE INSERT OR UPDATE ON appointments
FOR EACH ROW
EXECUTE FUNCTION validate_appointment_status();

--INSERT INTO appointments
--  (patient_id, doctor_id, appointment_date, status)
--VALUES
--   (1, 2, '2026-10-02 10:00:00', 'hello');
--
CREATE OR REPLACE FUNCTION update_doctor_timestamp()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$;

CREATE TRIGGER set_doctor_updated_at
BEFORE UPDATE ON doctors
FOR EACH ROW
EXECUTE FUNCTION update_doctor_timestamp();

UPDATE doctors
SET phone = '0788888888'
WHERE id = 1;

SELECT id, name, phone, updated_at
FROM doctors
WHERE id = 1;
--
CREATE OR REPLACE FUNCTION log_appointment_update()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO appointment_log (appointment_id, action)
    VALUES (NEW.id, 'Appointment updated');

    RETURN NEW;
END;
$$;

CREATE TRIGGER after_appointment_update
AFTER UPDATE ON appointments
FOR EACH ROW
EXECUTE FUNCTION log_appointment_update();

UPDATE appointments
SET status = 'completed'
WHERE id = 1;

SELECT *
FROM appointment_log
ORDER BY id;
--
CREATE OR REPLACE FUNCTION prevent_doctor_delete()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM appointments
        WHERE doctor_id = OLD.id
    ) THEN
        RAISE EXCEPTION
            'Cannot delete doctor: doctor has appointments';
    END IF;

    RETURN OLD;
END;
$$;

CREATE TRIGGER prevent_doctor_delete
BEFORE DELETE ON doctors
FOR EACH ROW
EXECUTE FUNCTION prevent_doctor_delete();

-- DELETE FROM doctors
-- WHERE id = 1;