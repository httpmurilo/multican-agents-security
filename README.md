# Regras de uso

Este pipeline so pode ser usado em sistemas proprios ou com autorizacao formal.

Proibido:
- Rodar DAST ativo em producao.
- Explorar vulnerabilidades sem autorizacao.
- Expor secrets encontrados em relatorio.
- Executar payload destrutivo.
- Alterar dados reais durante validacao.

Permitido:
- Analise de codigo-fonte.
- Analise de dependencias.
- Analise de configuracao.
- ZAP Baseline em ambiente local, homologacao ou staging.
- Geracao de relatorio e plano de correcao.

## Execucao isolada com Docker Compose

Pre-requisito unico:
- Docker Desktop ou Docker Engine com plugin Compose.

Execucao completa:

```bash
./scripts/run-all.sh http://host.docker.internal:8080
```

Execucao individual:

```bash
docker compose run --rm semgrep
docker compose run --rm osv
docker compose run --rm dependency-check
docker compose run --rm trivy
TARGET_URL=http://host.docker.internal:8080 docker compose run --rm zap
docker compose run --rm reporter
```

Saidas:
- `reports/raw/` para relatorios brutos
- `reports/final/` para consolidado final

## Multica self-host local

A stack do Multica self-host foi isolada em [docker-compose.multica.yml](c:/Users/muril/Desktop/poc/legacy-security-pipeline/docker-compose.multica.yml).
Isso sobe frontend, backend e banco do Multica em containers locais.
O daemon do Multica e o Codex continuam rodando na sua maquina, fora do Docker.

Passos:

```powershell
Copy-Item .env.multica.example .env.multica
docker compose --env-file .env.multica -f docker-compose.multica.yml up -d postgres backend frontend
irm https://raw.githubusercontent.com/multica-ai/multica/main/scripts/install.ps1 | iex
multica setup self-host
multica daemon status
```

No Ubuntu/Debian, voce tambem pode usar:

```bash
chmod +x ./scripts/install-multica-ubuntu.sh
./scripts/install-multica-ubuntu.sh
```

URLs padrao:
- Frontend Multica: `http://localhost:3000`
- Backend Multica: `http://localhost:8080`
