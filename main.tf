terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.25.2"
    }
  }
}


module "kind" {
  source = "./kind-cluster"
  kubeconfig = "~/.kube/config-kind"
}

module "bootstrap" {
  source = "./bootstrap"
  depends_on = [ module.kind ]
  providers = {
    kubernetes = kubernetes
  }
}
