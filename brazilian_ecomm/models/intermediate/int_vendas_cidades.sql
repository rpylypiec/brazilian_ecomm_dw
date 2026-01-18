--sources
WITH sources_order_items AS (
    SELECT * FROM {{ ref('stg_order_items') }}
),
sources_sellers AS (
    SELECT * FROM {{ ref('stg_sellers') }}
),
--regras de negócio
regras AS (
    SELECT
        
        s.estado,

        s.cidade,
        
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

    INNER JOIN sources_sellers s
        ON oi.vendedor_id = s.estado
    
    GROUP BY s.estado, s.cidade
)
--querie final
SELECT * FROM regras