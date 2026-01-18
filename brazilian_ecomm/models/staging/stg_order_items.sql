--source
WITH 
source AS (
    SELECT *
    FROM {{ source('brazilian_ecomm', 'raw_order_items') }}
),
--tratamentos
renamed AS (
    SELECT
        order_id AS cupom_id,
        order_item_id AS qtde_itens,
        product_id AS produto_id,
        seller_id AS vendedor_id,
        CAST(price AS NUMERIC) AS preco,
        CAST(freight_value AS NUMERIC) AS frete
    FROM source
)
--querie final
SELECT * FROM renamed