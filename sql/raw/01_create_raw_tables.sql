-- RAW TABLES FOR E-COMMERCE FUNNEL PROJECT

CREATE OR REPLACE TABLE RAW.USER_SESSIONS (
    user_id STRING,
    session_id STRING,
    session_start_ts TIMESTAMP,
    device_type STRING,
    traffic_source STRING,
    load_ts TIMESTAMP
);

CREATE OR REPLACE TABLE RAW.PAGE_VIEWS (
    session_id STRING,
    page_type STRING,
    page_view_ts TIMESTAMP,
    load_ts TIMESTAMP
);

CREATE OR REPLACE TABLE RAW.CART_EVENTS (
    user_id STRING,
    product_id STRING,
    event_type STRING,
    event_ts TIMESTAMP,
    load_ts TIMESTAMP
);

CREATE OR REPLACE TABLE RAW.ORDERS (
    order_id STRING,
    user_id STRING,
    order_ts TIMESTAMP,
    order_value NUMBER(10,2),
    order_status STRING,
    load_ts TIMESTAMP
);
