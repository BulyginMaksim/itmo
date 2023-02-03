INSERT INTO categories
    (category_id, category_name)
VALUES
    (1, 'promo souvenirs');
INSERT INTO categories
    (category_id, category_name)
VALUES
    (2, 'business souvenirs');
INSERT INTO categories
    (category_id, category_name)
VALUES
    (3, 'vip souvenirs');
INSERT INTO categories
    (category_id, category_name)
VALUES
    (4, 'thematic souvenirs');

INSERT INTO products
    (product_id, product_name, quantity_available_for_order,
    category_id, price_rub, is_original_product)
VALUES
    (1, 'Saint-Petersburg magnet', 100, 4, 300, 1);
INSERT INTO products
    (product_id, product_name, quantity_available_for_order,
    category_id, price_rub, is_original_product)
VALUES
    (2, 'Saint-Petersburg magnet', 200, 4, 100, 0);
INSERT INTO products
    (product_id, product_name, quantity_available_for_order,
    category_id, price_rub, is_original_product)
VALUES
    (3, 'Moscow flag', 50, 4, 500, 1);
INSERT INTO products
    (product_id, product_name, quantity_available_for_order,
    category_id, price_rub, is_original_product)
VALUES
    (4, 'Parker pen', 200, 2, 5000, 1);
INSERT INTO products
    (product_id, product_name, quantity_available_for_order,
    category_id, price_rub, is_original_product)
VALUES
    (5, 'Parker pen', 200, 2, 500, 0);
INSERT INTO products
    (product_id, product_name, quantity_available_for_order,
    category_id, price_rub, is_original_product)
VALUES
    (6, 'Signed ball by random famous star', 5, 4, 5000, 1);
INSERT INTO products
    (product_id, product_name, quantity_available_for_order,
    category_id, price_rub, is_original_product)
VALUES (7, 'Signed ball by random famous star', 5, 4, 500, 0);

INSERT INTO departments
    (department_id, department_name)
VALUES
    (1, 'Operators');
INSERT INTO departments
    (department_id, department_name)
VALUES
    (2, 'HR');
INSERT INTO departments
    (department_id, department_name)
VALUES
    (3, 'Finance');
INSERT INTO departments
    (department_id, department_name)
VALUES
    (4, 'Sales');

INSERT INTO employees
    (employee_id, first_name, second_name, department_id, birthday_dt, employment_dt)
VALUES
    (1, 'Vasya', 'Petrov', 1, TO_DATE('2000-01-01', 'yyyy-mm-dd'), TO_DATE('2020-06-01', 'yyyy-mm-dd'));
INSERT INTO employees
    (employee_id, first_name, second_name, department_id, birthday_dt, employment_dt)
VALUES
    (2, 'Vasilisa', 'Petrovna', 1, TO_DATE('1999-01-01', 'yyyy-mm-dd'), TO_DATE('2020-05-01', 'yyyy-mm-dd'));
INSERT INTO employees
    (employee_id, first_name, second_name, department_id, birthday_dt, employment_dt)
VALUES
    (3, 'Zmei', 'Gorinich', 3, TO_DATE('1989-06-01', 'yyyy-mm-dd'), NULL);
INSERT INTO employees
    (employee_id, first_name, second_name, department_id, birthday_dt, employment_dt)
VALUES
    (4, 'Ilya', 'Muromets', 4, TO_DATE('1990-06-01', 'yyyy-mm-dd'), NULL);
INSERT INTO employees
    (employee_id, first_name, second_name, department_id, birthday_dt, employment_dt)
VALUES
    (5, 'Alesha', 'Popovitch', 4, TO_DATE('1988-06-01', 'yyyy-mm-dd'), NULL);
INSERT INTO employees
    (employee_id, first_name, second_name, department_id, birthday_dt, employment_dt)
VALUES
    (6, 'Dobrynya', 'Nikititch', 4, TO_DATE('1987-06-01', 'yyyy-mm-dd'), NULL);
INSERT INTO employees
    (employee_id, first_name, second_name, department_id, birthday_dt, employment_dt)
VALUES
    (7, 'Alexey', 'Detrov', 1, TO_DATE('1986-06-01', 'yyyy-mm-dd'), NULL);


INSERT INTO delivery_prices
    (price_id, city_name, delivery_price_rub)
VALUES
    (1, 'Saint-Petersburg', 1000);
INSERT INTO delivery_prices
    (price_id, city_name, delivery_price_rub)
VALUES
    (2, 'Moscow', 2500);
