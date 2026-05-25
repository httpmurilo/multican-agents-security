#!/usr/bin/env bash

set -u

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

mkdir -p "$ROOT_DIR/reports/raw"

echo "Rodando Trivy via Docker Compose..."

docker compose run --rm trivy
status=$?

if [ "$status" -ne 0 ]; then
  echo "[!] Trivy retornou codigo $status. Verifique o log e o JSON gerado."
fi

echo "Relatorio Trivy em reports/raw/trivy.json"
exit 0
