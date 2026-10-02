#! /bin/bash

echo "Starting cluster bootstraping process..."
read -p "Enter Environment Name(test, prod): " ENV_NAME

if [[ $ENV_NAME == "prod"]]; then
    echo "Environment is $ENV_NAME"

fi

