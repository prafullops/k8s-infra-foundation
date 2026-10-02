#!/bin/bash

# This script will help installing tools that are required prerequisite for bootstraping script.
# Tool installation followes guide for installing tools on Ubuntu 

echo "Starting installation process..."
echo "Installing required tools..."
echo ""

#  Docker Installation
echo "Installing docker"
echo "Uninstalling existing docker packages"
sudo apt remove $(dpkg --get-selections docker.io docker-compose docker-compose-v2 docker-doc docker-buildx podman-docker containerd runc | cut -f1)
echo "Adding Docker's official GPG key"
sudo apt update
sudo apt install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF

sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

if [[ $? -ne 0 ]]; then
    echo "Failed to update apt sources"
    exit 1
fi
echo ""
echo "Check if docker is running. run 'sudo systemctl status docker' to check the status of docker service"
echo "If docker is not running, run 'sudo systemctl start docker' to start the docker service"
echo "Docker installation completed successfully!"
echo  ""

# Kubectl Installation
echo "Installing kubectl"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
echo "Validating binary "
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm kubectl kubectl.sha256
echo "validate kubectl installation: kubectl version --client"
echo "Kubectl installation completed successfully!"
echo ""

#  K3d Installation
echo "Installing k3d"
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
echo "validate k3d installation: 'k3d version' or 'k3d help'"
echo "K3d installation completed successfully!"
echo ""

# fluxcd Installation
echo "Installing fluxcd"
curl -s https://fluxcd.io/install.sh | sudo bash
. <(flux completion bash)
echo "validate fluxcd installation: 'flux --version'"
echo "Fluxcd installation completed successfully!"
echo ""