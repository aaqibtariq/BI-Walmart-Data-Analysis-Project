{% snapshot walmart_fact_snapshot %}

{{
  config(
    target_database='WALMART_DB',
    target_schema='SNAPSHOTS',

    unique_key="store_id || '-' || dept_id || '-' || to_varchar(store_date)",

    strategy='check',
    check_cols=[
      'weekly_sales',
      'store_size',
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

with dept as (
  select
    store_id,
    dept_id,
    store_date,
    weekly_sales,
    is_holiday
  from {{ ref('stg_department') }}
),

facts as (
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
    unemployment
  from {{ ref('stg_facts') }}
),

stores as (
  select
    store_id,
    store_size
  from {{ ref('stg_stores') }}
)

select
  d.store_id,
  d.dept_id,
  d.store_date,
  s.store_size,
  d.weekly_sales,
  f.temperature,
  f.fuel_price,
  f.markdown1,
  f.markdown2,
  f.markdown3,
  f.markdown4,
  f.markdown5,
  f.cpi,
  f.unemployment,
  d.is_holiday
from dept d
left join facts f
  on d.store_id = f.store_id
 and d.store_date = f.store_date
left join stores s
  on d.store_id = s.store_id

{% endsnapshot %}
