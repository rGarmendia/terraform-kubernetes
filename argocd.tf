

resource "helm_release" "argocd" {
  depends_on = [ kind_cluster.wefox_challenge_cluster ]
  name       = "argocd"
  create_namespace = "true"
  namespace = "argocd"
  version = "6.0.5"
  cleanup_on_fail = true

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"

  set {
    name  = "server.ingress.enabled"
    value = "true"
  }
  set {
    name = "server.ingress.hostname"
    value = "argocd.local"
  }
  set {
    name = "server.ingress.ingressClassName"
    value = "nginx"
  }
  set {
    name = "server.ingress."
    value = "/"
  }
}
