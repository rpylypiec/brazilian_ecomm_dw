--sources
WITH sources_vendas AS (
    SELECT * FROM {{ ref('int_vendas_ano') }}
),

--regras de negócio
regras AS (
    SELECT ano_pedido,
        venda_financeira,
        qtde_cupom,
        tkt_medio,
        venda_fisica,
        preco_medio,
        itens_por_cupom
    FROM sources_vendas
    ORDER BY ano_pedido ASC
)

--querie final
SELECT * FROM regras