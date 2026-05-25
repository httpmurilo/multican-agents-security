#!/usr/bin/env bash

set -u

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

mkdir -p "$ROOT_DIR/reports/raw"

echo "Rodando OSV-Scanner via Docker Compose..."

docker compose run --rm osv
status=$?

if [ "$status" -ne 0 ]; then
  echo "[!] OSV-Scanner retornou codigo $status. Verifique o log e o JSON gerado."
fi

echo "Relatorio OSV em reports/raw/osv.json"
exit 0
