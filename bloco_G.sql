-- Bloco G - Questão 1
-- Criar a view vw_pedidos_completos, consolidando pedido, cliente, itens, pagamento e vendedor, para servir de base a consultas analíticas futuras.

CREATE OR REPLACE VIEW vw_pedidos_completos AS
SELECT 
    o.order_id,
    o.order_status,
    o.order_purchase_timestamp,
    o.order_approved_at,
    o.order_delivered_carrier_date,
    o.order_delivered_customer_date,
    o.order_estimated_delivery_date,
    
    -- Informações do Cliente
    c.customer_id,
    c.customer_unique_id,
    c.customer_zip_code_prefix,
    c.customer_city,
    c.customer_state,
    
    -- Informações dos Itens do Pedido
    i.order_item_id,
    i.product_id,
    i.seller_id,
    i.shipping_limit_date,
    i.price,
    i.freight_value,
    
    -- Informações do Vendedor
    s.seller_zip_code_prefix,
    s.seller_city,
    s.seller_state,
    
    -- Informações de Pagamento (Agregadas por pedido/item)
    p.payment_type,
    p.payment_installments,
    p.payment_value

FROM olist_orders_dataset o
INNER JOIN olist_customers_dataset c 
    ON o.customer_id = c.customer_id
LEFT JOIN olist_order_items_dataset i 
    ON o.order_id = i.order_id
LEFT JOIN olist_sellers_dataset s 
    ON i.seller_id = s.seller_id
LEFT JOIN olist_order_payments_dataset p 
    ON o.order_id = p.order_id;



-- 2. Criar a function sp_relatorio_categoria(categoria, data_inicio, data_fim)
-- Retorna o faturamento total e o ticket médio de uma categoria de produto no período informado.
CREATE OR REPLACE FUNCTION sp_relatorio_categoria(
    p_categoria VARCHAR,
    p_data_inicio DATE,
    p_data_fim DATE
)
RETURNS TABLE (
    nome_categoria VARCHAR,
    faturamento_total NUMERIC,
    ticket_medio NUMERIC
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        pct.product_category_name_english AS nome_categoria,
        COALESCE(SUM(oi.price), 0)::NUMERIC AS faturamento_total,
        COALESCE(ROUND(AVG(oi.price), 2), 0)::NUMERIC AS ticket_medio
    FROM olist_order_items_dataset oi
    JOIN olist_orders_dataset o ON oi.order_id = o.order_id
    JOIN olist_products_dataset p ON oi.product_id = p.product_id
    JOIN product_category_name_translation pct ON p.product_category_name = pct.product_category_name
    WHERE pct.product_category_name_english = p_categoria
      AND o.order_purchase_timestamp::DATE BETWEEN p_data_inicio AND p_data_fim
    GROUP BY pct.product_category_name_english;
END;
$$ LANGUAGE plpgsql;

-- Exemplos de execução para testar a função:
-- SELECT * FROM sp_relatorio_categoria('health_beauty', '2017-01-01', '2017-12-31');
-- SELECT * FROM sp_relatorio_categoria('sports_leisure', '2018-01-01', '2018-06-30');
-- SELECT * FROM sp_relatorio_categoria('watches_gifts', '2017-07-01', '2017-12-31');
