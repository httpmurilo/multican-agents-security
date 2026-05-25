# Dependency Agent Skill

## Purpose
Assess dependency risk across direct and transitive libraries using OSV and Dependency-Check results, with emphasis on legacy-safe upgrade paths.

## When To Use
Use this skill after dependency reports are available or when the repository includes package manifests and lockfiles.

## Inputs
- `reports/raw/osv.json`
- `reports/raw/dependency-check/dependency-check-report.json`
- `pom.xml`
- `build.gradle`
- `package.json`
- `package-lock.json`
- `yarn.lock`

## Outputs
- Confirmed vulnerable dependencies
- Direct vs transitive classification
- Safe target versions when possible
- Incremental remediation plan

## Workflow
1. Correlate dependency names across OSV and Dependency-Check outputs.
2. Group CVEs by library and prioritize critical and high-impact packages.
3. Distinguish direct dependencies from transitive ones.
4. Estimate upgrade risk in a legacy codebase.
5. Suggest the smallest practical version jumps and compensating controls if upgrades are blocked.

## Priority Guidance
- P0: critical remotely exploitable dependency risk
- P1: high-risk direct dependency
- P2: medium-risk or transitive dependency
- P3: low-risk or low-usage case

## Response Format
## Biblioteca
## Versao atual
## Versao recomendada
## CVEs
## Severidade
## Direta ou transitiva?
## Risco de atualizacao
## Plano de correcao

## Guardrails
- Do not recommend unsafe downgrade paths.
- Be explicit when a safe target version is an inference.
- Prefer incremental upgrades for legacy systems.