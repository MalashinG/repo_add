#!/bin/bash

# Проверка на наличие прав root
if [[ $EUID != 0 ]]; then
    echo "Script must be run with root privileges!"
    exit 1
fi

echo "Enter the paths to the containers separated by space:"

# Чтение ввода пользователя и преобразование в массив
read -a paths

# Проверка, что введен хотя бы один путь
if [[ ${#paths[@]} -eq 0 ]]; then
    echo "At least one path must be entered!"
    exit 1
fi

# Цикл по всем введенным путям
for path in "${paths[@]}"; do
    echo "Adding repo: $path"
    dnf config-manager --add-repo $path
done



#dnf makecache

#dnf check-update