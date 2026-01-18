--source
WITH
source AS (
     SELECT *
    FROM {{ source('brazilian_ecomm', 'raw_orders') }}
),
--tratamentos
renamed AS (
    SELECT
        order_id AS cupom_id,
        CAST(order_purchase_timestamp AS DATE) AS data
    FROM source
)
--querie final
SELECT * FROM renamed