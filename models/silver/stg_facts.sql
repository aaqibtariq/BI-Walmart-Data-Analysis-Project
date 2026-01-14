

WITH facts AS (
    SELECT
        store::INT           AS store_id,
        date::DATE           AS store_date,
        temperature::FLOAT   AS temperature,
        fuel_price::FLOAT    AS fuel_price,
        markdown1::FLOAT     AS markdown1,
        markdown2::FLOAT     AS markdown2,
        markdown3::FLOAT     AS markdown3,
        markdown4::FLOAT     AS markdown4,
        markdown5::FLOAT     AS markdown5,
        cpi::FLOAT           AS cpi,
        unemployment::FLOAT  AS unemployment,
        isholiday::BOOLEAN   AS is_holiday
    FROM {{ source('walmart_bronze', 'facts_bronze') }}
)
SELECT * FROM facts
