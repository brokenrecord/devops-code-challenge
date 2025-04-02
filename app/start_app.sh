#!/usr/bin/env bash

set -euo pipefail

# Provision the database
python provision_db.py
# Start the Uvicorn server. Ref: app/Dockerfile
uvicorn main:app --host 0.0.0.0 --port 80
