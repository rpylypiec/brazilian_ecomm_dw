import pandas as pd
from pathlib import Path
from sqlalchemy import create_engine, text

print(">>> SCRIPT load_to_postgres INICIADO <<<")

# ===============================
# Configurações
# ===============================

CSV_FOLDER = Path("/opt/airflow/arquivos")

DB_CONFIG = {
    "user": "airflow",
    "password": "airflow",
    "host": "postgres",
    "port": 5432,
    "database": "brazilian_ecomm",
}

SCHEMA_NAME = "raw"
CSV_SEPARATOR = ","
CSV_HEADER = 0

# ===============================
# Conexão com o PostgreSQL
# ===============================

engine = create_engine(
    f"postgresql+psycopg2://{DB_CONFIG['user']}:"
    f"{DB_CONFIG['password']}@{DB_CONFIG['host']}:"
    f"{DB_CONFIG['port']}/{DB_CONFIG['database']}"
)

# ===============================
# Criação do schema (se não existir)
# ===============================

with engine.begin() as conn:
    conn.execute(text(f"CREATE SCHEMA IF NOT EXISTS {SCHEMA_NAME}"))

# ===============================
# Leitura e carga dos CSVs
# ===============================

def load_csv_files_to_postgres():
    csv_files = CSV_FOLDER.glob("*.csv")

    for csv_file in csv_files:
        table_name = csv_file.stem.lower()

        print(f"Iniciando carga do arquivo: {csv_file.name}")
        print(f"Tabela destino: {SCHEMA_NAME}.{table_name}")

        df = pd.read_csv(
            csv_file,
            sep=CSV_SEPARATOR,
            header=CSV_HEADER,
            engine="python",            # parsing mais tolerante
            quotechar='"',
            escapechar="\\",
            dtype=str,                  # evita inferência errada
            keep_default_na=False,      # não converte vazio em NaN automaticamente
            on_bad_lines="warn",        # loga linhas problemáticas
            encoding="utf-8"
        )

        # Padronização de colunas
        df.columns = (
            df.columns
            .str.lower()
            .str.strip()
            .str.replace(" ", "_")
        )

        # Escrita no Postgres
        df.to_sql(
            name=table_name,
            con=engine,
            schema=SCHEMA_NAME,
            if_exists="replace",
            index=False
        )

        print(f"Carga finalizada: {SCHEMA_NAME}.{table_name}\n")

# ===============================
# Execução
# ===============================

if __name__ == "__main__":
    load_csv_files_to_postgres()

print(">>> SCRIPT load_to_postgres FINALIZADO <<<")
