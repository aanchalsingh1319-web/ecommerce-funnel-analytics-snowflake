CREATE OR REPLACE TABLE STAGING.USER_SESSIONS AS
SELECT DISTINCT
    user_id,
    session_id,
    session_start_ts,
    LOWER(device_type) AS device_type,
    LOWER(traffic_source) AS traffic_source
FROM RAW.USER_SESSIONS
WHERE user_id IS NOT NULL
  AND session_id IS NOT NULL;
