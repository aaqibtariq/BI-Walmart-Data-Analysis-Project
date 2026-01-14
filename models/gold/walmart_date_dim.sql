{{
  config(
    materialized='incremental',
    incremental_strategy='merge',
    unique_key='DATE_ID',
    merge_exclude_columns=['INSERT_DATE']
  )
}}

with src as (

    select distinct
        store_date::date              as store_date,
        is_holiday::boolean           as isholiday
    from {{ ref('stg_facts') }}

),

dim as (

    select
        -- Date_id (PK) as an integer like 20260113
        to_number(to_char(store_date, 'YYYYMMDD')) as date_id,

        store_date                                 as date,
        isholiday,

        current_timestamp()                         as insert_date,
        current_timestamp()                         as update_date
    from src

    {% if is_incremental() %}
      where to_number(to_char(store_date, 'YYYYMMDD')) >
            (select coalesce(max(date_id), 19000101) from {{ this }})
    {% endif %}

)

select * from dim
