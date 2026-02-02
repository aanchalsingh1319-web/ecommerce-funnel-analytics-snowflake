"""
Incremental ingestion for RAW.USER_SESSIONS
Loads only sessions newer than the latest session_start_ts.
"""

import pandas as pd
from datetime import datetime, timedelta
import uuid

def main(session):

    result = session.sql("""
        SELECT MAX(session_start_ts) AS max_ts
        FROM RAW.USER_SESSIONS
    """).collect()

    last_loaded_ts = result[0]["MAX_TS"] or datetime(2024, 1, 1)

    data = [
        (
            f"user_{uuid.uuid4().hex[:4]}",
            f"sess_{uuid.uuid4()}",
            last_loaded_ts + timedelta(minutes=5),
            "mobile",
            "organic"
        )
    ]

    df = pd.DataFrame(
        data,
        columns=[
            "user_id",
            "session_id",
            "session_start_ts",
            "device_type",
            "traffic_source"
        ]
    )

    df["load_ts"] = datetime.now()

    sf_df = session.create_dataframe(df)
    sf_df.write.mode("append").save_as_table("RAW.USER_SESSIONS")

    return sf_df
