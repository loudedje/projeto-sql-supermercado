SELECT * FROM analytics.sales_header LIMIT 10;
SELECT * FROM analytics.products LIMIT 10;
SELECT * FROM analytics.sales_items LIMIT 10;
SELECT * FROM analytics.stores;


SELECT
    TO_CHAR(SUM(total_receipt_value), 'L9G999G999D99') AS faturamento_total
FROM
    analytics.sales_header;


SELECT
    p.name AS nome_produto,
    SUM(si.total_item_value) AS total_vendido
FROM
    analytics.products p
JOIN
    analytics.sales_items si ON p.product_id = si.product_id
GROUP BY
    p.name
ORDER BY
    total_vendido DESC
LIMIT 5;


SELECT
    s.city                                                 AS cidade,
    s.neighborhood                                         AS bairro,
    COUNT(sh.sale_id)                                      AS total_vendas,
    TO_CHAR(SUM(sh.total_receipt_value), 'L9G999G999D99')  AS faturamento
FROM
    analytics.stores s
JOIN
    analytics.sales_header sh ON s.store_id = sh.store_id
GROUP BY
    s.store_id, s.city, s.neighborhood
ORDER BY
    SUM(sh.total_receipt_value) DESC;


SELECT
    dd.year                                                AS ano,
    dd.month                                               AS mes,
    COUNT(sh.sale_id)                                      AS total_vendas,
    TO_CHAR(SUM(sh.total_receipt_value), 'L9G999G999D99')  AS faturamento_mensal
FROM
    analytics.sales_header sh
JOIN
    analytics.dim_date dd ON sh.date_key = dd.date_key
GROUP BY
    dd.year, dd.month
ORDER BY
    dd.year, dd.month;


SELECT
    s.city                                                 AS cidade,
    s.neighborhood                                         AS bairro,
    COUNT(sh.sale_id)                                      AS total_vendas,
    TO_CHAR(AVG(sh.total_receipt_value), 'L9G999D99')      AS ticket_medio
FROM
    analytics.stores s
JOIN
    analytics.sales_header sh ON s.store_id = sh.store_id
GROUP BY
    s.store_id, s.city, s.neighborhood
ORDER BY
    AVG(sh.total_receipt_value) DESC;


SELECT
    c.first_name || ' ' || c.last_name                     AS cliente,
    c.city                                                  AS cidade,
    COUNT(sh.sale_id)                                       AS total_compras,
    TO_CHAR(SUM(sh.total_receipt_value), 'L9G999G999D99')   AS total_gasto
FROM
    analytics.customers c
JOIN
    analytics.sales_header sh ON c.customer_id = sh.customer_id
GROUP BY
    c.customer_id, c.first_name, c.last_name, c.city
ORDER BY
    SUM(sh.total_receipt_value) DESC
LIMIT 10;


SELECT
    p.category                                             AS categoria,
    SUM(si.quantity)                                       AS unidades_vendidas,
    TO_CHAR(SUM(si.total_item_value), 'L9G999G999D99')     AS faturamento
FROM
    analytics.products p
JOIN
    analytics.sales_items si ON p.product_id = si.product_id
GROUP BY
    p.category
ORDER BY
    SUM(si.total_item_value) DESC;


SELECT
    e.name                                                 AS funcionario,
    e.region                                               AS regiao,
    COUNT(sh.sale_id)                                      AS total_atendimentos,
    TO_CHAR(SUM(sh.total_receipt_value), 'L9G999G999D99')  AS total_vendido
FROM
    analytics.employees e
JOIN
    analytics.sales_header sh ON e.employee_id = sh.employee_id
GROUP BY
    e.employee_id, e.name, e.region
ORDER BY
    SUM(sh.total_receipt_value) DESC
LIMIT 10;


SELECT
    CASE WHEN dd.is_weekend THEN 'Fim de Semana' ELSE 'Dia Útil' END AS tipo_dia,
    COUNT(sh.sale_id)                                                  AS total_vendas,
    TO_CHAR(SUM(sh.total_receipt_value), 'L9G999G999D99')              AS faturamento,
    TO_CHAR(AVG(sh.total_receipt_value), 'L9G999D99')                  AS ticket_medio
FROM
    analytics.sales_header sh
JOIN
    analytics.dim_date dd ON sh.date_key = dd.date_key
GROUP BY
    dd.is_weekend
ORDER BY
    dd.is_weekend;


SELECT
    p.product_id,
    p.name       AS produto,
    p.category   AS categoria,
    p.price      AS preco
FROM
    analytics.products p
