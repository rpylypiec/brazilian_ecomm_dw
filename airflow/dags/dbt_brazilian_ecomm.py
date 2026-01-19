from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime

default_args = {
    "owner": "raphael",
    "depends_on_past": False,
    "retries": 1,
}

with DAG(
    dag_id="dbt_brazilian_ecomm",
    default_args=default_args,
    description="Executa dbt build para o projeto Brazilian Ecomm DW",
    schedule_interval="@daily",
    start_date=datetime(2026, 1, 18),
    catchup=False,
    tags=["dbt", "analytics", "brazilian_ecomm"],
) as dag:

    dbt_build = BashOperator(
        task_id="dbt_build",
        bash_command="""
        export DBT_PROFILES_DIR=/home/airflow/.dbt
        cd /opt/airflow/brazilian_ecomm
        dbt build
        """
    )

    dbt_build
