{{
    config(
        materialized='incremental',
        incremental_strategy='merge',
        unique_key=['store_id','dept_id'],
        merge_exclude_columns=['insert_date']
    )
}}

with src as (

    select distinct
        d.store_id::int            as store_id,
        d.dept_id::int             as dept_id,
        s.store_type::varchar      as store_type,
        s.store_size::int          as store_size
    from {{ ref('stg_department') }} d
    join {{ ref('stg_stores') }} s
      on d.store_id = s.store_id

),

final as (

    select
        store_id,
        dept_id,
        store_type,
        store_size,

        {% if is_incremental() %}
            coalesce(t.insert_date, current_timestamp()) as insert_date,
        {% else %}
            current_timestamp() as insert_date,
        {% endif %}

        current_timestamp() as update_date

    from src
    {% if is_incremental() %}
    left join {{ this }} t
      on src.store_id = t.store_id
     and src.dept_id  = t.dept_id
    {% endif %}

)

select * from final
