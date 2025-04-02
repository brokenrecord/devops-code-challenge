import logging
import sys
from pathlib import Path

from main import get_connection

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

TBL_NAME = "greetings"
SQL_FILE = "init.sql"


def main() -> None:
    logging.info("Connecting to the database")
    conn = get_connection()
    with conn:
        cur = conn.cursor()
        # Keep things idempotent by checking if the table exists
        cur.execute(
            "select exists (select from pg_tables where tablename = %s)", [TBL_NAME]
        )
        if cur.fetchone()["exists"]:
            logging.info("Table already exists: '%s'", TBL_NAME)
            logging.info("Exiting")
            sys.exit(0)
        sql_path = Path(SQL_FILE)
        logging.info("Reading SQL commands from: '%s'", sql_path.absolute())
        sql_cmds = sql_path.read_text()
        logging.info("Executing SQL commands...")
        cur.execute(sql_cmds)
        logging.info("Provisioning successful")
    conn.close()


if __name__ == "__main__":
    main()
