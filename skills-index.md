# Skills Index

This file summarizes the skills mirrored from `agents/` for Multica import.

## inventory-agent
Maps the legacy application's stack, exposed surfaces, sensitive files, integrations, and likely high-risk modules.
Use before all other analysis to establish scope and recommend the next scans.

## sast-agent
Reviews static-analysis findings from Semgrep and source code context.
Use after `reports/raw/semgrep.json` is generated to separate real findings from likely false positives.

## dependency-agent
Analyzes vulnerable libraries using OSV-Scanner and Dependency-Check outputs.
Use when you need library-level risk, direct vs transitive impact, and upgrade guidance for legacy systems.

## infrastructure-agent
Reviews secrets, misconfigurations, Docker and runtime settings using Trivy and config files.
Use to identify hardcoded secrets, insecure defaults, and infrastructure hardening tasks.

## dast-agent
Interprets OWASP ZAP Baseline results for local, staging, or homologation targets.
Use to triage passive web findings without recommending offensive behavior.

## triage-agent
Consolidates findings across SAST, dependencies, infrastructure, and DAST.
Use when you need deduplication, prioritization, and an executive-ready remediation backlog.

## remediation-agent
Transforms validated findings into safe, incremental fixes for legacy systems.
Use after triage to define minimal fixes, ideal fixes, tests, and regression risks.