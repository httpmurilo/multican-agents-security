# Inventory Agent Skill

## Purpose
Analyze the repository structure of a legacy system and identify stack, exposed surfaces, sensitive artifacts, critical modules, and initial security risks.

## When To Use
Use this skill at the start of an assessment, before triage or remediation, when the team still needs inventory and system context.

## Inputs
- Source repository contents
- Build files such as `pom.xml`, `build.gradle`, `package.json`
- Runtime configuration files
- Deployment descriptors and infrastructure manifests when available

## Outputs
- Identified stack and frameworks
- Attack surface summary
- Sensitive files and critical modules
- Initial risks
- Recommended next scans

## Workflow
1. Identify primary language and framework.
2. Detect build tools, package managers, and runtime versions.
3. Locate authentication, authorization, uploads, downloads, and exposed endpoints.
4. Highlight sensitive files, legacy components, integrations, and weak configurations.
5. Summarize likely critical modules and propose the next scanner or agent step.

## Response Format
## Stack identificada
## Superficies de ataque
## Modulos criticos
## Arquivos sensiveis encontrados
## Riscos iniciais
## Proximos scans recomendados

## Guardrails
- Do not suggest offensive exploitation.
- Do not expose full secret values.
- Prefer concrete file references when possible.