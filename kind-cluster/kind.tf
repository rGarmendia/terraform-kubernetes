resource "kind_cluster" "default" {
    name           = "wefox-challenge-cluster"
    kubeconfig_path = local.k8s_config_path
    wait_for_ready = true

    kind_config {
        kind        = "Cluster"
        api_version = "kind.x-k8s.io/v1alpha4"

        node {
            role = "control-plane"

            kubeadm_config_patches = [
                "kind: InitConfiguration\nnodeRegistration:\n  kubeletExtraArgs:\n    node-labels: \"ingress-ready=true\"\n"
            ]

            extra_port_mappings {
                container_port = 30950
                host_port      = 8080
            }
            extra_port_mappings {
                container_port = 30948
                host_port      = 8081
            }
            extra_port_mappings {
                container_port = 30949
                host_port      = 8082
            }
        }
        node {
            role = "worker"
        }
    }
}
