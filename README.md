# BI-Walmart-Data-Analysis-Project

## 🎯 Objective

Analyze Walmart sales performance by building a **scalable analytics pipeline** using **AWS, Snowflake, and dbt**, following modern data engineering best practices.

---

## 📄 Abstract

This project implements an **end-to-end data pipeline** that ingests raw Walmart data from AWS, processes it in Snowflake using **layered data modeling (Bronze → Silver → Snapshot → Gold)**, and prepares **analytics-ready dimension and fact tables** using dbt.

The pipeline is designed for **scalability, data quality, and real-world analytics use cases**.

---


## 🏗️ End-to-End System Design – Walmart Business Intelligence & Analytics Platform

<p align="center">
  <img src="https://raw.githubusercontent.com/aaqibtariq/BI-Walmart-Data-Analysis-Project/main/images/Architecture.png" width="850"/>
</p>

---

## 🏗️ Architecture 

```text
AWS S3
  ↓
Snowflake (RAW / SILVER)
  ↓
dbt Transformations
  ├── Silver (Staging Models)
  ├── Snapshots (SCD Type 2)
  └── Gold (Dimensions & Fact Tables)
```
---

🔁 Data Flow (Implemented)

# 1️⃣ AWS → Snowflake

- Raw Walmart data uploaded to AWS S3

- Snowflake configured to ingest data into raw / staging schemas

- Data stored in Snowflake for transformation

# 2️⃣ Silver Layer (Staging Models)

Cleaned and standardized source data using dbt staging models

## Models created:

- stg_facts

- stg_stores

- stg_department

## Key transformations:

- Column renaming & type casting

- Deduplication

- Standardized naming conventions

- Base-level data validation

# 3️⃣ Snapshot Layer (SCD Type 2)

Implemented historical tracking using dbt snapshots

## Snapshot:

- walmart_fact_snapshot

## Purpose:

- Tracks changes to fact data over time

- Maintains dbt-managed validity fields

  - dbt_valid_from

  - dbt_valid_to

- Enables Slowly Changing Dimension Type 2 behavior

# 4️⃣ Gold Layer (Analytics-Ready Models)
## Dimensions

## walmart_date_dim (SCD Type 1)

- Date ID (YYYYMMDD)

- Date attributes

- Holiday flag

- Insert / Update timestamps

## walmart_store_dim (SCD Type 1)

- Store metadata

- One row per store (latest state only)

## Fact Table

## walmart_fact_table (SCD Type 2 via Snapshot)

- Incremental append strategy

- Historical versions preserved

- Tracks:

  - Effective dates

  - Current record flag

  - Insert / Update timestamps

# 🧪 Data Quality & Testing

Implemented dbt tests on Gold models:

- not_null tests on keys and critical columns

- unique and composite uniqueness tests

- relationships tests between:

  - Fact ↔ Date Dimension

  - Fact ↔ Store Dimension

-  All tests are passing successfully

# 🧰 Technology Stack

- Cloud Storage: AWS S3

- Data Warehouse: Snowflake

- Transformation Tool: dbt (incremental models & snapshots)

- Modeling Approach: Star Schema (Fact + Dimensions)

- Version Control: GitHub

# 💡 Key Engineering Concepts Demonstrated

- End-to-end ELT pipeline

- dbt incremental models

- SCD Type 1 vs SCD Type 2

- Snapshot-based history tracking

- Data quality testing

- Analytics-ready Gold layer design

