from fastapi import FastAPI, HTTPException
import os
import psycopg2
from psycopg2.extras import RealDictCursor

app = FastAPI()

DB_HOST = os.getenv("DB_HOST")
DB_PORT = os.getenv("DB_PORT", "5432")
DB_NAME = os.getenv("DB_NAME")
DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")


def get_connection():
    return psycopg2.connect(
        host=DB_HOST,
        port=DB_PORT,
        dbname=DB_NAME,
        user=DB_USER,
        password=DB_PASSWORD,
        cursor_factory=RealDictCursor,
    )


@app.get("/hello")
def hello():
    try:
        conn = get_connection()
        cur = conn.cursor()
        cur.execute("SELECT message FROM greetings ORDER BY RANDOM() LIMIT 1;")
        result = cur.fetchone()
        cur.close()
        conn.close()
        if result:
            return {"message": result["message"]}
        else:
            return {"message": "Hello, world! (no messages in DB)"}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


# Basic health check endpoint
@app.get("/health")
def health():
    return {"status": "ok"}
