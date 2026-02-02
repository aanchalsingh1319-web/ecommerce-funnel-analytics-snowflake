"""
Incremental ingestion for RAW.ORDERS
"""

import pandas as pd
from datetime import datetime, timedelta
import uuid

def main(session):

    result = session.sql("""
        SELECT MAX(order_ts) AS max_ts
        FROM RAW.ORDERS
    """).collect()

    last_loaded_ts = result[0]["MAX_TS"] or datetime(2024, 1, 1)

    data = [
        (
            f"ord_{uuid.uuid4().hex[:6]}",
            "user_new",
            last_loaded_ts + timedelta(minutes=5),
            1299.00,
            "placed"
        )
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
