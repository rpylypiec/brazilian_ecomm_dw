# Brazilian E-commerce Data Warehouse

## 📌 Visão Geral
Este projeto tem como objetivo a construção de um **Data Warehouse de E-commerce**
a partir de arquivos CSV, utilizando uma arquitetura moderna de **ELT**.

O pipeline contempla desde a ingestão dos dados em um banco PostgreSQL até a
modelagem analítica com dbt e orquestração com Apache Airflow, com todo o código
versionado no GitHub.

---

## 🎯 Objetivo do Projeto
- Centralizar dados de e-commerce em um banco relacional
- Estruturar camadas de dados seguindo boas práticas (raw, staging e marts)
- Criar modelos analíticos prontos para consumo por ferramentas de BI
- Simular um pipeline de dados próximo a um ambiente real de produção

---

## 🏗️ Arquitetura do Pipeline

```text
Arquivos CSV
   ↓
Python (ETL)
   ↓
PostgreSQL
   ├── raw
   ├── staging
   └── marts
   ↓
dbt (transformações)
   ↓
Apache Airflow (orquestração)
