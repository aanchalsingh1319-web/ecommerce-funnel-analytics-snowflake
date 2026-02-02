"""
Initial ingestion for RAW.CART_EVENTS
"""

import pandas as pd
from datetime import datetime

def main(session):

    data = [
        ("user_1", "prod_101", "add_to_cart", datetime(2024, 1, 1, 10, 2)),
    ]

    df = pd.DataFrame(
        data,
        columns=["user_id", "product_id", "event_type", "event_ts"]
    )

    df["load_ts"] = datetime.now()

    sf_df = session.create_dataframe(df)
    sf_df.write.mode("append").save_as_table("RAW.CART_EVENTS")

    return sf_df
