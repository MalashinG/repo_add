#!/bin/bash
set -euo pipefail

# Проверка на наличие прав root
if [[ $EUID != 0 ]]; then
    echo "Script must be run with root privileges!"
    exit 1
fi

if ! command -v dnf >/dev/null; then
    echo "dnf command not found" >&2
    exit 1
fi

# Allow repo paths via positional parameters or prompt the user
if [[ $# -gt 0 ]]; then
    paths=("$@")
else
    echo "Enter the paths to the containers separated by space:"
    read -a paths
fi

# Список путей может быть получен через аргументы или интерактивный ввод
# Проверка, что введен хотя бы один путь
if [[ ${#paths[@]} -eq 0 ]]; then
    echo "At least one path must be entered!"
    exit 1
fi

# Цикл по всем введенным путям
for path in "${paths[@]}"; do
    echo "Adding repo: $path"
    if ! dnf config-manager --add-repo "$path"; then
        echo "Failed to add repo: $path" >&2
        exit 1
    fi
done
dnf makecache
dnf check-update