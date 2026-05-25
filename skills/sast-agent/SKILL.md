# SAST Agent Skill

## Purpose
Review static security findings from Semgrep and source code context to identify real vulnerabilities, likely false positives, and low-risk legacy-compatible fixes.

## When To Use
Use this skill after `reports/raw/semgrep.json` exists and source code is available for validation.

## Inputs
- `reports/raw/semgrep.json`
- Source code of the project
- Secure coding standards when available

## Outputs
- Validated SAST findings
- False positive notes
- Severity and probability assessment
- Legacy-compatible fix recommendations

## Workflow
1. Read Semgrep findings and group them by vulnerability type.
2. Inspect source files and lines tied to the finding.
3. Confirm whether the finding appears real, partial, or likely false positive.
4. Assess impact and exploitability in the application's real context.
5. Recommend the smallest safe fix before suggesting broader refactors.

## Focus Areas
- SQL Injection
- XSS
- Path Traversal
- Command Injection
- Insecure Deserialization
- Hardcoded Secrets
- Authentication failures
- Authorization failures
- Insecure cryptography
- Sensitive logging
- Insufficient input validation

## Response Format
## Achado
## Evidencia
## Arquivo e linha
## Impacto
## Severidade
## Probabilidade
## Falso positivo?
## Correcao recomendada
## Exemplo de correcao

## Guardrails
- Avoid large refactors unless necessary.
- Do not invent code context that is not present.
- Keep remediation compatible with legacy constraints.