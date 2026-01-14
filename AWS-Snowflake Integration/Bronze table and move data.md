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

#  facts_bronze
```sql
CREATE OR REPLACE TABLE facts_bronze (
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

# Load data with COPY INTO

Load department.csv

```sql
COPY INTO department_bronze
FROM @walmart_raw_stage/department.csv
FILE_FORMAT = (FORMAT_NAME = walmart_csv_ff)
ON_ERROR = 'ABORT_STATEMENT';
```

Load stores.csv

```sql
COPY INTO stores_bronze
FROM @walmart_raw_stage/stores.csv
FILE_FORMAT = (FORMAT_NAME = walmart_csv_ff)
ON_ERROR = 'ABORT_STATEMENT';
```

Load fact.csv → facts_bronze

```sql
COPY INTO features_bronze
FROM @walmart_raw_stage/fact.csv
FILE_FORMAT = (FORMAT_NAME = walmart_csv_ff)
ON_ERROR = 'ABORT_STATEMENT';
```
# Validate row counts

```sql
SELECT COUNT(*) FROM department_bronze;
SELECT COUNT(*) FROM stores_bronze;
SELECT COUNT(*) FROM features_bronze;
```
