## 🚀 Pull Request (PR)

**Walmart Analytics dbt Pipeline: Silver, Snapshot, and Gold Models**

---

## 📌 Summary

This PR introduces an **end-to-end dbt data warehouse pipeline** for Walmart analytics, implementing a  
**Bronze → Silver → Snapshot → Gold** architecture with proper data modeling, Slowly Changing Dimensions (SCDs), and robust data quality validation.

The goal is to produce **analytics-ready fact and dimension tables** following best practices used in modern data platforms.

---

## 🏗️ What’s Included

### 🥈 Silver Layer

Cleaned and typed staging models:

- `stg_facts`
- `stg_stores`
- `stg_department`

Applied:
- Data type casting
- Grain enforcement
- Column-level and model-level tests
- Custom generic tests for **composite uniqueness**

---

### 📸 Snapshot Layer (SCD Type 2)

- `walmart_fact_snapshot`

Tracks historical changes in fact records using:
- `dbt_valid_from`
- `dbt_valid_to`

Enables:
- Time-travel analytics
- Audit-ready historical tracking

---

### 🥇 Gold Layer

#### Dimensions
- `walmart_date_dim`  
  - Calendar-based dimension derived from fact data

- `walmart_store_dim` *(SCD Type 1)*  
  - Maintains latest store attributes

#### Fact Table
- `walmart_fact_table` *(SCD Type 2 via snapshot)*  
  - Built incrementally using an **append strategy**
  - Preserves historical versions
  - Supports **point-in-time analysis**

---

## ✅ Data Quality & Testing

- `not_null` tests on all primary keys and critical fields
- `unique` and **composite uniqueness** tests
- `relationships` tests enforcing **fact ↔ dimension integrity**
- Gold-layer tests validating **analytics readiness**
