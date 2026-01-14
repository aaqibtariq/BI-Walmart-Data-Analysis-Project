

WITH stores AS (
    SELECT
        store::INT      AS store_id,
        type::STRING    AS store_type,
        size::INT       AS store_size
    FROM {{ source('walmart_bronze', 'stores_bronze') }}
)
SELECT * FROM stores
