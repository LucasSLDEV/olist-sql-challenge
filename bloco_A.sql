-- BLOCO A: SELECT BÁSICO

-- 1. Listar os 20 pedidos com status delivered mais recentes, ordenados pela data de entrega.
SELECT *
FROM olist_orders_dataset
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL
ORDER BY order_delivered_customer_date DESC
LIMIT 20;

-- 2. Listar todos os produtos de uma categoria específica (usando a tabela de tradução para filtrar pelo nome em português).
SELECT 
    p.product_id,
    p.product_category_name AS categoria_portugues,
    t.product_category_name_english AS categoria_ingles,
    p.product_weight_g,
    p.product_length_cm,
    p.product_height_cm,
    p.product_width_cm
FROM olist_products_dataset p
JOIN product_category_name_translation t 
  ON p.product_category_name = t.product_category_name
WHERE p.product_category_name = 'perfumaria';

-- 3. Listar os métodos de pagamento distintos utilizados na base (SELECT DISTINCT payment_type).
SELECT DISTINCT payment_type
FROM olist_order_payments_dataset;

-- 4. Listar os produtos com peso (product_weight_g) acima de 10kg, ordenados do mais pesado para o mais leve.
SELECT 
    product_id,
    product_category_name,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm
FROM olist_products_dataset
WHERE product_weight_g > 10000
ORDER BY product_weight_g DESC;

