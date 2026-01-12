--source
WITH
source AS (
     SELECT *
    FROM {{ source('brazilian_ecomm', 'raw_order_payments') }}
),
--tratamentos
renamed AS (
    SELECT
        order_id AS cupom_id,
        payment_type AS forma_pgto
    FROM source
)
--querie final
SELECT * FROM renamed