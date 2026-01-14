

BRONZE
│
├── raw_walmart_data
│
SILVER
│
├── stg_facts
├── stg_stores
├── stg_department
│
SNAPSHOT
│
├── walmart_fact_snapshot   (SCD-2)
│
GOLD
│
├── walmart_store_dim       (SCD-1)
├── walmart_date_dim
└── walmart_fact_table      (Append-only SCD-2 fact)
