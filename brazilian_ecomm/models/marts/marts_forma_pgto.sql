--sources
WITH sources_forma_pgto AS (
    SELECT * FROM {{ ref('int_forma_pagamento') }}
),

--regras de negócio
regras AS (
    SELECT 
        forma_pgto,
        qtde_pgto,
        percentual
    FROM sources_forma_pgto
    ORDER BY qtde_pgto ASC
)

--querie final
SELECT * FROM regras