Create analytics folder and placeholder files:
  

-- ANALYTICS: SESSION LEVEL FUNNEL
-- One row per session with funnel stage flags

CREATE OR REPLACE TABLE ANALYTICS.SESSION_FUNNEL AS
SELECT
    us.user_id,
    us.session_id,
    DATE(us.session_start_ts) AS session_date,
    us.device_type,
    us.traffic_source,

    MAX(CASE WHEN pv.page_type = 'home' THEN 1 ELSE 0 END) AS visited_home,
    MAX(CASE WHEN pv.page_type = 'product' THEN 1 ELSE 0 END) AS visited_product,
    MAX(CASE WHEN pv.page_type = 'cart' THEN 1 ELSE 0 END) AS visited_cart,
    MAX(CASE WHEN pv.page_type = 'checkout' THEN 1 ELSE 0 END) AS reached_checkout,

    MAX(CASE WHEN o.order_id IS NOT NULL THEN 1 ELSE 0 END) AS placed_order

FROM STAGING.USER_SESSIONS us
LEFT JOIN STAGING.PAGE_VIEWS pv
    ON us.session_id = pv.session_id
LEFT JOIN STAGING.ORDERS o
    ON us.user_id = o.user_id

GROUP BY
    us.user_id,
    us.session_id,
    session_date,
    us.device_type,
    us.traffic_source;
