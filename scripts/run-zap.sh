#!/usr/bin/env bash

set -u

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET_URL="${1:-http://host.docker.internal:8080}"

mkdir -p "$ROOT_DIR/reports/raw/zap"

echo "Rodando OWASP ZAP Baseline em $TARGET_URL via Docker Compose"
echo "Uso permitido apenas para ambiente local, homologacao ou staging autorizado."

TARGET_URL="$TARGET_URL" docker compose run --rm zap
status=$?

if [ "$status" -ne 0 ]; then
  echo "[!] ZAP retornou codigo $status. Em baseline isso pode acontecer mesmo com relatorio gerado."
fi

echo "Relatorios ZAP em reports/raw/zap"
exit 0
