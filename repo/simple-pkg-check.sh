#!/usr/bin/env bash
# simple-pkg-check.sh
set -euo pipefail

PKG="${1:-}"
LOG_DIR="${LOG_DIR:-/tmp/pkgcheck}"
mkdir -p "$LOG_DIR"
LOG="$LOG_DIR/${PKG}_$(date -u +%Y%m%dT%H%M%SZ).log"

die() { echo "[ERR] $*" | tee -a "$LOG"; exit 1; }
log() { echo "[..] $*" | tee -a "$LOG"; }

[[ -n "$PKG" ]] || die "Укажи имя пакета: ./simple-pkg-check.sh <pkg>"

check_info() {
  log "Инфо о пакете"
  dnf info "$PKG" | tee -a "$LOG" || true
  rpm -qi "$PKG" | tee -a "$LOG" || true
}

install_pkg() {
  log "прогон установки"
  sudo dnf -y install --assumeno "$PKG" | tee -a "$LOG" || true
  log "Установка"
  sudo dnf -y install "$PKG" | tee -a "$LOG"
}

verify_pkg() {
  log "Верификация файлов"
  rpm -V "$PKG" | tee -a "$LOG" || true
}

downgrade_pkg() {
  log "Откат"
  sudo dnf -y downgrade "$PKG" | tee -a "$LOG" || true
}
upgrade_pkg() {
  log "Обновление"
  sudo dnf -y upgrade "$PKG" | tee -a "$LOG" || true
}

reinstall_pkg() {
  log "Переустановка"
  sudo dnf -y reinstall "$PKG" | tee -a "$LOG" || true
}

remove_pkg() {
  log "Удаление"
  sudo dnf -y remove "$PKG" | tee -a "$LOG" || true
}

main() {
  check_info
  install_pkg
  verify_pkg
  downgrade_pkg
  upgrade_pkg
  reinstall_pkg
  remove_pkg
  log "Готово. Лог: $LOG"
}

main "$@"
