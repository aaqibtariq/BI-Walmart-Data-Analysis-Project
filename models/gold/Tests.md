# This is source file of all tests done in 

models/gold/gold_schema.yml

```sql
version: 2

models:
  - name: walmart_store_dim
    columns:
      - name: store_id
        tests: [not_null]
      - name: dept_id
        tests: [not_null]
    tests:
      - unique_combination:
          arguments:
            columns: ['store_id', 'dept_id']

  - name: walmart_fact_table
    description: "Gold fact history table built from dbt snapshot (append-only). Stores SCD2 versions using vrsn_start_date/vrsn_end_date."
    columns:
      - name: store_id
        description: "Store identifier"
        tests:
          - not_null

      - name: dept_id
        description: "Department identifier"
        tests:
          - not_null

      - name: date_id
        description: "Date surrogate key in YYYYMMDD format (FK to walmart_date_dim.date_id)"
        tests:
          - not_null
          - relationships:
              arguments:
                to: ref('walmart_date_dim')
                field: date_id

      - name: vrsn_start_date
        description: "Version start timestamp (dbt_valid_from)"
        tests:
          - not_null

      - name: vrsn_end_date
        description: "Version end timestamp (dbt_valid_to). NULL means current version."

      - name: insert_date
        description: "When this row was inserted into Gold"
        tests:
          - not_null

      - name: update_date
        description: "When this row was last processed/loaded"
        tests:
          - not_null

    tests:
      # No duplicate versions for the same store+dept+date+version start
      - unique_combination:
          arguments:
            columns: ['store_id', 'dept_id', 'date_id', 'vrsn_start_date']
```

# Test 1

For No duplicate versions for the same store+dept+date+version start Test

```sql
    tests:
      # No duplicate versions for the same store+dept+date+version start
      - unique_combination:
          arguments:
            columns: ['store_id', 'dept_id', 'date_id', 'vrsn_start_date']
```

```sql
1) Pick one existing row
select *
from WALMART_DB.GOLD.walmart_fact_table
limit 1;
```

2) Insert it back (creates a duplicate)
```sql
insert into WALMART_DB.GOLD.walmart_fact_table
select *
from WALMART_DB.GOLD.walmart_fact_table
qualify row_number() over (order by vrsn_start_date) = 1;
```

3) Run the test (it should FAIL)

```sql
dbt test --select walmart_fact_table
```

5) Remove the duplicate (cleanup) Use a de-dupe delete (keep 1 row, delete extras):
```sql
delete from WALMART_DB.GOLD.walmart_fact_table
where (store_id, dept_id, date_id, vrsn_start_date, insert_date) in (
  select store_id, dept_id, date_id, vrsn_start_date, insert_date
  from (
    select *,
      row_number() over (
        partition by store_id, dept_id, date_id, vrsn_start_date
        order by insert_date
      ) as rn
    from WALMART_DB.GOLD.walmart_fact_table
  )
  where rn > 1
);
```

# Picture

I made some changes in fact and run test

<p align="center">
  <img src="images/Before_unique_combination_test.png" width="700"/>
</p>




I fixed those back again and tried

## 🏗 Architecture Diagram
![Before](images/Before_unique_combination_test.png.png)

<p align="center">
  <img src="images/after unique combination test.png" width="700"/>
</p>

