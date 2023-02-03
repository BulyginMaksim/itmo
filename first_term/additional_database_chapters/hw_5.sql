-- Task 5.1

DROP VIEW mbulygin_task_5_1_1;
DROP VIEW mbulygin_task_5_1_2;

CREATE OR REPLACE VIEW mbulygin_task_5_1_1 AS
SELECT
    empno,
    ename
FROM
    emp
WHERE
    EXTRACT(MONTH FROM HIREDATE) = 10;

CREATE OR REPLACE VIEW mbulygin_task_5_1_2 AS
SELECT
   *
FROM
    emp
WHERE
    job = 'MANAGER' AND
    deptno IN (
        SELECT
           deptno
        FROM
            emp
        GROUP BY
            deptno
        HAVING
            COUNT (*) >= 3
    );

-- Task 5.2

DROP TABLE dept1;
DROP SEQUENCE dept_sequence;

CREATE TABLE dept1 (
    dept_no INTEGER NOT NULL,
    dname VARCHAR(50) NOT NULL,
    loc VARCHAR(50) NOT NULL
);

CREATE SEQUENCE dept_sequence
    MINVALUE 10
    START WITH 10
    INCREMENT BY 10
    CACHE 20;

BEGIN
FOR loop_counter IN 1..10 LOOP
INSERT INTO dept1
    (dept_no, dname, loc)
VALUES
    (
        dept_sequence.NEXTVAL,
        CASE round(dbms_random.value(1,4))
            WHEN 1 THEN 'ACCOUNTING'
            WHEN 2 THEN 'RESEARCH'
            WHEN 3 THEN 'SALES'
            WHEN 4 THEN 'OPERATIONS'
        END,
        CASE round(dbms_random.value(1,4))
            WHEN 1 THEN 'NEW YORK'
            WHEN 2 THEN 'DALLAS'
            WHEN 3 THEN 'CHICAGO'
            WHEN 4 THEN 'BOSTON'
        END
    );
END LOOP;
COMMIT;
END;
/

-- Task 5.3
CREATE OR REPLACE FUNCTION factorial(val in number)
RETURN number IS
BEGIN
    IF(val = 1)
    THEN RETURN val;
    ELSE RETURN val * factorial(val - 1);
    END IF;
END;
/
SELECT factorial(4) FROM dual;


CREATE OR REPLACE FUNCTION days_from_employement(hiredate date)
RETURN NUMBER IS
BEGIN
    RETURN ROUND(CURRENT_DATE - hiredate);
END;
/
SELECT
    empno,
    hiredate,
    days_from_employement(hiredate) AS employment_days
FROM
    emp;


CREATE OR REPLACE FUNCTION get_managers(manager_id INTEGER) RETURN STRING IS
    manager_name VARCHAR(256) := '';
    next_manager_id INT := 0;
    next_managers VARCHAR(256) := '';
BEGIN
    IF manager_id IS NULL THEN
       RETURN NULL;
    ELSE
        SELECT
            ename,
            mgr
        INTO
            manager_name,
            next_manager_id
        FROM
            emp
        WHERE
            empno = manager_id;

        next_managers := get_managers(next_manager_id);
        IF next_managers IS NULL THEN
            RETURN manager_name;
        ELSE
            RETURN manager_name || ', ' || next_managers;
        END IF;
    END IF;
END;
/
SELECT
    empno,
    ename,
    get_managers(mgr) as managers
FROM
    emp;

-- Task 5.4
CREATE OR REPLACE PROCEDURE stat_over_emp(
    n_employees OUT NUMBER,
    n_departments OUT NUMBER,
    n_jobs OUT NUMBER,
    total_salary OUT NUMBER
)
IS BEGIN
    SELECT
        COUNT(DISTINCT empno) AS n_employees,
        COUNT(DISTINCT deptno) AS n_departments,
        COUNT(DISTINCT job) AS n_jobs,
        SUM(sal) AS total_salary
    INTO
        n_employees,
        n_departments,
        n_jobs,
        total_salary
    FROM
        emp;
END stat_over_emp;
/

DECLARE
    n_employees NUMBER;
    n_departments NUMBER;
    n_jobs NUMBER;
    total_salary NUMBER;
BEGIN
    stat_over_emp(n_employees, n_departments, n_jobs, total_salary);
    dbms_output.put_line('Number of employees: ' || n_employees);
    dbms_output.put_line('Number of departments: ' || n_departments);
    dbms_output.put_line('Number of different jobs: ' || n_jobs);
    dbms_output.put_line('Total salary: ' || total_salary);
