-- 1. Ranking (RANK()) dos vendedores por faturamento dentro de cada estado.
-- Classifica os vendedores por receita gerada dentro de cada estado de sua localização.
WITH faturamento_vendedor_estado AS (
    SELECT 
        s.seller_state,
        s.seller_id,
        SUM(oi.price) AS faturamento_total
    FROM olist_sellers_dataset s
    JOIN olist_order_items_dataset oi ON s.seller_id = oi.seller_id
    JOIN olist_orders_dataset o ON oi.order_id = o.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY s.seller_state, s.seller_id
)
SELECT 
    seller_state,
    seller_id,
    faturamento_total,
    RANK() OVER (PARTITION BY seller_state ORDER BY faturamento_total DESC) AS rank_estado
FROM faturamento_vendedor_estado
ORDER BY seller_state, rank_estado;

-- 2. Faturamento mensal acumulado por vendedor.
-- Calcula o faturamento mensal de cada vendedor e o total acumulado ao longo do tempo.
WITH faturamento_mensal_vendedor AS (
    SELECT 
        oi.seller_id,
        DATE_TRUNC('month', o.order_purchase_timestamp)::DATE AS mes_ano,
        SUM(oi.price) AS faturamento_mes
    FROM olist_order_items_dataset oi
    JOIN olist_orders_dataset o ON oi.order_id = o.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY oi.seller_id, DATE_TRUNC('month', o.order_purchase_timestamp)
)
SELECT 
    seller_id,
    mes_ano,
    faturamento_mes,
    SUM(faturamento_mes) OVER (
        PARTITION BY seller_id 
        ORDER BY mes_ano 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS faturamento_acumulado
FROM faturamento_mensal_vendedor
ORDER BY seller_id, mes_ano;

-- 3. Percentual de participação de cada vendedor no faturamento total do seu estado.
-- Avalia a relevância individual de cada vendedor comparando seu faturamento com a soma total do estado.
WITH faturamento_vendedor AS (
    SELECT 
        s.seller_state,
        s.seller_id,
        SUM(oi.price) AS faturamento_vendedor
    FROM olist_sellers_dataset s
    JOIN olist_order_items_dataset oi ON s.seller_id = oi.seller_id
    JOIN olist_orders_dataset o ON oi.order_id = o.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY s.seller_state, s.seller_id
)
SELECT 
    seller_state,
    seller_id,
    faturamento_vendedor,
    SUM(faturamento_vendedor) OVER (PARTITION BY seller_state) AS faturamento_total_estado,
    ROUND(
        (faturamento_vendedor / SUM(faturamento_vendedor) OVER (PARTITION BY seller_state)) * 100, 
        2
    ) AS pct_participacao_estado
FROM faturamento_vendedor
ORDER BY seller_state, faturamento_vendedor DESC;

-- 4. Variação de faturamento de um mês para o outro por vendedor, usando LAG().
-- Compara o faturamento do mês atual do vendedor com o mês anterior para calcular a variação percentual.
WITH faturamento_mensal AS (
    SELECT 
        oi.seller_id,
        DATE_TRUNC('month', o.order_purchase_timestamp)::DATE AS mes_ano,
        SUM(oi.price) AS faturamento_atual
    FROM olist_order_items_dataset oi
    JOIN olist_orders_dataset o ON oi.order_id = o.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY oi.seller_id, DATE_TRUNC('month', o.order_purchase_timestamp)
),
faturamento_com_lag AS (
    SELECT 
        seller_id,
        mes_ano,
        faturamento_atual,
        LAG(faturamento_atual) OVER (PARTITION BY seller_id ORDER BY mes_ano) AS faturamento_anterior
    FROM faturamento_mensal
)
SELECT 
    seller_id,
    mes_ano,
    faturamento_atual,
    faturamento_anterior,
    ROUND(
        ((faturamento_atual - faturamento_anterior) / NULLIF(faturamento_anterior, 0)) * 100, 
        2
    ) AS variacao_percentual
FROM faturamento_com_lag
ORDER BY seller_id, mes_ano;
