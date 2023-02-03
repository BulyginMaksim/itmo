-- Task 6.1

DROP TABLE restaurants_6_1;
DROP SEQUENCE id_sequence;

CREATE TABLE restaurants_6_1 (
    restaurants_id INT PRIMARY KEY,
    restaurants_name VARCHAR(50)
);

CREATE SEQUENCE id_sequence
START WITH 1
INCREMENT BY 1;

CREATE OR REPLACE TRIGGER restaurants_trigger_first BEFORE INSERT ON restaurants_6_1 FOR EACH ROW
BEGIN
    SELECT id_sequence.NEXTVAL
    INTO :new.restaurants_id
    FROM dual;
END;
/

INSERT INTO restaurants_6_1(restaurants_name) VALUES ('KFC');
INSERT INTO restaurants_6_1(restaurants_name) VALUES ('Rostiks');
INSERT INTO restaurants_6_1(restaurants_name) VALUES ('McDonalds');

SELECT
    *
FROM
    restaurants_6_1;


-- Task 6.2
--6.2

DROP TABLE restaurants_6_2;
CREATE TABLE restaurants_6_2 (
    restaurants_id INT PRIMARY KEY,
    restaurants_name VARCHAR(50)
);

CREATE OR REPLACE TRIGGER restaurants_trigger_second BEFORE INSERT ON restaurants_6_2 FOR EACH ROW
BEGIN
    SELECT COALESCE(MAX(restaurants_id), 0) + 1
    INTO :new.restaurants_id
    FROM restaurants_6_2;
END;
/

INSERT INTO restaurants_6_2(restaurants_name) VALUES ('KFC');
INSERT INTO restaurants_6_2(restaurants_name) VALUES ('Rostiks');
INSERT INTO restaurants_6_2(restaurants_name) VALUES ('McDonalds');

SELECT
    *
FROM
    restaurants_6_2;

-- Task 6.3
DROP TRIGGER journal_event_trigger;
DROP TABLE events_journal;
CREATE TABLE events_journal (
    event_id INT GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
    event_log_dt DATE,
    operation_name VARCHAR(256),
    object_type VARCHAR(256),
    object_name VARCHAR(256)
);

CREATE OR REPLACE TRIGGER journal_event_trigger BEFORE CREATE OR ALTER OR DROP ON SCHEMA
DECLARE
    operation_name VARCHAR(256) := '';
    object_type VARCHAR(256) := '';
    object_name VARCHAR(256) := '';
BEGIN
    SELECT
        ora_sysevent,
        ora_dict_obj_type,
        ora_dict_obj_name
    INTO
        operation_name,
        object_type,
        object_name
    FROM dual;

    IF
        object_type IN ('TABLE', 'PROCEDURE', 'SEQUENCE', 'VIEW')
    THEN
        INSERT INTO
            events_journal (event_log_dt, operation_name, object_type, object_name)
        VALUES
            (sysdate, operation_name, object_type, object_name);
    END IF;
END;
/

-- Table events example
DROP TABLE example_table;
CREATE TABLE example_table (
    id INT PRIMARY KEY,
    first_field VARCHAR(50)
);
ALTER TABLE example_table ADD second_field VARCHAR(50);

-- Procedure events example
DROP PROCEDURE example_procedure;
CREATE PROCEDURE example_procedure(val IN NUMBER, square_val OUT NUMBER)
IS
BEGIN
    square_val := val * val;
END example_procedure;
/
ALTER PROCEDURE example_procedure COMPILE;

-- Sequence events example
DROP SEQUENCE example_sequence;
CREATE SEQUENCE example_sequence
START WITH 1
INCREMENT BY 1;

-- View events example
DROP VIEW example_view;
CREATE OR REPLACE VIEW example_view AS
SELECT 1 as id FROM dual;

SELECT
    *
FROM
    events_journal;
