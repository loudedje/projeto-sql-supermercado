# 📊 Projeto de Análise de Vendas para Rede de Supermercados

Este repositório contém um projeto completo de modelagem de banco de dados e análise de dados de vendas para uma rede de supermercados fictícia, utilizando SQL e PostgreSQL. O objetivo é criar uma base de dados robusta para suportar um dashboard de vendas inteligentes e futuras análises de Machine Learning.

## 🚀 Tecnologias Utilizadas
* **Banco de Dados:** PostgreSQL
* **Linguagem:** SQL
* **Modelagem:** Draw.io (Diagrama Entidade-Relacionamento)

---

## 🏛️ Estrutura do Banco de Dados (Schema)

O banco de dados foi modelado utilizando um **Star Schema**, ideal para consultas analíticas (OLAP). A estrutura centraliza os eventos de venda (tabelas de fatos) e os contextualiza com informações descritivas (tabelas de dimensão).

![Diagrama do Banco de Dados](database-diagram/diagrama_banco_de_dados.png)

---

## 🛠️ Como Utilizar o Projeto

Para recriar este ambiente, siga os passos abaixo:

1.  **Crie o Banco de Dados e as Tabelas:**
    Execute o script `01_script_criacao_banco.sql` para criar o schema `analytics` e todas as tabelas.
    ```sql
    psql -U seu_usuario -d seu_banco -f sql-scripts/01_script_criacao_banco.sql
    ```

2.  **Povoar o Banco de Dados:**
    Execute o script `02_script_populacao_dados.sql` para inserir todos os dados fictícios de lojas, produtos, funcionários, clientes e vendas.
    ```sql
    psql -U seu_usuario -d seu_banco -f sql-scripts/02_script_populacao_dados.sql
    ```

---


#### 1. Qual o faturamento total da rede?
```sql
SELECT SUM(total_receipt_value) AS faturamento_total FROM analytics.sales_header;
