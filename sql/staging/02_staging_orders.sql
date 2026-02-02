CREATE OR REPLACE TABLE STAGING.ORDERS AS
SELECT DISTINCT
    order_id,
    user_id,
    order_ts,
    order_value,
    LOWER(order_status) AS order_status
FROM RAW.ORDERS
WHERE order_id IS NOT NULL;
