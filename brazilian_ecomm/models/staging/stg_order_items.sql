WITH source AS (
    SELECT *
    FROM {{ source('brazilian_ecomm', 'raw_order_items') }}
),

renamed AS (
    SELECT
        order_id AS cupom_id,
        CAST(order_item_id AS INTEGER) AS qtde_itens,
        product_id AS produto_id,
        seller_id AS vendedor_id,
        CAST(price AS NUMERIC) AS preco,
        CAST(freight_value AS NUMERIC) AS frete
    FROM source
)

SELECT *
FROM renamed
