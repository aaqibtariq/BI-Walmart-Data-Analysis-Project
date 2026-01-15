{{
  config(
    materialized='incremental',
    incremental_strategy='append'
  )
}}

with src as (

  select
    store_id,
    dept_id,

    -- Date_id FK
    to_number(to_char(store_date::date, 'YYYYMMDD')) as date_id,

    store_size,
    weekly_sales as store_weekly_sales,

    fuel_price,
    temperature,
    unemployment,
    cpi,
    markdown1,
    markdown2,
    markdown3,
    markdown4,
    markdown5,

    -- SCD2 versioning fields
    dbt_valid_from as vrsn_start_date,
    dbt_valid_to   as vrsn_end_date,

    current_timestamp() as insert_date,
    current_timestamp() as update_date

  from WALMART_DB.SNAPSHOTS.walmart_fact_snapshot

  {% if is_incremental() %}
    where dbt_valid_from > (select max(vrsn_start_date) from {{ this }})
  {% endif %}

)

select * from src
