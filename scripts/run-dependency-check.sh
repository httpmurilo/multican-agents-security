#!/usr/bin/env bash

set -u

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

mkdir -p "$ROOT_DIR/reports/raw/dependency-check"

echo "Rodando OWASP Dependency-Check via Docker Compose..."

docker compose run --rm dependency-check
status=$?

if [ "$status" -ne 0 ]; then
  echo "[!] Dependency-Check retornou codigo $status. Verifique o log e os relatorios."
fi

echo "Relatorios Dependency-Check em reports/raw/dependency-check"
exit 0
