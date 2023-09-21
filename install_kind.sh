#!/bin/bash

# Define the desired kind version
KIND_VERSION="v0.20.0"

# Define the cluster name
CLUSTER_NAME="my-cluster"

# Install kind if not already installed
command -v kind &> /dev/null || (
  echo "Installing kind..."
  curl -Lo /usr/local/bin/kind "https://github.com/kubernetes-sigs/kind/releases/download/$KIND_VERSION/kind-linux-amd64" &&
  chmod +x /usr/local/bin/kind
)

# Create a kind cluster
kind create cluster --name "$CLUSTER_NAME"

# Set the kubeconfig context to the new cluster
kubectl config use-context "$CLUSTER_NAME"

# Wait for the cluster to be ready (optional)
kubectl wait --for=condition=Ready nodes --all --timeout=5m

# Display cluster information
kubectl cluster-info

echo "Local kind cluster '$CLUSTER_NAME' is now up and running!"
