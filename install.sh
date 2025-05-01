#!/bin/bash

# ASCII-арт заголовок
cat << "EOF"

 ▄█       ▀████    ▐████▀          ███           ▄█               ▄████████         ▄████████       ▄████████       ▄█             ▄██████▄       ███    █▄       ████████▄       
███         ███▌   ████▀       ▀█████████▄      ███              ███    ███        ███    ███      ███    ███      ███            ███    ███      ███    ███      ███   ▀███      
███▌         ███  ▐███            ▀███▀▀██      ███              ███    █▀         ███    █▀       ███    █▀       ███            ███    ███      ███    ███      ███    ███      
███▌         ▀███▄███▀             ███   ▀      ███             ▄███▄▄▄            ███             ███             ███            ███    ███      ███    ███      ███    ███      
███▌         ████▀██▄              ███          ███            ▀▀███▀▀▀          ▀███████████      ███             ███            ███    ███      ███    ███      ███    ███      
███         ▐███  ▀███             ███          ███              ███    █▄                ███      ███    █▄       ███            ███    ███      ███    ███      ███    ███      
███        ▄███     ███▄           ███          ███▌    ▄        ███    ███         ▄█    ███      ███    ███      ███▌    ▄      ███    ███      ███    ███      ███   ▄███      
█▀        ████       ███▄         ▄████▀        █████▄▄██        ██████████       ▄████████▀       ████████▀       █████▄▄██       ▀██████▀       ████████▀       ████████▀       
                                                ▀                                                                  ▀                                                              
                                                                
EOF

echo "CloudPanel Installer"

echo "Please select an option:"
echo "1 - Install CloudPanel"
echo "2 - Uninstall CloudPanel"
read -p "Enter your choice: " choice

if [[ $choice -eq 1 ]]; then
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
    sudo apt update
    sudo apt install -y nodejs git unzip

    # Клонирование репозитория
    git clone https://github.com/maixtl/IXCLOUD.git
    cd IXCLOUD

    # Распаковка архива
    unzip CloudPanel.zip

    # Переход в распакованную директорию
    cd CloudPanel

    # Установка зависимостей и запуск скриптов
    npm install
    npm run seed
    npm run createUser

    echo "Installation completed! CloudPanel is running."

elif [[ $choice -eq 2 ]]; then
    echo "Uninstalling CloudPanel ..."
    sudo rm -rf CloudPanel
    sudo rm -rf CloudPanel-wings
    echo "Uninstallation completed."
else
    echo "Invalid choice. Exiting."
fi
