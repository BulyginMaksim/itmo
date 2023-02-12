-- Task 1.1: generate data
DROP TABLE cinema_views;
CREATE TABLE cinema_views (
    student_name VARCHAR2(128),
    cinema_name VARCHAR2(128),
    view_dt DATE  -- mm/dd/yyyy
);

INSERT INTO cinema_views(student_name, cinema_name, view_dt) (
    SELECT 
        'student_' || CAST(dbms_random.value(1, 40) AS INTEGER), 
        'cinema_' || CAST(dbms_random.value(1, 5) AS INTEGER),
        TO_DATE(
            TRUNC(
                DBMS_RANDOM.VALUE(
                    TO_CHAR(DATE '2023-01-01','J'),
                    TO_CHAR(DATE '2023-03-01','J')
                )
            ),
            'J'
        )
    FROM 
        DUAL
    CONNECT BY 
        LEVEL <= 200
);

-- Task 1.2: select pivot table [student X cinema]
SELECT 
    *
FROM (
    SELECT 
        student_name,
        cinema_name
    FROM 
        cinema_views
)
PIVOT (
    COUNT(*) 
    FOR cinema_name IN ('cinema_1', 'cinema_2', 'cinema_3', 'cinema_4', 'cinema_5')
)
ORDER BY
    student_name;

-- Task 1.3: select data without missing values 
SELECT 
    view_dt,
    COUNT(*) AS views_per_day
FROM 
    cinema_views
WHERE
    cinema_name = 'cinema_1'
GROUP BY
    view_dt
ORDER BY 
    view_dt;

SELECT 
    MIN(view_dt) - 1 AS min_view_dt, 
    MAX(view_dt) - MIN(view_dt) AS days_between
FROM (
    SELECT 
        view_dt,
        COUNT(*) AS views_per_day
    FROM 
        cinema_views
    WHERE
        cinema_name = 'cinema_1'
    GROUP BY
        view_dt
);

SELECT 
    all_views.view_dt, 
    NVL(views_per_day, 0) AS views_per_day
FROM (
    SELECT 
        view_dt,
        COUNT(*) AS views_per_day
    FROM 
        cinema_views
    WHERE
        cinema_name = 'cinema_1'
    GROUP BY
        view_dt
) calculated_views
RIGHT OUTER JOIN (
    SELECT 
        min_view_dt + LEVEL AS view_dt
    FROM (
        SELECT 
            MIN(view_dt) - 1 AS min_view_dt, 
            MAX(view_dt) - MIN(view_dt) + 1 AS days_between
        FROM (
            SELECT 
                view_dt,
                COUNT(*) AS views_per_day
            FROM 
                cinema_views
            WHERE
                cinema_name = 'cinema_1'
            GROUP BY
                view_dt
        )
    ) 
    CONNECT BY
        LEVEL <= days_between
) all_views
ON 
    calculated_views.view_dt = all_views.view_dt
ORDER BY 
    view_dt;

