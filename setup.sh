#!/bin/bash
set -ue

# Log functions
log_info() {
    echo "[INFO] $1"
}

log_error() {
    echo "[ERROR] $1" >&2
}

# Check if command exists
command_exists() {
    command -v "$1" &> /dev/null
}

# Install PHP and required extensions
install_php() {
    if ! command_exists php; then
        log_info "Installing PHP and extensions..."
        sudo apt update
        sudo apt install -y \
            php-common \
            php-cli \
            php-mbstring \
            php-dom \
            php-mysql \
            php-pdo
        log_info "PHP installation completed"
    else
        log_info "PHP is already installed"
    fi
}

# Install Composer
install_composer() {
    if ! command_exists composer; then
        log_info "Installing Composer..."
        sudo apt update
        sudo apt install -y composer
        log_info "Composer installation completed"
    else
        log_info "Composer is already installed"
    fi
}

# Install Docker and related packages
install_docker() {
    if ! command_exists docker; then
        log_info "Installing Docker..."
        sudo apt-get update
        sudo apt-get install -y ca-certificates curl

        # Setup Docker repository
        sudo install -m 0755 -d /etc/apt/keyrings
        sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
        sudo chmod a+r /etc/apt/keyrings/docker.asc

        echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
        $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
        sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

        sudo apt-get update
        sudo apt-get install -y \
            docker-ce \
            docker-ce-cli \
            containerd.io \
            docker-buildx-plugin \
            docker-compose-plugin

        log_info "Docker installation completed"
    else
        log_info "Docker is already installed"
    fi
}

# Setup Laravel project
setup_laravel() {
    log_info "Setting up Laravel project..."

    if [ ! -f "composer.json" ]; then
        log_error "composer.json not found. Are you in the correct directory?"
        exit 1
    }

    composer install

    if [ -f ".env.example" ]; then
        cp ./.env.example ./.env
        php artisan key:generate
        log_info "Laravel environment setup completed"
    else
        log_error ".env.example file not found"
        exit 1
    fi
}

# Add current user to docker group
setup_docker_permissions() {
    log_info "Adding current user to docker group..."
    sudo gpasswd -a docker "${USER}"
    log_info "Please log out and back in for the group changes to take effect"
}

# Main execution
log_info "Starting development environment setup..."
install_php
install_composer
install_docker
setup_laravel
setup_docker_permissions
log_info "Setup completed successfully"
