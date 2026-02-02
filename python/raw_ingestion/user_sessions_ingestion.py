"""
Initial ingestion for RAW.USER_SESSIONS
Used only for bootstrapping sample data.
"""

import pandas as pd
from datetime import datetime
import uuid

def main(session):

    data = [
        ("user_1", f"sess_{uuid.uuid4()}", datetime(2024, 1, 1, 10, 0), "mobile", "organic"),
        ("user_2", f"sess_{uuid.uuid4()}", datetime(2024, 1, 1, 10, 5), "desktop", "ads"),
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
