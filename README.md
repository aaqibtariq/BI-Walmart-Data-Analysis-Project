# BI-Walmart-Data-Analysis-Project

## 🎯 Objective

Analyze Walmart sales performance by building a **scalable analytics pipeline** using **AWS, Snowflake, and dbt**, following modern data engineering best practices.

---

## 📄 Abstract

This project implements an **end-to-end data pipeline** that ingests raw Walmart data from AWS, processes it in Snowflake using **layered data modeling (Bronze → Silver → Snapshot → Gold)**, and prepares **analytics-ready dimension and fact tables** using dbt.

The pipeline is designed for **scalability, data quality, and real-world analytics use cases**.

---


# Architecture

<p align="center">
  <img src="images/System Design.png" width="700"/>
</p>


---

## 🏗️ Architecture (What’s Built So Far)

```text
AWS S3
  ↓
Snowflake (RAW / SILVER)
  ↓
dbt Transformations
  ├── Silver (Staging Models)
  ├── Snapshots (SCD Type 2)
  └── Gold (Dimensions & Fact Tables)

