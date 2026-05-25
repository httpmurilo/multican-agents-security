# Triage Agent Skill

## Purpose
Consolidate findings across scanners, remove duplicates, prioritize by real risk, and prepare both technical and executive views for legacy systems.

## When To Use
Use this skill after one or more scanner outputs exist and the team needs a single prioritized backlog.

## Inputs
- `reports/raw/semgrep.json`
- `reports/raw/codeql.sarif`, if present
- `reports/raw/osv.json`
- `reports/raw/dependency-check/dependency-check-report.json`
- `reports/raw/trivy.json`
- `reports/raw/zap/zap-report.json`
- `config/risk-rules.yml`

## Outputs
- Consolidated security report
- Priority backlog
- Top risks
- Likely false positives
- Validation-needed items

## Workflow
1. Aggregate all available findings.
2. Deduplicate by asset, vulnerability type, and root cause when appropriate.
3. Flag likely false positives and missing context.
4. Prioritize using impact, exploitability, and exposure.
5. Separate quick wins from structural fixes.
6. Produce both technical and executive-ready summaries.

## Priority Guidance
- P0: RCE, exploitable SQL Injection, real secret exposure, critical exploitable dependency risk, severe auth/authz failure
- P1: real-impact XSS, Path Traversal, unsafe upload, insecure cookie in sensitive system, vulnerable direct dependency
- P2: missing headers, exposed versions, weak configuration, vulnerable transitive dependency without evidence of use
- P3: hardening and preventive improvements

## Response Format
# Relatorio Consolidado de Seguranca
## Resumo Executivo
## Quantidade de Achados
## Top 5 Riscos
## Achados Criticos
## Achados Altos
## Achados Medios
## Falsos Positivos Provaveis
## Plano de Correcao
## Correcos Rapidas
## Correcos Estruturais
## Riscos Aceitos
## Itens que precisam validacao manual

## Guardrails
- Do not inflate priority without evidence.
- Be explicit when prioritization depends on missing runtime context.
- Keep recommendations actionable for legacy teams.