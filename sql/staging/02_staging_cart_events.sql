CREATE OR REPLACE TABLE STAGING.CART_EVENTS AS
SELECT DISTINCT
    user_id,
    product_id,
    LOWER(event_type) AS event_type,
    event_ts
FROM RAW.CART_EVENTS
WHERE user_id IS NOT NULL;
