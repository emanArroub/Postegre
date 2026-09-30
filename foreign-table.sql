CREATE EXTENSION IF NOT EXISTS postgres_fdw;

CREATE SERVER IF NOT EXISTS clinic_server
FOREIGN DATA WRAPPER postgres_fdw
OPTIONS (
    host 'localhost',
    port '5432',
    dbname 'medical_clinic'
);

DROP USER MAPPING IF EXISTS FOR postgres SERVER clinic_server;
CREATE USER MAPPING FOR postgres
    SERVER clinic_server
    OPTIONS (
        user 'postgres',
        password 'Postgres123!'
    );

CREATE FOREIGN TABLE IF NOT EXISTS foreign_patients (
    id INT,
    name VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100),
    birth_date DATE
)
SERVER clinic_server
OPTIONS (
    schema_name 'public',
    table_name 'patients'
);

SELECT *
FROM foreign_patients;