LEFT JOIN
    analytics.sales_items si ON p.product_id = si.product_id
WHERE
    si.sale_item_id IS NULL
ORDER BY
    p.category, p.name;


SELECT
    ano_mes,
    faturamento,
    LAG(faturamento) OVER (ORDER BY ano_mes)                         AS faturamento_mes_anterior,
    faturamento - LAG(faturamento) OVER (ORDER BY ano_mes)           AS variacao_absoluta,
    ROUND(
        100.0 * (faturamento - LAG(faturamento) OVER (ORDER BY ano_mes))
              / NULLIF(LAG(faturamento) OVER (ORDER BY ano_mes), 0),
    2)                                                               AS variacao_pct
FROM analytics.vw_resumo_mensal
ORDER BY ano_mes;


SELECT
    ano,
    mes,
    TO_CHAR(faturamento, 'L9G999D99')                                AS faturamento_mes,
    TO_CHAR(
        SUM(faturamento) OVER (PARTITION BY ano ORDER BY mes),
        'L9G999G999D99'
    )                                                                AS acumulado_ano
FROM analytics.vw_resumo_mensal
ORDER BY ano, mes;


WITH ranking AS (
    SELECT
        categoria,
        produto,
        receita_total,
        RANK() OVER (PARTITION BY categoria ORDER BY receita_total DESC) AS posicao
    FROM analytics.vw_desempenho_produtos
    WHERE receita_total > 0
)
SELECT
    categoria,
    produto                                               AS produto_campiao,
    TO_CHAR(receita_total, 'L9G999D99')                   AS faturamento
FROM ranking
WHERE posicao = 1
ORDER BY receita_total DESC;


WITH metricas AS (
    SELECT
        c.customer_id,
        c.first_name || ' ' || c.last_name                           AS cliente,
        MAX(sh.sale_timestamp)::DATE                                  AS ultima_compra,
        CURRENT_DATE - MAX(sh.sale_timestamp)::DATE                   AS recencia_dias,
        COUNT(sh.sale_id)                                             AS frequencia,
        SUM(sh.total_receipt_value)                                   AS monetario
    FROM analytics.customers c
    JOIN analytics.sales_header sh ON c.customer_id = sh.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name
),
scores AS (
    SELECT
        *,
        NTILE(4) OVER (ORDER BY recencia_dias ASC)  AS r_score,
        NTILE(4) OVER (ORDER BY frequencia    DESC) AS f_score,
        NTILE(4) OVER (ORDER BY monetario     DESC) AS m_score
    FROM metricas
)
SELECT
    cliente,
    ultima_compra,
    recencia_dias,
    frequencia,
    TO_CHAR(monetario, 'L9G999D99')   AS monetario,
    r_score,
    f_score,
    m_score,
    r_score + f_score + m_score       AS rfm_total,
    CASE
        WHEN r_score + f_score + m_score >= 10 THEN 'Campeão'
        WHEN r_score + f_score + m_score >= 7  THEN 'Fiel'
        WHEN r_score + f_score + m_score >= 5  THEN 'Em risco'
        ELSE 'Inativo'
    END                               AS segmento
FROM scores
ORDER BY rfm_total DESC;


SELECT
    sup.name                                               AS fornecedor,
    COUNT(DISTINCT p.product_id)                           AS produtos_no_catalogo,
    SUM(si.quantity)                                       AS unidades_vendidas,
    TO_CHAR(SUM(si.total_item_value), 'L9G999G999D99')     AS receita_gerada
FROM analytics.suppliers sup
JOIN analytics.products  p  ON sup.supplier_id = p.supplier_id
LEFT JOIN analytics.sales_items si ON p.product_id = si.product_id
GROUP BY sup.supplier_id, sup.name
ORDER BY SUM(si.total_item_value) DESC NULLS LAST;


SELECT
    p.name                                                 AS produto,
    p.category                                             AS categoria,
    p.stock_quantity                                       AS estoque_atual,
    SUM(si.quantity)                                       AS vendido_total,
    MAX(sh.sale_timestamp)::DATE                           AS ultima_venda
FROM analytics.products p
JOIN analytics.sales_items  si ON p.product_id  = si.product_id
JOIN analytics.sales_header sh ON si.sale_id    = sh.sale_id
WHERE p.stock_quantity < 50
GROUP BY p.product_id, p.name, p.category, p.stock_quantity
HAVING MAX(sh.sale_timestamp) >= CURRENT_DATE - INTERVAL '6 months'
ORDER BY p.stock_quantity ASC;
