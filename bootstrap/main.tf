resource "kubernetes_manifest" "argocd_app" {
    manifest= yamldecode(file("/Users/ricardo.garmendia/estudios/wefox/terraform-wefox/bootstrap/manifests/podinfo-app.yaml"))
}
