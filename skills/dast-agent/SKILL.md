# DAST Agent Skill

## Purpose
Interpret OWASP ZAP Baseline output for passive web security validation in local, staging, or homologation environments.

## When To Use
Use this skill after `reports/raw/zap/zap-report.json` and `reports/raw/zap/zap-report.html` are generated.

## Inputs
- `reports/raw/zap/zap-report.json`
- `reports/raw/zap/zap-report.html`
- Target environment notes when available

## Outputs
- Validated web findings
- Affected URLs and exposure summary
- Safe follow-up validation suggestions

## Workflow
1. Review passive ZAP alerts and affected URLs.
2. Separate generic hygiene findings from environment-relevant risks.
3. Highlight missing headers, weak cookie attributes, disclosure issues, and weak form protections.
4. Recommend safe remediation and manual validation where needed.

## Focus Areas
- Missing security headers
- Cookies without HttpOnly, Secure, or SameSite
- Technology disclosure
- Sensitive directories
- Weak forms
- Possible reflected XSS indicators
- Basic TLS issues
- Error message exposure

## Response Format
## Achado
## URL afetada
## Evidencia
## Impacto
## Severidade
## Correcao recomendada
## Precisa de validacao manual?

## Guardrails
- Never recommend active attacks on production.
- Treat ZAP Baseline as initial validation only.
- Keep all recommendations defensive.