--sources
WITH sources_order_items AS (
    SELECT * FROM {{ ref('stg_order_items') }}
),
sources_products AS (
    SELECT * FROM {{ ref('stg_products') }}
),
--regras de negócio
regras AS (
    SELECT
        p.categoria,
        ROUND(
            SUM(oi.preco * oi.qtde_itens), 
            2
        ) AS venda_financeira,

        COUNT(oi.cupom_id) AS qtde_cupom,
        
        ROUND(
            SUM(oi.preco * oi.qtde_itens)
            / NULLIF(COUNT(oi.cupom_id), 0),
            2
        ) AS tkt_medio,

        SUM(oi.qtde_itens) AS venda_fisica,

	    ROUND(
            SUM(oi.preco * oi.qtde_itens)
            / NULLIF(SUM(oi.qtde_itens), 0),
            2
        ) AS preco_medio,

        ROUND(
            SUM(oi.qtde_itens)::NUMERIC
            / NULLIF(COUNT(oi.cupom_id), 0),
            2
        ) AS itens_por_cupom
        
    FROM sources_order_items oi

    INNER JOIN sources_products p 
        ON oi.produto_id = p.produto_id
    
    GROUP BY p.categoria
)
--querie final
SELECT * FROM regras