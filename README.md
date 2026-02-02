# E-commerce Funnel Analytics using Snowflake, Python & SQL

## Overview
This project demonstrates an end-to-end ELT (Extract, Load, Transform) analytics pipeline built using **Python (Snowpark)**, **Snowflake**, and **SQL** to analyze user behavior and conversion funnels for an e-commerce platform.

The goal of this project is to model raw event-level data into a **session-level conversion funnel** and derive actionable **conversion metrics** across devices, traffic sources, and time.

This project closely reflects real-world analytics engineering workflows.

---

## Tech Stack
- **Snowflake** – Cloud Data Warehouse
- **Python (Snowpark)** – Data ingestion & incremental loading
- **SQL** – Transformations & analytics
- **GitHub** – Version control & documentation

---

## Architecture

Python (Snowpark)
↓
RAW Layer (Snowflake)
↓
STAGING Layer (SQL)
↓
ANALYTICS Layer (Session Funnel & Metrics)


---

## Data Layers

### RAW Layer
Raw, event-level data ingested using **Python Snowpark**.

Tables:
- `RAW.USER_SESSIONS`
- `RAW.PAGE_VIEWS`
- `RAW.CART_EVENTS`
- `RAW.ORDERS`

Features:
- Python-based ingestion
- Incremental loading using timestamp checkpoints
- Load timestamps for auditability

---

### STAGING Layer
Cleaned and standardized datasets created using SQL.

Transformations include:
- Deduplication
- Null filtering
- Data standardization (lowercasing categorical fields)

Tables:
- `STAGING.USER_SESSIONS`
- `STAGING.PAGE_VIEWS`
- `STAGING.CART_EVENTS`
- `STAGING.ORDERS`

---

### ANALYTICS Layer
Business-ready analytical tables derived from STAGING data.

#### Session Funnel
- `ANALYTICS.SESSION_FUNNEL`
- One row per session
- Funnel stage flags:
  - visited_home
  - visited_product
  - visited_cart
  - reached_checkout
  - placed_order

---

## Key Analytics & Metrics

The project answers key business questions such as:

- What percentage of sessions convert?
- Where do users drop off in the funnel?
- How does conversion vary by:
  - Device type
  - Traffic source
  - Date
- Step-wise funnel conversion rates

All metrics are derived directly from the `SESSION_FUNNEL` table.

---

## Python Ingestion Highlights
- Used **Snowflake Python Worksheets (Snowpark)**
- Separate scripts for:
  - Initial RAW ingestion
  - Incremental loads using `MAX(timestamp)`
- Safe to re-run without duplicating data
- Clear separation between bootstrap and production logic

---

## Repository Structure

sql/
├── raw/
├── staging/
└── analytics/

python/
├── raw_ingestion/
└── incremental_loads/

docs/


---

## Why This Project Matters
This project demonstrates:
- Practical ELT design using Snowflake
- Real-world incremental data ingestion patterns
- Strong understanding of data modeling & grain
- Ability to translate raw data into business insights

---

## Author
**Aanchal Singh**  
Senior Data Analyst | Python | SQL | Snowflake
