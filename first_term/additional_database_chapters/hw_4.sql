DROP TABLE restaurants;

CREATE TABLE restaurants (
    restaurant_id INTEGER,
    order_costs INTEGER,
    tip_share_of_receipt INTEGER,
    receipt_size INTEGER,
    order_dt DATE
);

BEGIN DBMS_RANDOM.seed (val => 54);
FOR loop_counter IN 1..10000 LOOP
INSERT INTO restaurants
    (restaurant_id, order_costs, tip_share_of_receipt, receipt_size, order_dt)
VALUES
    (
        CAST(dbms_random.value(1, 15) AS INTEGER),
        CAST(DBMS_RANDOM.normal * 100 + 600 AS INTEGER),
        CAST(dbms_random.value(1, 10) AS INTEGER),
        CAST((DBMS_RANDOM.normal * 200 + 1500) + (DBMS_RANDOM.normal * 100 + 4500) AS INTEGER),
        TO_DATE(
            TRUNC(
                DBMS_RANDOM.VALUE(
                    TO_CHAR(DATE '2022-09-01','J'),
                    TO_CHAR(DATE '2022-10-01','J')
                )
            ),
            'J'
        )
   );
END LOOP;
COMMIT;
END;
