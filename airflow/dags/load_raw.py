from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime

with DAG(
    dag_id="load_raw_brazilian_ecomm",
    start_date=datetime(2024, 1, 1),
    schedule_interval=None,
    catchup=False,
    tags=["raw", "etl", "brazilian_ecomm"],
) as dag:

    load_raw = BashOperator(
        task_id="load_csv_to_postgres",
        bash_command="python3 /opt/airflow/etl/load_csv_to_postgres.py"
    )
