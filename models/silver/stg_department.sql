
WITH dept AS (
    SELECT
        store::INT              AS store_id,
        dept::INT               AS dept_id,
        date::DATE              AS store_date,
        weekly_sales::FLOAT     AS weekly_sales,
        isholiday::BOOLEAN      AS is_holiday
    FROM {{ source('walmart_bronze', 'department_bronze') }}
)
SELECT * FROM dept
