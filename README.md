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
├── bloco_h.sql   # Procedures/Functions de Leitura (Parametrizadas)
├── bloco_I.sql   # Window Functions (RANK, SUM OVER, LAG)
└── README.md     # Documentação principal do repositório

## 💡 Principais Insights de Negócio & Diagnóstico Estratégico

Através da análise exploratória avançada (DQL) realizada sobre os mais de 100 mil pedidos da base Olist, foram identificados gargalos operacionais e oportunidades estratégicas cruciais para a tomada de decisão:

### 1. Dominância Regional e Oportunidade Logística (Geografia vs. Frete)
* Achado:** A região Sudeste (com protagonismo para o estado de São Paulo) concentra a maior parcela da receita total e do volume de vendas, beneficiando-se do menor custo médio de frete e prazos de entrega reduzidos.
* Impacto para o Negócio:** Regiões como Norte e Nordeste apresentam elevado valor de frete e maior tempo de trânsito, reduzindo a conversão.
* Recomendação Estratégica:** Implementar novos centros de distribuição (CDs) regionais ou parcerias de *fulfillment* nessas zonas para baratear o frete e expandir o mercado consumidor.

### 2. Desempenho Operacional vs. Percepção do Cliente (Prazos de Entrega)
* Achado:** O mapeamento condicional (*CASE WHEN*) revelou que mais de 85% das entregas são efetuadas antes do prazo estimado.
* Impacto para o Negócio:** Prazos estimados superdimensionados aumentam a margem de segurança logística, mas causam perda de vendas na etapa de *checkout* devido à expectativa de demora.
* Recomendação Estratégica:** Recalibrar a regra de cálculo da data estimada (*ETD*) no sistema para tornar as estimativas mais realistas, aumentando a taxa de conversão sem comprometer a satisfação do cliente.

### 3. Matriz de Satisfação e Volume (Trade-off de Categorias)
* Achado:** A análise cruzada de Views analíticas e CTEs demonstrou que as categorias líder de faturamento (ex: *Móveis/Decoração* e *Cama, Mesa e Banho*) apresentam notas médias de avaliação (*review_score*) inferiores a categorias de menor volume.
* Impacto para o Negócio:** Alto volume de vendas acompanhado de avaliações medianas indica gargalos pós-venda (como avarias no transporte, embalagem inadequada ou atrasos pontuais), o que afeta o *Lifetime Value* (LTV).
* Recomendação Estratégica:** Priorizar auditorias de qualidade e acompanhamento rigoroso de SLAs junto aos *sellers* dessas categorias de alto volume.

### 4. Alavancagem Financeira e Meios de Pagamento
* Achado:** O cartão de crédito sobressai-se como o meio de pagamento preferencial, registrando a maior média de parcelas nas categorias de elevado *ticket médio* (ex: *Relógios e Presentes*, *Eletrodomésticos*).
* **Impacto para o Negócio:** O parcelamento é o principal viabilizador de vendas para produtos de maior valor na plataforma.
*  Recomendação Estratégica:** Firmar parcerias com operadoras financeiras para oferecer campanhas de parcelamento sem juros direcionadas a produtos de alto valor acumulado.

## ⚙️ Como Executar o Projeto

### Pré-requisitos
* PostgreSQL instalado e configurado localmente.
* DBeaver Community (ou outro cliente SQL de sua preferência).
* Dataset da Olist baixado no Kaggle.

### Passo a Passo

1. **Clonar o Repositório:**
```bash
git clone [[https://github.com/LucasSLDEV/olist-sql-challenge.git)
cd olist-sql-challenge
```

2. **Carga dos Dados:**
* Crie um banco de dados no PostgreSQL (ex: `olist_db`).
* Importe os arquivos `.csv` do dataset via assistente de importação do DBeaver nas tabelas correspondentes (`olist_customers_dataset`, `olist_orders_dataset`, etc.).

3. **Execução dos Scripts:**
* Abra os arquivos `bloco_A.sql` a `bloco_I.sql` no DBeaver conectado ao seu banco local e execute as consultas para verificar os resultados.

---

## ✉️ Contato e Links

* **Autor:** Lucas S. L.
* **GitHub:** [@LucasSLDEV](https://github.com/LucasSLDEV)
* **Plataforma Educacional:** Growdev
