#!/bin/bash
set -ue

# install php
if ! docker -v &> /dev/null; then
    sudo apt update
    sudo apt install php-common php-cli php-mbstring  php-dom php-mysql php-pdo -y
fi
if ! docker -v &> /dev/null; then
    sudo apt update
    sudo apt install composer -y
fi

# install docker
# Add Docker's official GPG key:
if ! docker -v &> /dev/null; then
    sudo apt-get update
    sudo apt-get install ca-certificates curl -y
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc
    # Add the repository to Apt sources:
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
fi

# composer install
composer install

# copy .env
cp ./.env.example ./.env

# gen key
php artisan key:generate


echo execute idea back task
# shellcheck disable=SC2034
read -r TEMP

# npm install
./vendor/bin/sail npm install
# migrate db
./vendor/bin/sail artisan migrate

echo execute idea front task
echo forwerd 8000 and 5173 port
