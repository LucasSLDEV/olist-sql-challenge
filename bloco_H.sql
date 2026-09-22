-- 1. Criar a function sp_relatorio_vendedor(id_vendedor, data_inicio, data_fim)
-- Retorna o faturamento, ticket médio e nota média de avaliação de um vendedor num período específico.
CREATE OR REPLACE FUNCTION sp_relatorio_vendedor(
    p_id_vendedor VARCHAR,
    p_data_inicio DATE,
    p_data_fim DATE
)
RETURNS TABLE (
    vendedor_id VARCHAR,
    faturamento_total NUMERIC,
    ticket_medio NUMERIC,
    nota_media_avaliacao NUMERIC
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        oi.seller_id,
        COALESCE(SUM(oi.price), 0)::NUMERIC AS faturamento_total,
        COALESCE(ROUND(AVG(oi.price), 2), 0)::NUMERIC AS ticket_medio,
        COALESCE(ROUND(AVG(r.review_score), 2), 0)::NUMERIC AS nota_media_avaliacao
    FROM olist_order_items_dataset oi
    JOIN olist_orders_dataset o ON oi.order_id = o.order_id
    LEFT JOIN olist_order_reviews_dataset r ON o.order_id = r.order_id
    WHERE oi.seller_id = p_id_vendedor
      AND o.order_purchase_timestamp::DATE BETWEEN p_data_inicio AND p_data_fim
    GROUP BY oi.seller_id;
END;
$$ LANGUAGE plpgsql;

-- Exemplo de execução para testar a função:
-- SELECT * FROM sp_relatorio_vendedor('3504c0ca73d2fa4f06816850c392304e', '2017-01-01', '2018-01-01');


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

select * from sp_relatorio_categoria('health_beauty', '2017-01-01', '2018-01-01');
-- Exemplo de execução para testar a função:
SELECT * FROM sp_relatorio_categoria('sports_leisure', '2018-01-01', '2018-06-30');

SELECT * FROM sp_relatorio_categoria('watches_gifts', '2017-07-01', '2017-12-31');
