-- Task 2.1: calculate histogram
SELECT
    all_intervals.interval_number AS interval_number,
    NVL(calulated_intervals.amount, 0) AS amount
FROM (
    SELECT
        interval_number,
        COUNT(*) AS amount
    FROM (
        SELECT
            WIDTH_BUCKET(
                trade_turnover,
                min_trade_turnover,
                max_trade_turnover + 0.0001,
                100
            ) AS interval_number
        FROM (
            SELECT
                turnovers.*,
                MIN(trade_turnover) OVER () as min_trade_turnover,
                MAX(trade_turnover) OVER () as max_trade_turnover
            FROM (
                SELECT 
                    rts.*,
                    (c_open_ + c_high_ + c_low_ + c_close_) / 4 * c_vol_ AS trade_turnover
                FROM 
                    rts
            ) turnovers
        )
    )
    GROUP BY
        interval_number
) calulated_intervals
RIGHT OUTER JOIN (
    SELECT 
        LEVEL AS interval_number 
    FROM 
        dual 
    CONNECT BY 
        LEVEL <= 100
) all_intervals
ON 
    calulated_intervals.interval_number = all_intervals.interval_number
ORDER BY
    interval_number;

-- Task 2.2: calculate aggregates for boxplot
SELECT
    trade_hour,
    AVG(trade_turnover) AS avg_trade_turnover,
    PERCENTILE_CONT(0.00) WITHIN GROUP (ORDER BY trade_turnover) AS p00_trade_turnover,
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY trade_turnover) AS p25_trade_turnover,
    PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY trade_turnover) AS p50_trade_turnover,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY trade_turnover) AS p75_trade_turnover,
    PERCENTILE_CONT(1.00) WITHIN GROUP (ORDER BY trade_turnover) AS p100_trade_turnover
FROM (
    SELECT
        (c_open_ + c_high_ + c_low_ + c_close_) / 4 * c_vol_ AS trade_turnover,
        EXTRACT(
            HOUR FROM 
            TO_TIMESTAMP(
                c_date_ || ' ' || c_time_, 
                'DD/MM/YY HH24:MI:SS'
            )
        ) AS trade_hour
    FROM 
        rts
)
GROUP BY
    trade_hour;

