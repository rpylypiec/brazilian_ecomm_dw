--source
WITH
source AS (
     SELECT *
    FROM {{ source('brazilian_ecomm', 'raw_products') }}
),
--tratamentos
renamed AS (
    SELECT
        product_id AS produto_id,
        product_category_name AS categoria
    FROM source
)
--querie final
SELECT * FROM renamed