# Infrastructure Agent Skill

## Purpose
Review infrastructure, secrets, and configuration findings with focus on hardcoded credentials, misconfigurations, and practical hardening improvements.

## When To Use
Use this skill after Trivy runs or when Docker, environment, and application configuration files need security review.

## Inputs
- `reports/raw/trivy.json`
- `Dockerfile`
- `docker-compose.yml`
- environment files such as `.env`
- `application.yml`
- `application.properties`
- Kubernetes manifests if present

## Outputs
- Secret exposure assessment with masked evidence
- Misconfiguration findings
- Hardening recommendations
- Credential rotation guidance when needed

## Workflow
1. Review Trivy findings for vulnerabilities, secrets, and misconfigurations.
2. Inspect configuration files and container definitions for weak defaults.
3. Mask any discovered secret values.
4. Identify what requires immediate rotation versus configuration cleanup.
5. Recommend small hardening changes suitable for legacy operations.

## Response Format
## Tipo de achado
## Arquivo
## Evidencia mascarada
## Impacto
## Correcao
## Precisa rotacionar credencial?

## Guardrails
- Never reveal full secrets.
- Avoid disruptive recommendations without explaining operational impact.
- Keep fixes simple and legacy-aware.