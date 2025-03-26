# 🧪 FastAPI App - Local Development & Testing

This is a simple FastAPI application that connects to a PostgreSQL database and returns a message from a table via the `/hello` endpoint.

It's intended to be deployed on AWS ECS and connect to an RDS instance, but it can also be tested locally using Docker Compose.

---

## 📁 Project Structure

```bash
app/
├── main.py              # FastAPI app
├── init.sql             # SQL script to initialize Postgres
├── requirements.txt     # Python dependencies
├── Dockerfile           # App container
├── docker-compose.yml   # Local stack with app + Postgres
├── Makefile             # Helpful commands
```

---

## 🚀 How to Run Locally

### 📦 Prerequisites
- Docker & Docker Compose
- Make (optional, for simpler commands)

### 🛠 Option A: Using Makefile
```bash
# Build the images
make build

# Start FastAPI + Postgres in the background
make up

# Watch logs
make logs

# Tear down
make down
```

### 🛠 Option B: Using Docker Compose Directly
```bash
docker-compose up --build
```

---

## 🔍 Test the App

Once it's running, access:
```bash
curl http://localhost:8000/hello
```
Expected output:
```json
{"message": "Hello from your RDS database!"}
```

---

## 🧾 Details
- The app uses the `psycopg2` library to connect to Postgres
- Connection info is passed via environment variables (see `docker-compose.yml`)
- The `init.sql` script will auto-create the `greetings` table and insert a sample row

---

## 🔄 Resetting the Environment
To wipe and restart the database:
```bash
make down
make up
```

This will drop volumes and reinitialize Postgres using `init.sql`

---

## 🧪 Troubleshooting
- If `/hello` returns a 500 error, check that the `greetings` table exists and the DB connection is valid
- Use `make logs` to see both app and DB logs

---

Happy hacking! 🐍⚙️
