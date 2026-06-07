# Projeto de Análise de Vendas — Rede de Supermercados

Modelagem de banco de dados e análise de vendas para uma rede de supermercados fictícia, usando SQL e PostgreSQL. O objetivo é construir uma base analítica estruturada para suportar dashboards de vendas e futuras análises de Machine Learning.

## Tecnologias

- **Banco de dados:** PostgreSQL 13+
- **Linguagem:** SQL
- **Modelagem:** Draw.io (Diagrama Entidade-Relacionamento)

---

## Estrutura do Projeto

| Arquivo | Descrição |
|---|---|
| `script.sql` | DDL — criação do schema, tabelas e índices |
| `script_dados.sql` | DML — população de todas as tabelas com dados fictícios |
| `views.sql` | Views analíticas desnormalizadas para BI |
| `tarefas.sql` | 16 queries analíticas respondendo perguntas de negócio |
| `dashboard.drawio.png` | Diagrama Entidade-Relacionamento |

---

## Modelo de Dados

O banco utiliza o schema `analytics` e segue uma arquitetura inspirada em **esquema estrela**, adequada para queries de BI.

```
Suppliers ──┐
            ├── Products ──┐
Stores ─────┤              ├── Sales_Items ──┐
            ├── Employees ─┤                 ├── Sales_Header
Customers ──┘              └── Dim_Date ─────┘
```

### Tabelas

| Tabela | Registros | Descrição |
|---|---|---|
| `Stores` | 15 | Lojas da rede (cidade + bairro) |
| `Suppliers` | 30 | Fornecedores dos produtos |
| `Products` | 60 | Catálogo de produtos com preço e estoque |
| `Customers` | 50 | Clientes cadastrados |
| `Employees` | 49 | Funcionários por loja e região |
| `Dim_Date` | 1.096 | Dimensão de datas (2023–2025) com flag de feriado e fim de semana |
| `Sales_Header` | 50 | Cabeçalho das notas fiscais |
| `Sales_Items` | ~80 | Itens de cada nota fiscal |

> `Sales_Items` armazena `price_at_sale` — o preço no momento da compra — para preservar o histórico correto mesmo que o preço do produto mude futuramente.

### Views

| View | Descrição |
|---|---|
| `vw_vendas_completas` | Tabela fato desnormalizada com todas as dimensões — base para dashboards |
| `vw_desempenho_produtos` | Receita, unidades vendidas e status de estoque por produto |
| `vw_resumo_mensal` | Faturamento, ticket médio e clientes únicos por mês |

---

## Como Rodar

### Pré-requisitos

- PostgreSQL 13+
- `psql` ou qualquer cliente (DBeaver, pgAdmin, etc.)

### Passo a passo

```bash
# 1. Crie o banco de dados
createdb market

# 2. Crie o schema, tabelas e índices
psql -d market -f script.sql

# 3. Popule os dados
psql -d market -f script_dados.sql

# 4. Crie as views analíticas
psql -d market -f views.sql

# 5. Execute as análises
psql -d market -f tarefas.sql
```

---

## Perguntas de Negócio Respondidas

### Análises básicas
| # | Pergunta |
|---|---|
| 1 | Qual foi o faturamento total da rede? |
| 2 | Quais são os 5 produtos mais vendidos em valor? |
| 3 | Qual o faturamento por loja? |
| 4 | Qual a tendência de faturamento mensal? |
| 5 | Qual o ticket médio por loja? |
| 6 | Quais os 10 clientes que mais gastaram? |
| 7 | Qual o faturamento por categoria de produto? |
| 8 | Quais funcionários mais geraram vendas? |
| 9 | Vendas em fins de semana vs dias úteis — há diferença? |
| 10 | Quais produtos nunca foram vendidos? |

### Análises avançadas (window functions & CTEs)
| # | Técnica | Pergunta |
|---|---|---|
| 11 | `LAG()` | Qual o crescimento mês a mês (MoM)? |
| 12 | `SUM() OVER` | Qual o faturamento acumulado dentro do ano? |
| 13 | `RANK() OVER PARTITION BY` | Qual o produto campeão em cada categoria? |
| 14 | `NTILE()` + CTE | Segmentação RFM de clientes (Campeão / Fiel / Em risco / Inativo) |
| 15 | JOIN múltiplo | Quais fornecedores geram mais receita? |
| 16 | `HAVING` + `INTERVAL` | Quais produtos têm estoque crítico e ainda têm demanda ativa? |

---

## Próximos Passos

- [ ] Análise de cohort de clientes (retenção mês a mês)
- [ ] Integração com ferramenta de BI (Metabase / Power BI)
- [ ] Dataset expandido para viabilizar modelos de ML (previsão de demanda)
