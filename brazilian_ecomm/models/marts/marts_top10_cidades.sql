--sources
WITH sources_vendas AS (
    SELECT * FROM {{ ref('int_vendas_cidades') }}
),

--regras de negócio
regras AS (
    SELECT 
        estado,
        cidade,
        venda_financeira,
        qtde_cupom,
        tkt_medio,
        venda_fisica,
        preco_medio,
        itens_por_cupom
   FROM sources_vendas
   ORDER BY estado, cidade
   LIMIT 10
)

--querie final
SELECT * FROM regras