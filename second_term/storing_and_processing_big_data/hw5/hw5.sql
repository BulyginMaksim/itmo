-- Task 5.1
DROP TABLE texts_uploaded;

CREATE TABLE texts_uploaded(
    id NUMBER,
    filename VARCHAR2(64),
    blob_content BLOB
);

INSERT INTO texts_uploaded
SELECT 
    1, 
    filename, 
    blob_content
FROM 
    apex_application_files
WHERE 
    filename = 'text1';

INSERT INTO texts_uploaded
SELECT 
    2, 
    filename, 
    blob_content
FROM 
    apex_application_files
WHERE 
    filename = 'text2';

INSERT INTO texts_uploaded
SELECT 
    3, 
    filename, 
    blob_content
FROM 
    apex_application_files
WHERE 
    filename = 'text3';

INSERT INTO texts_uploaded
SELECT 
    4, 
    filename, 
    blob_content
FROM 
    apex_application_files
WHERE 
    filename = 'text4';

INSERT INTO texts_uploaded
SELECT 
    5, 
    filename, 
    blob_content
FROM 
    apex_application_files
WHERE 
    filename = 'text5';

CREATE INDEX texts_uploaded_idx
ON texts_uploaded (blob_content)
INDEXTYPE IS CTXSYS.CONTEXT;

SELECT 
    token_text, 
    token_count
FROM 
    DR$TEXTS_UPLOADED_IDX$I
ORDER BY 
    token_count DESC
FETCH 
    FIRST 5 ROWS ONLY;
  
SELECT 
    token_text, 
    token_count
FROM 
    DR$TEXTS_UPLOADED_IDX$I
WHERE 
    LENGTH(TOKEN_TEXT) >= 4 
ORDER BY 
    token_count DESC
FETCH 
    FIRST 5 ROWS ONLY;

SELECT 
    id, 
    filename,
    SCORE(1) AS "БЫТЬ" , 
    SCORE(2) AS "ДУШИ", 
    SCORE(3) AS "ДУШЕ", 
    SCORE(4) AS "ГОВОРИЛ", 
    SCORE(5) AS "ВЕРНОГО"  
FROM 
    texts_uploaded
WHERE 
    CONTAINS(blob_content, 'БЫТЬ', 1) > 0
    OR CONTAINS(blob_content, 'ДУШИ', 2) > 0
    OR CONTAINS(blob_content, 'ДУШЕ', 3) > 0
    OR CONTAINS(blob_content, 'ГОВОРИЛ', 4) > 0
    OR CONTAINS(blob_content, 'ВЕРНОГО', 5) > 0;

-- Task 5.2
DROP TABLE customers;

CREATE TABLE customers(
    id INTEGER,
    full_name VARCHAR2(100)  -- pattern: 'Фамилия Имя Отчество'
);

INSERT INTO customers VALUES (1, 'Жмышенко Валерий Альбертович');
INSERT INTO customers VALUES (2, 'Шнюк Антон Павлович');
INSERT INTO customers VALUES (3, 'Пушкин Александр Сергеевич');
INSERT INTO customers VALUES (4, 'Лермонтов Михаил Юрьевич');

SELECT 
    id, 
    REGEXP_SUBSTR(full_name, '^[А-Яа-я]+', 1) AS second_name, 
    REGEXP_SUBSTR(full_name, ' [А-Яа-я]+ ', 1) AS first_name, 
    REGEXP_SUBSTR(full_name, '[А-Яа-я]+$', 1) AS patronymic
FROM 
    customers;
