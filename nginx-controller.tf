resource "helm_release" "nginx_ingress" {
  depends_on        = [ kind_cluster.wefox_challenge_cluster ]
  name              = "nginx-ingress-controller"
  create_namespace  = true
  namespace         = "nginx-ingress"
  repository        = "https://kubernetes.github.io/ingress-nginx"
  chart             = "ingress-nginx"
  version           = "4.9.1"
  cleanup_on_fail = true

  set {
    name  = "controller.ingressClass"
    value = "nginx"
  }

  set {
    name  = "controller.ingressClassResource.name"
    value = "nginx"
  }
  set {
    name  = "controller.service.type"
    value = "NodePort"
  }

  set {
    name  = "controller.publishService.enabled"
    value = "true"
  }
  set {
    name = "controller.service.nodePorts.http"
    value = "30950"
  }
  set {
    name = "controller.service.nodePorts.https"
    value = "30949"
  }
}
