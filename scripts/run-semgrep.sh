#!/usr/bin/env bash

set -u

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

mkdir -p "$ROOT_DIR/reports/raw"

echo "Rodando Semgrep via Docker Compose..."

docker compose run --rm semgrep
status=$?

if [ "$status" -ne 0 ]; then
  echo "[!] Semgrep retornou codigo $status. Verifique o log e o JSON gerado."
fi

echo "Relatorio Semgrep em reports/raw/semgrep.json"
exit 0
