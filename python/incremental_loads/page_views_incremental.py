"""
Incremental ingestion for RAW.PAGE_VIEWS
"""

import pandas as pd
from datetime import datetime, timedelta

def main(session):

    result = session.sql("""
        SELECT MAX(page_view_ts) AS max_ts
        FROM RAW.PAGE_VIEWS
    """).collect()

    last_loaded_ts = result[0]["MAX_TS"] or datetime(2024, 1, 1)

    data = [
        ("sess_new", "home", last_loaded_ts + timedelta(minutes=1)),
    ]

    df = pd.DataFrame(
        data,
        columns=["session_id", "page_type", "page_view_ts"]
    )

    df["load_ts"] = datetime.now()

    sf_df = session.create_dataframe(df)
    sf_df.write.mode("append").save_as_table("RAW.PAGE_VIEWS")

    return sf_df
