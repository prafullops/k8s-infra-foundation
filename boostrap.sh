#!/bin/bash

# ./install.sh

echo "Starting cluster bootstraping process..."
echo "Setting up environment variables..."
read -p "Enter Environment Name(test, prod): " ENV_NAME

ENV_NAME=$(echo $ENV_NAME | awk '{print tolower($0)}')


if [[ -z $ENV_NAME ]] || [[ $ENV_NAME != "test" ]] && [[ $ENV_NAME != "prod" ]]; then
    echo "Invalid environment. Please enter 'test' or 'prod'."
    exit 1

else
    echo "Environment: $ENV_NAME"
    echo "Creating cluster..."
    k3d cluster create --config clusters/$ENV_NAME/k3d-config.yaml
    
    if [[ $? -ne 0 ]]; then
        echo "Failed to create cluster"
        exit 1
    fi
    
    echo "Cluster created successfully"
fi

