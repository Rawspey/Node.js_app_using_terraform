
terraform {
  required_providers {
    kubectl = {
      source = "gavinbunney/kubectl"
      version = "1.14.0"
    }
  }
}

provider "kubectl" {
   config_context = "kind-my-cluster"
}

data "kubectl_file_documents" "docs" {
    content = file("hello-world.yaml")
}

resource "kubectl_manifest" "test" {
    for_each  = data.kubectl_file_documents.docs.manifests
    yaml_body = each.value
}
