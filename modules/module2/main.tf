terraform {
  required_providers {
    helm = {
      source = "hashicorp/helm"
      version = "2.11.0"
    }
  }
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "helm_release" "kube_prometheus" {
  name       = "kube-prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  namespace  = "monitoring" 
  create_namespace = true

}
