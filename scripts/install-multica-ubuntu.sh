#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ENV_FILE="$ROOT_DIR/.env.multica"
EXAMPLE_ENV_FILE="$ROOT_DIR/.env.multica.example"
DOCKER_COMPOSE_FILE="$ROOT_DIR/docker-compose.multica.yml"

log() {
  printf '[install] %s\n' "$1"
}

need_cmd() {
  command -v "$1" >/dev/null 2>&1
}

require_sudo() {
  if [ "${EUID}" -ne 0 ] && ! need_cmd sudo; then
    printf 'This installer needs sudo privileges.\n' >&2
    exit 1
  fi
}

run_sudo() {
  if [ "${EUID}" -eq 0 ]; then
    "$@"
  else
    sudo "$@"
  fi
}

install_docker_ubuntu() {
  log "Installing Docker Engine and Compose plugin for Ubuntu/Debian"
  run_sudo apt-get update
  run_sudo apt-get install -y ca-certificates curl gnupg lsb-release
  run_sudo install -m 0755 -d /etc/apt/keyrings
  if [ ! -f /etc/apt/keyrings/docker.asc ]; then
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | run_sudo gpg --dearmor -o /etc/apt/keyrings/docker.asc
    run_sudo chmod a+r /etc/apt/keyrings/docker.asc
  fi

  local arch codename
  arch="$(dpkg --print-architecture)"
  codename="$(. /etc/os-release && echo "${VERSION_CODENAME}")"

  printf 'deb [arch=%s signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu %s stable\n' "$arch" "$codename" | run_sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
  run_sudo apt-get update
  run_sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  run_sudo systemctl enable --now docker

  if [ "${EUID}" -ne 0 ]; then
    run_sudo usermod -aG docker "$USER" || true
  fi
}

install_multica_cli() {
  log "Installing Multica CLI"
  curl -fsSL https://raw.githubusercontent.com/multica-ai/multica/main/scripts/install.sh | bash
}

prepare_env() {
  if [ ! -f "$ENV_FILE" ]; then
    log "Creating $ENV_FILE from example"
    cp "$EXAMPLE_ENV_FILE" "$ENV_FILE"
  fi
}

start_multica_stack() {
  log "Starting Multica self-host stack"
  docker compose --env-file "$ENV_FILE" -f "$DOCKER_COMPOSE_FILE" up -d postgres backend frontend
}

print_next_steps() {
  cat <<EOF

Multica self-host stack requested successfully.

Next steps:
1. Open http://localhost:3000 for the Multica frontend.
2. Backend should be reachable at http://localhost:8080.
3. Run: multica setup self-host
4. Run: multica daemon status

Notes:
- If you were just added to the docker group, log out and back in before using docker without sudo.
- The Multica daemon and Codex runtime still run on the host, not inside Docker.
EOF
}

main() {
  require_sudo

  if ! need_cmd apt-get; then
    printf 'This installer currently supports Ubuntu/Debian systems with apt-get.\n' >&2
    exit 1
  fi

  if ! need_cmd docker || ! docker compose version >/dev/null 2>&1; then
    install_docker_ubuntu
  else
    log "Docker and Compose plugin already available"
  fi

  prepare_env

  if ! need_cmd multica; then
    install_multica_cli
  else
    log "Multica CLI already installed"
  fi

  start_multica_stack
  print_next_steps
}

main "$@"