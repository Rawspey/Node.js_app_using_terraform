#!/bin/bash

KIND_VERSION="v0.20.0"
CLUSTER_NAME="my-cluster"
KUBECONFIG_FILE="kind-$CLUSTER_NAME-config.yaml"

# Install kind if not already installed
command -v kind &> /dev/null || (
  echo "Installing kind..."
  curl -Lo /tmp/kind "https://github.com/kubernetes-sigs/kind/releases/download/$KIND_VERSION/kind-linux-amd64" &&
  chmod +x /tmp/kind &&
  sudo mv /tmp/kind /usr/local/bin/
)

# Create a kind cluster
kind create cluster --name "$CLUSTER_NAME"

# Get the kubeconfig for the cluster
kubectl config view --raw > "$HOME/$KUBECONFIG_FILE"

# Set the kubeconfig context to the new cluster
kubectl config use-context "$CLUSTER_NAME"

# Wait for the cluster to be ready
kubectl wait --for=condition=Ready nodes --all --timeout=3m

# Display cluster information
kubectl cluster-info

echo "Local kind cluster '$CLUSTER_NAME' is now up and running."
echo "Kubeconfig saved to '$HOME/$KUBECONFIG_FILE'."
