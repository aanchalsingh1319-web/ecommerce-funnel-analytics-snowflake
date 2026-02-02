"""
Initial ingestion for RAW.ORDERS
"""

import pandas as pd
from datetime import datetime

def main(session):

    data = [
        ("ord_1001", "user_1", datetime(2024, 1, 1, 10, 3), 999.00, "placed"),
    ]

    df = pd.DataFrame(
        data,
        columns=[
            "order_id",
            "user_id",
            "order_ts",
            "order_value",
            "order_status"
        ]
    )

    df["load_ts"] = datetime.now()

    sf_df = session.create_dataframe(df)
    sf_df.write.mode("append").save_as_table("RAW.ORDERS")

    return sf_df
