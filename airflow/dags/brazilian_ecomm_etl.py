from airflow import DAG
from airflow.operators.bash import BashOperator
from airflow.utils.dates import days_ago

DEFAULT_ARGS = {
    "owner": "airflow",
    "depends_on_past": False,
    "retries": 1,
}

with DAG(
    dag_id="brazilian_ecomm_pipeline",
    default_args=DEFAULT_ARGS,
    description="Pipeline Brazilian E-commerce: Raw → dbt",
    schedule_interval=None,   # execução manual (por enquanto)
    start_date=days_ago(1),
    catchup=False,
    tags=["dbt", "brazilian_ecomm"],
) as dag:

    # 1️⃣ Carga RAW
    load_raw_brazilian_ecomm = BashOperator(
        task_id="load_raw_brazilian_ecomm",
        bash_command="""
    echo "Iniciando carga RAW..."
    python3 /opt/airflow/etl/load_csv_to_postgres.py
    """,
    )

    # 2️⃣ dbt run
    dbt_brazilian_ecomm = BashOperator(
        task_id="dbt_brazilian_ecomm",
        bash_command="""
        cd /opt/airflow/brazilian_ecomm &&
        export DBT_PROFILES_DIR=/home/airflow/.dbt &&
        dbt run
        """,
    )

    # Orquestração
    load_raw_brazilian_ecomm >> dbt_brazilian_ecomm
