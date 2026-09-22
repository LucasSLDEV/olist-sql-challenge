# Desafio SQL — E-Commerce Olist (GrowMarket)

Este repositório contém a resolução do **Desafio SQL** proposto pela **Growdev**. O objetivo do projeto é simular uma atuação real como Analista/Desenvolvedor de Dados na fictícia empresa **GrowMarket**, explorando e extraindo *insights* estratégicos de negócio a partir do *Olist Brazilian E-Commerce Public Dataset*.

---

## 📌 Visão Geral do Projeto

A partir de uma base contendo cerca de 100 mil pedidos reais (entre 2016 e 2018), foram elaboradas consultas em **SQL (PostgreSQL)** abrangendo desde a seleção básica de dados até técnicas avançadas como *Subqueries*, *CTEs*, *Views*, *Functions/Procedures* e *Window Functions*.

---

## 🚀 Tecnologias e Ferramentas Utilizadas

- **SGBD:** PostgreSQL (Local)
- **Cliente SQL:** DBeaver Community
- **Linguagem:** SQL (DQL - Data Query Language)
- **Controle de Versão:** Git & GitHub

---

## 📁 Estrutura do Repositório

O repositório está organizado em scripts SQL separados conforme os blocos de requisitos do desafio:

```text
.
├── bloco_A.sql   # SELECT básico (ORDER BY, DISTINCT, WHERE)
├── bloco_B.sql   # JOINS (INNER, LEFT JOIN, múltiplas tabelas)
├── bloco_C.sql   # Funções Agregadas (GROUP BY, HAVING)
├── bloco_D.sql   # Subqueries (Correlacionadas, NOT EXISTS, COUNT DISTINCT)
├── bloco_E.sql   # CASE WHEN (Categorizações, prazos, faixas)
├── bloco_F.sql   # CTEs e Tabelas Temporárias (Variação %, métricas acumuladas)
├── bloco_G.sql   # Views (vw_pedidos_completos, vw_avaliacoes_categoria)
├── bloco_H.sql   # Procedures/Functions de Leitura (Parametrizadas)
├── bloco_I.sql   # Window Functions (RANK, SUM OVER, LAG)
└── README.md     # Documentação principal do repositório
💡 Principais Insights de Negócio
Durante a análise DQL desenvolvida nos blocos de scripts, destacam-se os seguintes achados estratégicos:

Concentração Geográfica de Faturamento: A maior parte do volume de vendas e faturamento está concentrada na região Sudeste, com o estado de São Paulo liderando as métricas de receita total e menor valor médio de frete.

Logística e Prazos de Entrega: O mapeamento via CASE WHEN identificou que a vasta maioria dos pedidos é entregue dentro ou antes do prazo estimado, registrando baixos índices de atrasos críticos.

Avaliação vs. Categorias: Através de CTEs e Views analíticas (vw_avaliacoes_categoria), identificou-se que categorias com alto volume de vendas nem sempre mantêm as melhores notas médias de satisfação, sinalizando oportunidades de melhoria no pós-venda.

Comportamento de Pagamento: O cartão de crédito desponta como o método preferencial de pagamento, havendo predominância de parcelamentos em vendas de categorias de maior ticket médio.

⚙️ Como Executar o Projeto
Pré-requisitos
PostgreSQL instalado e configurado localmente.

DBeaver Community (ou outro cliente SQL de sua preferência).

Dataset da Olist baixado no Kaggle.

Passo a Passo
Clonar o Repositório:

git clone [https://github.com/LucasSLDEV/olist-sql-challenge.git](https://github.com/LucasSLDEV/olist-sql-challenge.git)
cd olist-sql-challenge


Crie um banco de dados no PostgreSQL (ex: olist_db).

Importe os arquivos .csv do dataset via assistente de importação do DBeaver nas tabelas correspondentes (olist_customers_dataset, olist_orders_dataset, etc.).

Execução dos Scripts:

Abra os arquivos bloco_A.sql a bloco_I.sql no DBeaver conectado ao seu banco local e execute as consultas para verificar os resultados.

✉️ Contato e Links
Autor: Lucas S. L.

GitHub: LucasSLDEV

Plataforma Educacional: Growdev
