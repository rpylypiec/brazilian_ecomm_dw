import pandas as pd
from pathlib import Path
from sqlalchemy import create_engine

# ===============================
# Configurações
# ===============================

CSV_FOLDER = Path("arquivos")
DB_CONFIG = {
    "user": "postgres",
    "password": "SUA_SENHA_AQUI",
    "host": "localhost",
    "port": 5432,
    "database": "brazilian_ecomm",
}
SCHEMA_NAME = "raw"
CSV_SEPARATOR = ","
CSV_HEADER = 0  # header=True no pandas é header=0

# ===============================
# Conexão com o PostgreSQL
# ===============================

engine = create_engine(
    f"postgresql+psycopg2://{DB_CONFIG['user']}:"
    f"{DB_CONFIG['password']}@{DB_CONFIG['host']}:"
    f"{DB_CONFIG['port']}/{DB_CONFIG['database']}"
)

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
            header=CSV_HEADER
        )

        # Padronização básica
        df.columns = df.columns.str.lower().str.replace(" ", "_")

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
