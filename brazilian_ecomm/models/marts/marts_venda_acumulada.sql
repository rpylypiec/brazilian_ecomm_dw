--sources
WITH sources_vendas AS (
    SELECT * FROM {{ ref('int_vendas_acumulado') }}
),

--regras de negócio
regras AS (
    SELECT 
        ano_pedido,
        mes_pedido,
        venda_financeira,
        venda_financeira_acumulada
    FROM sources_vendas
    ORDER BY ano_pedido, mes_pedido ASC
)

--querie final
SELECT * FROM regras