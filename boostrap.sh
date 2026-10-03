#!/bin/bash

# ./install.sh

echo "Starting cluster bootstraping process..."
echo "Setting up environment variables..."

ENVIRONMENT_NAME=$(echo $ENVIRONMENT_NAME | awk '{print tolower($0)}')
GITHUB_BRANCH=${GITHUB_BRANCH:-main}
FLUX_MANIFESTS_PATH=${FLUX_MANIFESTS_PATH:-'./clusters/$ENVIRONMENT_NAME/'}

if [[ -z $ENVIRONMENT_NAME ]]; then
    read -p "Enter Environment Name(test, prod): " ENVIRONMENT_NAME
fi

if [[ -z $GITHUB_TOKEN ]]; then
    read -sp "Enter GITHUB_TOKEN: " GITHUB_TOKEN
fi

if [[ -z $GITHUB_USER ]]; then
    read -p  "Enter GITHUB_USER: " GITHUB_USER
fi

if [[ -z $GITHUB_EMAIL ]]; then
    read -p  "Enter GITHUB_EMAIL: " GITHUB_EMAIL
fi

if [[ -z $GITHUB_REPO_NAME ]]; then
    read -p  "Enter Github Repository Name : " GITHUB_REPO_NAME
fi

if [[ -z $GITHUB_BRANCH ]]; then
    read -p  "Enter GITHUB_BRANCH (default: main): " GITHUB_BRANCH
fi

if [[ -z $FLUX_MANIFESTS_PATH ]]; then
    read -p "Enter Path for Flux Manifests (default:./clusters/$ENVIRONMENT_NAME/ ): " FLUX_MANIFESTS_PATH
fi

if [[ -z $ENVIRONMENT_NAME ]] || [[ $ENVIRONMENT_NAME != "test" ]] && [[ $ENVIRONMENT_NAME != "prod" ]]; then
    echo "Invalid environment. Please enter 'test' or 'prod'."
    exit 1

else
    echo ""
    echo "Environment: $ENVIRONMENT_NAME"
    echo "Creating cluster..."
    k3d cluster create --config clusters/$ENVIRONMENT_NAME/k3d-config.yaml
    
    if [[ $? -ne 0 ]]; then
        echo "Failed to create cluster"
        exit 1
    fi
    
    echo "Cluster created successfully"
    echo ""

    echo "Configuring git user..."
    git config --global user.name "$GITHUB_USER"
    git config --global user.email "$GITHUB_EMAIL"
    echo "Git user configured successfully"
    echo ""

    echo "Running flux pre checks..."
    flux check --pre
    echo ""
    echo "Bootstraping flux..."
    flux bootstrap github --owner=$GITHUB_USER --repository=$GITHUB_REPO_NAME --branch=$GITHUB_BRANCH --path=$FLUX_MANIFESTS_PATH --personal --token-auth
    echo ""
    echo "Flux bootstrap completed successfully!"
    echo "Run 'flux check' to verify the installation and run 'flux get all -A'" 
fi

