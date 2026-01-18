--sources
WITH sources_order_payments AS (
    SELECT * FROM {{ ref('stg_order_payments') }}
),
--regras de negócio
total_pagamentos AS (
    SELECT COUNT(*) as total
    FROM sources_order_payments
),
regras AS (
SELECT
    forma_pgto,
    COUNT(*) AS qtde_pgto,
    ROUND(
        (COUNT(*)::numeric / (SELECT total FROM total_pagamentos)) * 100, 
        2
    ) AS percentual
FROM sources_order_payments
GROUP BY forma_pgto
)
--querie final
SELECT * FROM regras