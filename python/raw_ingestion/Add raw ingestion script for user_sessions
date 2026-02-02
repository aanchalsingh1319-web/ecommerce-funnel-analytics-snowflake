"""
Initial ingestion for RAW.PAGE_VIEWS
"""

import pandas as pd
from datetime import datetime

def main(session):

    data = [
        ("sess_101", "home", datetime(2024, 1, 1, 10, 0)),
        ("sess_101", "product", datetime(2024, 1, 1, 10, 1)),
    ]

    df = pd.DataFrame(
        data,
        columns=["session_id", "page_type", "page_view_ts"]
    )

    df["load_ts"] = datetime.now()

    sf_df = session.create_dataframe(df)
    sf_df.write.mode("append").save_as_table("RAW.PAGE_VIEWS")

    return sf_df
