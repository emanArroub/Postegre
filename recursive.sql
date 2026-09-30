DROP TABLE IF EXISTS clinic_departments CASCADE;
CREATE TABLE clinic_departments (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    parent_id INT,
    
    CONSTRAINT fk_parent_department
        FOREIGN KEY (parent_id)
        REFERENCES clinic_departments(id)
);

INSERT INTO clinic_departments (name, parent_id)
VALUES
    ('Medical Center', NULL),
    ('Cardiology', 1),
    ('Cardiology Emergency', 2),
    ('Cardiology Surgery', 2),
    ('Dermatology', 1),
    ('Dermatology Surgery', 5);

WITH RECURSIVE department_tree AS (
    SELECT
        id,
        name,
        parent_id,
        1 AS level
    FROM clinic_departments
    WHERE parent_id IS NULL

    UNION ALL

    SELECT
        d.id,
        d.name,
        d.parent_id,
        dt.level + 1
    FROM clinic_departments d
    JOIN department_tree dt
        ON d.parent_id = dt.id
)
SELECT *
FROM department_tree
ORDER BY level, id;