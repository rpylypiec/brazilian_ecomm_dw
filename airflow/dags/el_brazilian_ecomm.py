from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime

with DAG(
    dag_id="el_brazilian_ecomm",
    start_date=datetime(2024, 1, 1),
    schedule_interval=None,
    catchup=False,
    tags=["etl", "brazilian_ecomm"]
) as dag:

    extract_load = BashOperator(
        task_id="extract_load_to_postgres",
        bash_command="""
        python /opt/airflow/etl/load_to_postgres.py
        """
    )

    extract_load