INSERT INTO delivery_prices
    (price_id, city_name, delivery_price_rub)
VALUES
    (3, 'Novosibirsk', 4000);
INSERT INTO delivery_prices
    (price_id, city_name, delivery_price_rub)
VALUES
    (4, 'Yekaterinburg', 3500);
INSERT INTO delivery_prices
    (price_id, city_name, delivery_price_rub)
VALUES
    (5, 'Kazan', 3000);
INSERT INTO delivery_prices
    (price_id, city_name, delivery_price_rub)
VALUES
    (6, 'Sochi', 4500);
INSERT INTO delivery_prices
    (price_id, city_name, delivery_price_rub)
VALUES
    (7, 'Vladivostok', 10000);

INSERT INTO contragents
    (contragent_id, contragent_name, contragent_info)
VALUES
    (1, 'ITMO', 'ITMO University building');
INSERT INTO contragents
    (contragent_id, contragent_name, contragent_info)
VALUES
    (2, 'ITMO', 'ITMO University dormitory');
INSERT INTO contragents
    (contragent_id, contragent_name, contragent_info)
VALUES
    (3, 'SPSU', 'SPSU University building');
INSERT INTO contragents
    (contragent_id, contragent_name, contragent_info)
VALUES
    (4, 'SPSU', 'SPSU University dormitory');
INSERT INTO contragents
    (contragent_id, contragent_name, contragent_info)
VALUES
    (5, 'MSU', 'MSU University building');
INSERT INTO contragents
    (contragent_id, contragent_name, contragent_info)
VALUES
    (6, 'MSU', 'MSU University dormitory');

INSERT INTO clients
    (client_id, first_name, second_name, contragent_id)
VALUES
    (1, 'Vasya', 'Pupkin', 1);
INSERT INTO clients
    (client_id, first_name, second_name, contragent_id)
VALUES
    (2, 'Arseniy', 'Petrov', 1);
INSERT INTO clients
    (client_id, first_name, second_name, contragent_id)
VALUES
    (3, 'Anna', 'Pupkina', 2);
INSERT INTO clients
    (client_id, first_name, second_name, contragent_id)
VALUES
    (4, 'Nikolay', 'Vorobev', 3);
INSERT INTO clients
    (client_id, first_name, second_name, contragent_id)
VALUES
    (5, 'Kirill', 'Petrov', 4);
INSERT INTO clients
    (client_id, first_name, second_name, contragent_id)
VALUES
    (6, 'Alex', 'Detrov', 5);
INSERT INTO clients
    (client_id, first_name, second_name, contragent_id)
VALUES
    (7, 'Kate', 'Egorova', 6);

-- order_id, product_id, client_id, operator_employee_id, order_datetime,
-- quantity_in_order, city_name
INSERT INTO orders
    (order_id, product_id, client_id, employee_id,
    order_datetime, quantity_in_order, city_name)
VALUES
    (1, 2, 1, 1, TO_TIMESTAMP('2022-07-01', 'yyyy-mm-dd'),
    3, 'Saint-Petersburg');
INSERT INTO orders
    (order_id, product_id, client_id, employee_id,
    order_datetime, quantity_in_order, city_name)
VALUES
    (2, 2, 2, 2, TO_TIMESTAMP('2022-08-01', 'yyyy-mm-dd'),
    3, 'Moscow');
INSERT INTO orders
    (order_id, product_id, client_id, employee_id,
    order_datetime, quantity_in_order, city_name)
VALUES
    (3, 1, 1, 2, TO_TIMESTAMP('2022-09-01', 'yyyy-mm-dd'),
    3, 'Saint-Petersburg');
INSERT INTO orders
    (order_id, product_id, client_id, employee_id,
    order_datetime, quantity_in_order, city_name)
VALUES
    (3, 4, 1, 2, TO_TIMESTAMP('2022-09-01', 'yyyy-mm-dd'),
    2, 'Saint-Petersburg');
INSERT INTO orders
    (order_id, product_id, client_id, employee_id,
    order_datetime, quantity_in_order, city_name)
VALUES
    (4, 4, 1, 2, TO_TIMESTAMP('2022-09-02', 'yyyy-mm-dd'),
    2, 'Samara');
INSERT INTO orders
    (order_id, product_id, client_id, employee_id,
    order_datetime, quantity_in_order, city_name)
VALUES
    (5, 4, 2, 1, TO_TIMESTAMP('2022-09-05', 'yyyy-mm-dd'),
    3, 'Kazan');
