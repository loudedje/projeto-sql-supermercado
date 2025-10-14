SELECT * FROM analytics.sales_header LIMIT 10;

SELECT * FROM analytics.products LIMIT 10;

SELECT * FROM analytics.sales_items LIMIT 10;

SELECT * FROM analytics.stores;


-- ====================================================================
-- TAREFA 1: Qual foi o faturamento total do supermercado?
-- ====================================================================

SELECT 
    TO_CHAR(SUM(total_receipt_value), 'L9G999G999D99') AS faturamento_total
FROM 
    analytics.sales_header;


-- ====================================================================
-- TAREFA 2: Quais são os 5 produtos mais vendidos (em valor)?
-- ====================================================================
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

