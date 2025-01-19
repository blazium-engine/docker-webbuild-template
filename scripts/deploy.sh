#!/bin/bash

# Ensure the script stops on errors
set -e

# Environment variables
PROJECT_NAME=${PROJECT_NAME:-example-game}                     # Default project name
DOCKER_REGISTRY=${DOCKER_REGISTRY:-registry.digitalocean.com} # Default Docker registry
REGISTRY_PATH=${REGISTRY_PATH:-example-registry}              # Default registry path
TAG=${TAG:-latest}                                            # Default tag

# Build the Docker image
docker build -t "$PROJECT_NAME" .

# Tag the Docker image
docker tag "$PROJECT_NAME" "$DOCKER_REGISTRY/$REGISTRY_PATH/$PROJECT_NAME:$TAG"

# Push the Docker image to the registry
docker push "$DOCKER_REGISTRY/$REGISTRY_PATH/$PROJECT_NAME:$TAG"

echo "Deployment complete: $DOCKER_REGISTRY/$REGISTRY_PATH/$PROJECT_NAME:$TAG"
