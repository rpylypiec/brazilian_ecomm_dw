FROM apache/airflow:2.7.3

# =========================
# 1. Instalar dependências de SO
# =========================
USER root

RUN apt-get update && apt-get install -y \
    git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# =========================
# 2. Voltar para usuário airflow
# =========================
USER airflow

# =========================
# 3. Instalar dbt (como airflow)
# =========================
RUN pip install --upgrade pip && \
    pip install dbt-core==1.8.7 dbt-postgres==1.8.2

# =========================
# 4. Diretório de trabalho
# =========================
WORKDIR /opt/airflow
