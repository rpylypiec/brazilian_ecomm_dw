--sources
WITH sources_orders AS (
    SELECT *
    FROM {{ ref('stg_orders') }}
),

sources_order_items AS (
    SELECT *
    FROM {{ ref('stg_order_items') }}
),

--regra de negócio: venda mensal
venda_mensal AS (
    SELECT
        EXTRACT(YEAR FROM o.data) AS ano_pedido,

        EXTRACT(MONTH FROM o.data) AS mes_pedido,

        ROUND(
            SUM(oi.preco * oi.qtde_itens),
            2
        ) AS venda_financeira

    FROM sources_orders o

    INNER JOIN sources_order_items oi
        ON o.cupom_id = oi.cupom_id

    GROUP BY
        EXTRACT(YEAR FROM o.data),

        EXTRACT(MONTH FROM o.data)
),

--regra de negócio: venda acumulada
venda_acumulada AS (
    SELECT
        ano_pedido,

        mes_pedido,

        venda_financeira,

        SUM(venda_financeira) OVER (
            PARTITION BY ano_pedido
            ORDER BY mes_pedido
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS venda_financeira_acumulada
    FROM venda_mensal
)

--querie final
SELECT *
FROM venda_acumulada
