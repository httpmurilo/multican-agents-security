#!/usr/bin/env python3

import json
from pathlib import Path

ROOT_DIR = Path(__file__).resolve().parent.parent
RAW_REPORT_DIR = ROOT_DIR / "reports" / "raw"
FINAL_REPORT_DIR = ROOT_DIR / "reports" / "final"
SUMMARY_FILE = FINAL_REPORT_DIR / "summary.json"
TECHNICAL_FILE = FINAL_REPORT_DIR / "technical-report.md"
EXECUTIVE_FILE = FINAL_REPORT_DIR / "executive-report.md"


def load_json(path: Path):
    if not path.exists():
        return {"status": "missing", "path": str(path.relative_to(ROOT_DIR))}

    try:
        with path.open("r", encoding="utf-8") as handle:
            return {"status": "ok", "data": json.load(handle)}
    except json.JSONDecodeError as exc:
        return {
            "status": "invalid_json",
            "path": str(path.relative_to(ROOT_DIR)),
            "error": str(exc),
        }


def summarize_status(summary):
    return [f"- {name}: {details['status']}" for name, details in summary.items()]


def write_markdown_reports(summary):
    technical_lines = [
        "# Relatorio Tecnico de Vulnerabilidades",
        "",
        "## Escopo",
        "- Execucao local do pipeline defensivo em ambiente isolado com Docker Compose.",
        "",
        "## Status dos scanners",
        *summarize_status(summary),
        "",
        "## Observacoes",
        "- Este consolidado inicial nao normaliza severidades por ferramenta.",
        "- Ausencia de arquivo indica scanner nao executado ou falha na geracao do relatorio.",
    ]

    executive_lines = [
        "# Relatorio Executivo de Seguranca",
        "",
        "## Resumo geral",
        "- O pipeline foi executado em ambiente isolado por containers.",
        "- Os resultados abaixo indicam disponibilidade dos relatorios por scanner.",
        "",
        "## Status por ferramenta",
        *summarize_status(summary),
        "",
        "## Proximos passos",
        "1. Revisar os achados criticos e altos nas saidas brutas.",
        "2. Validar o relatorio do ZAP apenas para ambiente local, staging ou homologacao autorizado.",
        "3. Evoluir a normalizacao para priorizacao P0-P3.",
    ]

    TECHNICAL_FILE.write_text("\n".join(technical_lines) + "\n", encoding="utf-8")
    EXECUTIVE_FILE.write_text("\n".join(executive_lines) + "\n", encoding="utf-8")


def main():
    FINAL_REPORT_DIR.mkdir(parents=True, exist_ok=True)

    summary = {
        "semgrep": load_json(RAW_REPORT_DIR / "semgrep.json"),
        "osv": load_json(RAW_REPORT_DIR / "osv.json"),
        "dependency_check": load_json(RAW_REPORT_DIR / "dependency-check" / "dependency-check-report.json"),
        "trivy": load_json(RAW_REPORT_DIR / "trivy.json"),
        "zap": load_json(RAW_REPORT_DIR / "zap" / "zap-report.json"),
    }

    with SUMMARY_FILE.open("w", encoding="utf-8") as handle:
        json.dump(summary, handle, indent=2)

    write_markdown_reports(summary)

    print(f"[+] Summary report generated at {SUMMARY_FILE}")
    print(f"[+] Technical report generated at {TECHNICAL_FILE}")
    print(f"[+] Executive report generated at {EXECUTIVE_FILE}")


if __name__ == "__main__":
    main()
