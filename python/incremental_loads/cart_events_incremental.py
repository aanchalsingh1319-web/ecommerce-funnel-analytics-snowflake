"""
Incremental ingestion for RAW.CART_EVENTS
"""

import pandas as pd
from datetime import datetime, timedelta

def main(session):

    result = session.sql("""
        SELECT MAX(event_ts) AS max_ts
        FROM RAW.CART_EVENTS
    """).collect()

    last_loaded_ts = result[0]["MAX_TS"] or datetime(2024, 1, 1)

    data = [
        ("user_new", "prod_200", "add_to_cart", last_loaded_ts + timedelta(minutes=2)),
    ]

    df = pd.DataFrame(
        data,
        columns=["user_id", "product_id", "event_type", "event_ts"]
    )

    df["load_ts"] = datetime.now()

    sf_df = session.create_dataframe(df)
    sf_df.write.mode("append").save_as_table("RAW.CART_EVENTS")

    return sf_df
