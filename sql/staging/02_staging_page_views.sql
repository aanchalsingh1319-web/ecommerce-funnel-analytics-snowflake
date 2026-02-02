CREATE OR REPLACE TABLE STAGING.PAGE_VIEWS AS
SELECT DISTINCT
    session_id,
    LOWER(page_type) AS page_type,
    page_view_ts
FROM RAW.PAGE_VIEWS
WHERE session_id IS NOT NULL
  AND page_type IS NOT NULL;
