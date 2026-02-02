Create analytics folder and placeholder files:

-- ANALYTICS: CONVERSION METRICS
-- Derived from ANALYTICS.SESSION_FUNNEL

-- 1. Overall conversion rate
SELECT
    COUNT(*) AS total_sessions,
    SUM(placed_order) AS converted_sessions,
    ROUND(
        100.0 * SUM(placed_order) / COUNT(*),
        2
    ) AS conversion_rate_pct
FROM ANALYTICS.SESSION_FUNNEL;

-----------------------------------------------------

-- 2. Funnel step counts
SELECT
    COUNT(*) AS total_sessions,
    SUM(visited_home) AS home_sessions,
    SUM(visited_product) AS product_sessions,
    SUM(visited_cart) AS cart_sessions,
    SUM(reached_checkout) AS checkout_sessions,
    SUM(placed_order) AS order_sessions
FROM ANALYTICS.SESSION_FUNNEL;

-----------------------------------------------------

-- 3. Step-wise conversion rates
SELECT
    ROUND(100.0 * SUM(visited_product) / NULLIF(SUM(visited_home), 0), 2)
        AS home_to_product_pct,

    ROUND(100.0 * SUM(visited_cart) / NULLIF(SUM(visited_product), 0), 2)
        AS product_to_cart_pct,

    ROUND(100.0 * SUM(reached_checkout) / NULLIF(SUM(visited_cart), 0), 2)
        AS cart_to_checkout_pct,

    ROUND(100.0 * SUM(placed_order) / NULLIF(SUM(reached_checkout), 0), 2)
        AS checkout_to_order_pct
FROM ANALYTICS.SESSION_FUNNEL;

-----------------------------------------------------

-- 4. Conversion by device
SELECT
    device_type,
    COUNT(*) AS sessions,
    SUM(placed_order) AS conversions,
    ROUND(
        100.0 * SUM(placed_order) / COUNT(*),
        2
    ) AS conversion_rate_pct
FROM ANALYTICS.SESSION_FUNNEL
GROUP BY device_type
ORDER BY conversion_rate_pct DESC;

-----------------------------------------------------

-- 5. Conversion by traffic source
SELECT
    traffic_source,
    COUNT(*) AS sessions,
    SUM(placed_order) AS conversions,
    ROUND(
        100.0 * SUM(placed_order) / COUNT(*),
        2
    ) AS conversion_rate_pct
FROM ANALYTICS.SESSION_FUNNEL
GROUP BY traffic_source
ORDER BY conversion_rate_pct DESC;

-----------------------------------------------------

-- 6. Daily conversion trend
SELECT
    session_date,
    COUNT(*) AS sessions,
    SUM(placed_order) AS conversions,
    ROUND(
        100.0 * SUM(placed_order) / COUNT(*),
        2
    ) AS conversion_rate_pct
FROM ANALYTICS.SESSION_FUNNEL
GROUP BY session_date
ORDER BY session_date;