END;
/

-- Task 5.5

DROP TABLE debug_log;
CREATE TABLE debug_log (
    id INT PRIMARY KEY,
    log_dt DATE,
    message VARCHAR(256),
    in_source VARCHAR(256)
);

DROP SEQUENCE debug_sequence;
CREATE SEQUENCE debug_sequence
START WITH 1
INCREMENT BY 1
CACHE 20;

CREATE OR REPLACE PROCEDURE get_employees_max_min_dt(less_work_dt OUT DATE, more_work_dt OUT DATE)
IS BEGIN
    SELECT
        hiredate
    INTO
        less_work_dt
    FROM emp
    WHERE hiredate = (
        SELECT
            MIN(hiredate)
        FROM
            emp
    );

    SELECT
        hiredate
    INTO
        more_work_dt
    FROM emp
    WHERE hiredate = (
        SELECT
            MAX(hiredate)
        FROM
            emp
    );
END get_employees_max_min_dt;
/

DECLARE
    less_work_dt DATE;
    more_work_dt DATE;
BEGIN
    get_employees_max_min_dt(less_work_dt, more_work_dt);
INSERT INTO
    debug_log(id, log_dt, message, in_source)
VALUES
    (
        debug_sequence.nextval,
        sysdate,
        'Less works: ' || CAST(less_work_dt as VARCHAR(256)) || ', more works: ' || CAST(more_work_dt as VARCHAR(256)),
        'get_employees_max_min_dt'
    );
END;
/

SELECT
    *
FROM
    debug_log;

-- Task 5.6
CREATE OR REPLACE PROCEDURE log_info(info_message IN VARCHAR2, in_source IN VARCHAR2)
IS
    PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
    INSERT INTO debug_log(id, log_dt, message, in_source)
    VALUES (debug_sequence.nextval, sysdate, info_message, in_source);
    COMMIT;
    EXCEPTION
    WHEN OTHERS THEN
    RETURN;
END log_info;
/

-- first error
CREATE OR REPLACE PROCEDURE division(numerator IN NUMBER, denominator IN NUMBER, quotient OUT NUMBER)
IS
BEGIN
    quotient := numerator/denominator;
    log_info('Numerator: ' || numerator || ', denominator: ' || denominator, 'division');
    EXCEPTION
    WHEN OTHERS THEN log_info(SUBSTR(SQLERRM, 1, 100), 'division');
END division;
/

DECLARE
    numerator NUMBER;
    denominator NUMBER;
    quot NUMBER;
BEGIN
    numerator := 1;
    denominator := 0;
    division(numerator, denominator, quot);
END;
/

-- second error
CREATE OR REPLACE PROCEDURE get_pow(val IN NUMBER, pow IN NUMBER, pow_val OUT NUMBER)
IS
BEGIN
    pow_val := POWER(val, pow);
    log_info('Pow_val: ' || pow_val, 'get_pow');
    EXCEPTION
    WHEN OTHERS THEN log_info(SUBSTR(SQLERRM, 1, 100), 'get_pow');
END get_pow;
/

DECLARE
    val NUMBER;
    pow NUMBER;
    pow_val NUMBER;
BEGIN
    val := -2;
    pow := -2.5;
    get_pow(val, pow, pow_val);
END;
/

-- third error
CREATE OR REPLACE PROCEDURE get_log(val IN NUMBER, log_val OUT NUMBER)
IS
BEGIN
    log_val := LN(val);
    log_info('Log_val: ' || log_val, 'get_log');
    EXCEPTION
    WHEN OTHERS THEN log_info(SUBSTR(SQLERRM, 1, 100), 'get_log');
END get_log;
/

DECLARE
    val NUMBER;
    log_val NUMBER;
BEGIN
    val := -1;
    get_log(val, log_val);
END;
/

-- fourth error
DROP TABLE empty_table;
CREATE TABLE empty_table (
    val NUMBER
);

CREATE OR REPLACE PROCEDURE get_val(val OUT NUMBER)
IS
BEGIN
    SELECT val
    INTO val
    FROM empty_table;
    log_info('Val: ' || val, 'get_val');
    EXCEPTION
    WHEN OTHERS THEN log_info(SUBSTR(SQLERRM, 1, 100), 'get_val');
END get_val;
/

DECLARE
    val NUMBER;
BEGIN
    get_val(val);
END;
/

SELECT
    *
FROM
    debug_log
ORDER BY
    id;
