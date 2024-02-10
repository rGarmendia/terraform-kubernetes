provider "helm" {
  kubernetes {
    config_path = local.k8s_config_path
  }
}
