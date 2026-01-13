# Create BRONZE tables (Raw ingestion)

Bronze = raw, no transformations, reproducible, auditable.

We’ll do this in three clean sub-steps:

Create tables

COPY data

Validate row counts

# Create BRONZE tables

Make sure context is still set (optional but safe):

```sql
USE ROLE ACCOUNTADMIN;
USE DATABASE WALMART_DB;
USE SCHEMA BRONZE;
```

# department_bronze
```sql
CREATE OR REPLACE TABLE department_bronze (
    store         INT,
    dept          INT,
    date          DATE,
    weekly_sales  FLOAT,
    isholiday     BOOLEAN
);
```

# stores_bronze
```sql
CREATE OR REPLACE TABLE stores_bronze (
    store INT,
    type  STRING,
    size  INT
);
```

#  features_bronze
```sql
CREATE OR REPLACE TABLE features_bronze (
    store        INT,
    date         DATE,
    temperature  FLOAT,
    fuel_price   FLOAT,
    markdown1    FLOAT,
    markdown2    FLOAT,
    markdown3    FLOAT,
    markdown4    FLOAT,
    markdown5    FLOAT,
    cpi          FLOAT,
    unemployment FLOAT,
    isholiday    BOOLEAN
);
```
