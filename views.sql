CREATE OR REPLACE VIEW analytics.vw_vendas_completas AS
SELECT
    sh.sale_id,
    sh.sale_timestamp,
    dd.full_date,
    dd.year                                          AS ano,
    dd.month                                         AS mes,
    dd.day_of_week                                   AS dia_semana,
    dd.is_weekend                                    AS fim_de_semana,
    st.city                                          AS loja_cidade,
    st.neighborhood                                  AS loja_bairro,
    c.customer_id,
    c.first_name || ' ' || c.last_name               AS cliente,
    c.city                                           AS cliente_cidade,
    e.name                                           AS funcionario,
    e.region                                         AS regiao,
    p.product_id,
    p.name                                           AS produto,
    p.category                                       AS categoria,
    p.brand                                          AS marca,
    sup.name                                         AS fornecedor,
    si.quantity                                      AS quantidade,
    si.price_at_sale                                 AS preco_venda,
    si.total_item_value                              AS valor_item
FROM analytics.Sales_Header sh
JOIN analytics.Dim_Date     dd  ON sh.date_key    = dd.date_key
JOIN analytics.Stores       st  ON sh.store_id    = st.store_id
JOIN analytics.Customers    c   ON sh.customer_id = c.customer_id
JOIN analytics.Employees    e   ON sh.employee_id = e.employee_id
JOIN analytics.Sales_Items  si  ON sh.sale_id     = si.sale_id
JOIN analytics.Products     p   ON si.product_id  = p.product_id
LEFT JOIN analytics.Suppliers sup ON p.supplier_id = sup.supplier_id;


CREATE OR REPLACE VIEW analytics.vw_desempenho_produtos AS
SELECT
    p.product_id,
    p.name                                AS produto,
    p.category                            AS categoria,
    p.brand                               AS marca,
    p.price                               AS preco_atual,
    p.stock_quantity                      AS estoque_atual,
    COALESCE(SUM(si.quantity), 0)         AS unidades_vendidas,
    COALESCE(SUM(si.total_item_value), 0) AS receita_total,
    COUNT(DISTINCT si.sale_id)            AS num_pedidos,
    CASE
        WHEN SUM(si.quantity) IS NULL THEN 'Sem vendas'
        WHEN p.stock_quantity = 0    THEN 'Sem estoque'
        WHEN p.stock_quantity < 20   THEN 'Estoque crítico'
        ELSE 'Normal'
    END AS status_estoque
FROM analytics.Products p
LEFT JOIN analytics.Sales_Items si ON p.product_id = si.product_id
GROUP BY p.product_id, p.name, p.category, p.brand, p.price, p.stock_quantity;


CREATE OR REPLACE VIEW analytics.vw_resumo_mensal AS
SELECT
    dd.year                             AS ano,
    dd.month                            AS mes,
    TO_CHAR(dd.full_date, 'YYYY-MM')    AS ano_mes,
    COUNT(DISTINCT sh.sale_id)          AS total_vendas,
    COUNT(DISTINCT sh.customer_id)      AS clientes_unicos,
    SUM(sh.total_receipt_value)         AS faturamento,
    AVG(sh.total_receipt_value)         AS ticket_medio
FROM analytics.Sales_Header sh
JOIN analytics.Dim_Date dd ON sh.date_key = dd.date_key
GROUP BY dd.year, dd.month, TO_CHAR(dd.full_date, 'YYYY-MM');
