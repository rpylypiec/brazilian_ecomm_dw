--sources
WITH sources_categorias AS (
    SELECT * FROM {{ ref('int_vendas_categorias') }}
),

--regras de negócio
regras AS (
SELECT categoria,
    venda_financeira,
    qtde_cupom,
    tkt_medio,
    venda_fisica,
    preco_medio,
    itens_por_cupom
FROM sources_categorias
ORDER BY venda_financeira
LIMIT 10
)

--querie final
SELECT * FROM regras