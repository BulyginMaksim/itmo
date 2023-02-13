DROP TABLE customers;
DROP TABLE items;
DROP TABLE json_items;
DROP TABLE json_items_single;


CREATE TABLE customers (
    customer_name VARCHAR2(128),
    customer_id INT,
    item_id INT
);

INSERT INTO customers (customer_name, customer_id, item_id) 
VALUES ('Алексей', 1, 1);
INSERT INTO customers (customer_name, customer_id, item_id) 
VALUES ('Алексей', 1, 3);
INSERT INTO customers (customer_name, customer_id, item_id) 
VALUES ('Мария', 2, 1);
INSERT INTO customers (customer_name, customer_id, item_id) 
VALUES ('Максим', 3, 2);
INSERT INTO customers (customer_name, customer_id, item_id) 
VALUES ('Александр', 4, 3);
INSERT INTO customers (customer_name, customer_id, item_id) 
VALUES ('Андрей', 5, 4);

CREATE TABLE items (
    item_id INT,
    item_name VARCHAR2(128),
    item_category VARCHAR2(128)
);

INSERT INTO items (item_id, item_name, item_category) 
VALUES (1, 'Учебник', 'Книги');
INSERT INTO items (item_id, item_name, item_category) 
VALUES (2, 'Блюдце столовое', 'Посуда');
INSERT INTO items (item_id, item_name, item_category) 
VALUES (3, 'Диван', 'Мебель');
INSERT INTO items (item_id, item_name, item_category) 
VALUES (4, 'Сборник анекдотов', 'Книги');

CREATE TABLE json_items (
    json_item VARCHAR2 (1024)
    CONSTRAINT ensure_json CHECK (json_item IS JSON)
);

INSERT INTO json_items
SELECT
    json_object(
        'item_id' VALUE item_id,
        'item_name' VALUE item_name,
        'item_category' VALUE item_category,
        'customer_names' VALUE (
            SELECT 
                JSON_ARRAYAGG(customer_name)
            FROM 
                customers
            WHERE
                customers.item_id = items.item_id
        )
    ) AS json_item
FROM
    items;

SELECT
    *
FROM
    json_items;

CREATE TABLE json_items_single (
    json_backend VARCHAR2 (3000)
    CONSTRAINT ensure_json_backend CHECK (json_backend IS JSON)
);

INSERT INTO json_items_single
SELECT
    JSON_OBJECT(
        'key' VALUE 'customers_items',
        'value' VALUE JSON_ARRAYAGG(json_item)
    ) AS json_backend
FROM
    json_items;

SELECT
    *
FROM
    json_items_single;

