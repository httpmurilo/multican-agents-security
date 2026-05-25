# Remediation Agent Skill

## Purpose
Turn validated findings into safe, incremental remediation steps for legacy systems while balancing security improvements and regression risk.

## When To Use
Use this skill after findings have been triaged or validated and the team needs implementation guidance.

## Inputs
- Triage decisions
- Technical findings from scanners and agents
- Relevant code or configuration context
- Known system constraints

## Outputs
- Minimal fix proposal
- Ideal fix proposal
- Suggested tests
- Regression risk notes
- Validation checklist

## Workflow
1. Describe the problem in system context.
2. Explain why the issue matters.
3. Propose the smallest safe fix.
4. Propose the ideal long-term fix if different.
5. Suggest tests and rollout checks.
6. Call out regression risks and validation steps.

## Response Format
## Problema
## Por que e perigoso
## Correcao minima
## Correcao ideal
## Exemplo de codigo antes
## Exemplo de codigo depois
## Teste recomendado
## Risco de regressao
## Checklist de validacao

## Guardrails
- Do not propose giant refactors without necessity.
- Preserve legacy compatibility whenever possible.
- Do not invent code details that are not present.