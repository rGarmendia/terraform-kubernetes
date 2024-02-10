1. Set de dependencies
    1. Create ~/.kube/config-kind file to store the kube config.
    ```bash
    touch ~/.kube/config-kind
    ```
    2. Set the kube config as env var
    ```bash
    export KUBECONFIG=~/.kube/config-kind
    ```
3. Hecho con TF para evitar dependencias ciclicas
    1. Prepare your working directory
    ```bash
    terraform init
    ```
    2. Make your plan, and check the providers
    ```bash
    terraform plan -out=tf.plan
    ```
    3. Deploy the infrastructure
    ```bash
    terraform apply -state=tf.state
    ```
4. Generate the issuer, to generate the TLS certificate for the ArgoCD ingress resource.
```bash
kubectl apply -f ./kubernetes-manifests/argocd-tls-issuer.yaml --namespace argocd
```
Why? Racing condition between Kubernetes and Kind provider, would be prone to maintain two TF states, one for infra, and the other for the kubernetes resources.

5. Annotate the ArgoCD ingress rule to support TLS
```bash
kubectl annotate ingress argocd-server -n argocd cert-manager.io/issuer="argocd-server"
```
