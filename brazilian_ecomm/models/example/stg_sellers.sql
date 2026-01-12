--source
WITH
source AS (
     SELECT *
    FROM {{ source('brazilian_ecomm', 'raw_sellers') }}
),
--tratamentos
renamed AS (
    SELECT
        seller_id AS vendedor_id,
        seller_state AS estado,
        seller_city AS cidade
    FROM source
)
--querie final
SELECT * FROM renamed