-- Студент: Булыгин Максим Евгеньевич

-- Вариант: 7
-- Описание варианта: https://docs.google.com/document/d/1FpwtYz5XTJCBUSjpuVzUX0RoZzt9HxNGQ1b9agug2HQ/edit
-- Название схемы: WKSP_CONFECTIONARYSHOP

-- 1) Сколько тортов было заказано?
-- Answer: 9
SELECT
    SUM(amount) AS total_cake_orders
FROM
    WKSP_CONFECTIONARYSHOP.items_in_order;

-- 2) У какого магазина номер 3?
-- Тут я считаю, что под тем, какой магазин, понимается строка соответствующая этому магазину
SELECT
    *
FROM
    WKSP_CONFECTIONARYSHOP.shop
WHERE
    store_number = 3;

-- 3) Когда был создан заказ 2?
-- Answer: 06/08/2022
SELECT
    date_create
FROM
    WKSP_CONFECTIONARYSHOP.order_from_shop
WHERE
    order_number = 2;

-- 4) Какой артикул у вишневого торта?
-- Answer: 0000235
SELECT
    vendor_code
FROM
    WKSP_CONFECTIONARYSHOP.possible_products
WHERE
    taste = 'Cherry';

-- 5) Сколько товаров в 1 заказе?
-- Answer: 3
SELECT
    SUM(amount) AS total_items
FROM
    WKSP_CONFECTIONARYSHOP.items_in_order
WHERE
    order_number = 1;

-- 6) Какие есть вкусы тортов и пирожных?
-- Answer: Caramel, Chocolate, Vanilla
SELECT
    DISTINCT taste
FROM
    WKSP_CONFECTIONARYSHOP.possible_products;



-- Вариант: 9
-- Описание варианта: https://disk.yandex.ru/d/QnX3hLZA6OZ1Hw
-- Название схемы: WKSP_DARIABUSH

-- 1) Выбрать клиентов, у которых на счетах больше 30000 рублей
-- Тут и далее я считаю, что под клиентами понимаются строки соответствующие этим клиентам
SELECT
    *
FROM
    WKSP_DARIABUSH.clients
WHERE
    client_id IN (
        SELECT
            DISTINCT account_owner
        FROM
            WKSP_DARIABUSH.accounts
        WHERE
            currency = 'рубль'
            AND balance >= 30000
);

-- 2) Выбрать клиентов старше 50 лет
SELECT
    *
FROM
    WKSP_DARIABUSH.clients
WHERE
    MONTHS_BETWEEN(TRUNC(SYSDATE), birthday) / 12 >= 50;

-- 3) Выбрать клиентов, у которых счет в тенге
SELECT
    *
FROM
    WKSP_DARIABUSH.clients
WHERE
    client_id IN (
        SELECT
            DISTINCT account_owner
        FROM
            WKSP_DARIABUSH.accounts
        WHERE
            currency = 'тенге'
);

-- 4) Выбрать операции пополнения на сумму более 1000 рублей
-- Тут я считаю, что под операциями понимаются строки соответствующие этим операциям
SELECT
    *
FROM
    WKSP_DARIABUSH.operation_list
WHERE
    LOWER(operation_type) LIKE '%пополнение%'
    AND operation_sum >= 1000
    AND operation_acc IN (
        SELECT
            DISTINCT account_id
        FROM
            WKSP_DARIABUSH.accounts
        WHERE
            currency = 'рубль'
    );

-- 5) Выбрать клиентов, которые оплачивали мобильную связь
SELECT
    *
FROM
    WKSP_DARIABUSH.clients
WHERE
    client_id IN (
        SELECT
            DISTINCT account_owner
        FROM
            WKSP_DARIABUSH.accounts
        WHERE
            account_id IN (
                SELECT
                    DISTINCT operation_acc
                FROM
                    WKSP_DARIABUSH.operation_list
                WHERE
                    LOWER(operation_type) LIKE '%оплата мобильной связи%'
            )
    );

-- 6) Выбрать клиентов, которые совершали операции в 2022 году
SELECT
    *
FROM
    WKSP_DARIABUSH.clients
WHERE
    client_id IN (
        SELECT
            DISTINCT account_owner
        FROM
            WKSP_DARIABUSH.accounts
        WHERE
            account_id IN (
                SELECT
                    DISTINCT operation_acc
                FROM
                    WKSP_DARIABUSH.operation_list
                WHERE
                    EXTRACT(YEAR FROM operation_date) = 2022
            )
    );
