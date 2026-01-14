{{
  config(
    materialized='incremental',
    incremental_strategy='append'
  )
}}

with src as (

  select
    store_id,
    store_date,
    temperature,
    fuel_price,
    markdown1,
    markdown2,
    markdown3,
    markdown4,
    markdown5,
    cpi,
    unemployment,
    is_holiday,

    dbt_valid_from as effective_from,
    dbt_valid_to   as effective_to,
    case
      when dbt_valid_to is null then true
      else false
    end as is_current,

    current_timestamp() as insert_date,
    current_timestamp() as update_date

  from WALMART_DB.SNAPSHOTS.walmart_fact_snapshot

  {% if is_incremental() %}
    where dbt_valid_from > (select max(effective_from) from {{ this }})
  {% endif %}

)

select * from src
