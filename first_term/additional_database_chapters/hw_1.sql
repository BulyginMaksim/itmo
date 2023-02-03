DROP TABLE orders;
DROP TABLE employees;
DROP TABLE departments;
DROP TABLE delivery_prices;
DROP TABLE clients;
DROP TABLE contragents;
DROP TABLE products;
DROP TABLE categories;

CREATE TABLE departments (
    department_id INTEGER PRIMARY KEY NOT NULL,
    department_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE employees (
    employee_id INTEGER PRIMARY KEY NOT NULL,
    first_name VARCHAR(20) NOT NULL,
    second_name VARCHAR(20) NOT NULL,
    department_id INTEGER NOT NULL REFERENCES departments(department_id),
    birthday_dt DATE,
    employment_dt DATE,
    UNIQUE(first_name, second_name, birthday_dt)
);

CREATE TABLE delivery_prices (
    price_id INTEGER PRIMARY KEY NOT NULL,
    city_name VARCHAR(50) NOT NULL UNIQUE,
    delivery_price_rub DECIMAL NOT NULL CHECK(delivery_price_rub > 0)
);

CREATE TABLE categories (
    category_id INTEGER PRIMARY KEY NOT NULL,
    category_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE products (
    product_id INTEGER PRIMARY KEY NOT NULL,
    product_name VARCHAR(150) NOT NULL,
    quantity_available_for_order INTEGER NOT NULL CHECK(quantity_available_for_order >= 0),
    category_id INTEGER NOT NULL REFERENCES categories(category_id),
    price_rub DECIMAL NOT NULL CHECK(price_rub > 0),
    is_original_product NUMERIC(1) NOT NULL
                                   CHECK(
                                        is_original_product = 0
                                        OR is_original_product = 1
                                   ),
    UNIQUE(product_name, category_id, is_original_product)
);

CREATE TABLE contragents (
    contragent_id INTEGER PRIMARY KEY NOT NULL,
    contragent_name VARCHAR(50) NOT NULL,
    contragent_info VARCHAR(150) NOT NULL,
    UNIQUE(contragent_name, contragent_info)
);

CREATE TABLE clients (
    client_id INTEGER PRIMARY KEY NOT NULL,
    first_name VARCHAR(20) NOT NULL,
    second_name VARCHAR(20) NOT NULL,
    contragent_id INTEGER NOT NULL REFERENCES contragents(contragent_id),
    UNIQUE(first_name, second_name, contragent_id)
);

CREATE TABLE orders (
    order_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL REFERENCES products(product_id),
    client_id INTEGER NOT NULL REFERENCES clients(client_id),
    employee_id NOT NULL REFERENCES employees(employee_id),
    order_datetime TIMESTAMP NOT NULL,
    quantity_in_order INTEGER NOT NULL CHECK(quantity_in_order > 0),
    city_name VARCHAR(50) NOT NULL,
    PRIMARY KEY(order_id, product_id)
);

GRANT SELECT ON orders TO PUBLIC;
GRANT SELECT ON employees TO PUBLIC;
GRANT SELECT ON departments TO PUBLIC;
GRANT SELECT ON delivery_prices TO PUBLIC;
GRANT SELECT ON clients TO PUBLIC;
GRANT SELECT ON contragents TO PUBLIC;
GRANT SELECT ON products TO PUBLIC;
GRANT SELECT ON categories TO PUBLIC;

