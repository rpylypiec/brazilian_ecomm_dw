--sources
WITH sources_vendas AS (
    SELECT * FROM {{ ref('int_vendas_categorias_cidades') }}
),

--regras de negócio
regras AS (
    SELECT 
        estado,
        cidade,
        SUM(venda_financeira) as venda_financeira,
        SUM(qtde_cupom) AS qtde_cupom,
        ROUND(SUM(venda_financeira) / SUM(qtde_cupom), 2) tkt_medio,
        SUM(venda_fisica) AS venda_fisica,
        ROUND(SUM(venda_financeira) / SUM(venda_fisica), 2) AS preco_medio,
        ROUND(SUM(venda_fisica) / SUM(qtde_cupom), 2) AS itens_por_cupom
   FROM sources_vendas
   WHERE categoria = 'beleza_saude'
   GROUP BY estado, cidade
   ORDER BY SUM(venda_financeira)
   LIMIT 10
)

--querie final
SELECT * FROM regras