#!/usr/bin/env bash

set -u

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET_URL="${1:-http://host.docker.internal:8080}"

mkdir -p "$ROOT_DIR/reports/raw" "$ROOT_DIR/reports/final"

echo "==============================="
echo "Legacy Security Pipeline"
echo "Execucao isolada com Docker Compose"
echo "Target URL: $TARGET_URL"
echo "==============================="

echo "[1/6] Semgrep"
"$ROOT_DIR/scripts/run-semgrep.sh"

echo "[2/6] OSV-Scanner"
"$ROOT_DIR/scripts/run-osv.sh"

echo "[3/6] Dependency-Check"
"$ROOT_DIR/scripts/run-dependency-check.sh"

echo "[4/6] Trivy"
"$ROOT_DIR/scripts/run-trivy.sh"

echo "[5/6] ZAP Baseline"
"$ROOT_DIR/scripts/run-zap.sh" "$TARGET_URL"

echo "[6/6] Consolidando relatorios"
docker compose run --rm reporter
report_status=$?
if [ "$report_status" -ne 0 ]; then
  echo "[!] Falha ao consolidar relatorios. Verifique scripts/generate-report.py."
fi

echo "Scans finalizados."
echo "Relatorios brutos em reports/raw"
echo "Relatorios finais em reports/final"
exit 0
