{% snapshot walmart_fact_snapshot %}

{{
  config(
    target_database='WALMART_DB',
    target_schema='SNAPSHOTS',
    unique_key="store_id || '-' || to_varchar(store_date)",

    strategy='check',
    check_cols=[
      'temperature',
      'fuel_price',
      'markdown1',
      'markdown2',
      'markdown3',
      'markdown4',
      'markdown5',
      'cpi',
      'unemployment',
      'is_holiday'
    ]
  )
}}

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
  is_holiday
from {{ ref('stg_facts') }}

{% endsnapshot %}
