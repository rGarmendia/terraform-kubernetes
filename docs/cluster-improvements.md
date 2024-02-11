# Cluster Enhancement Plan

> Disclaimer: All times are approximate, and please be aware that not all the plan applies for the KinD cluster.

I would like to focus the enhancement plan on the following points:
1. Observability
2. Scalability
3. Security
4. Consistency

## 1. Observability
To work on observability, we could focus on its three pillars. Currently, service meshes are an excellent option to support us in these aspects.

1. Metrics:
To obtain available metrics, we could install Prometheus. This tool would allow us to obtain real-time metrics of all the workload within the cluster.

    For this, there are multiple strategies:
    1. Prometheus Vanilla: Install Prometheus with Helm. With its well-configured service discovery, we could scrape the workload and store it within its database.

        Configuring AlertManager also takes time, a service responsible for generating alerts based on configuration.

        Estimated time: It may be proportional to the workload to be monitored.

        At least Vanilla, it should take a couple of days to configure it properly, assuming there are federations and external data persistence; otherwise, the time is significantly reduced.

    2. Service mesh: Installing a service mesh such as LinkerD deploys a sidecar on each pod, properly annotated.

        This sidecar is responsible for deploying a Prometheus and sending all the information about the metrics to the Prometheus instance.

        This is quite convenient because the configuration effort is minimal.

        Estimated time: 1 day.

2. Logs:
The de facto standard in the market is the use of Loki.

Installing Loki is quite simple; in fact, it presents itself as a Prometheus but for logs.

Also, when installed through a Helm chart, it is quite straightforward.

Generally, the stack used is Promtail + Loki + Grafana.

Estimated time: 1-2 days.

3. Tracing:

The service mesh also applies its virtues here; however, applications generally need to be instrumented to enjoy this option.

Estimated time: Proportional to the workload.

4. For visualization the tool is Grafana. We can use is to provide information gathered in most of these tools.

## 2. Scalability
Production clusters sometimes receive traffic that exceeds their default capacities. Therefore, it is important to have a scaling strategy for such situations.

For KinD, particularly, this aspect is quite limited since it is a cluster for development and testing. However, it is important to know how and how much to scale, in terms of performance and costs.

1. Worker nodes:
For example, in EKS clusters on AWS, we can use tools like AWS's Karpenter, which use resources more efficiently than the default tools provided by EKS.

Estimated time: 1 day.

2. HPA:
Through the resource metrics API, we can use HPA, which allows scaling the workload horizontally based on metrics.

As a best practice, it should come implemented at the Deployment level.

Estimated time: Proportional to the workload.

## 3. Security

Security is vital to ensure the proper functioning of the company's services.

1. Consider a good RBAC scheme.

Estimated time: Proportional to the scale of the company.

2. Generate SSL/TLS certificates to serve services over HTTPS, using ingress:
For this, you can use the cert-manager controller, which is responsible for generating certificates, free and automatically, for the cluster's workloads.

Estimated time: Proportional to the workload; however, it is quite simple and can be automated with templating through Helm or Kustomize.

3. Implement Service Mesh mTLS; this capability of the service mesh allows encrypting communication between Pods that are injected with a sidecar.

Estimated time: 1 day.

## 4. Consistency
Regarding consistency, it should always be ensured to deploy clusters with more than one node to ensure redundancy in case any fails for any reason. In the case of KinD, all nodes are containers that live within the Host. This should be avoided in production clusters.

1. DRP
Maintaining a copy of the cluster's workload, with tools for this task such as Velero, can be quite useful; however, keeping the cluster as IaC can also be used to be able to deploy it elsewhere if required, it is always a good practice.

Estimated time: Proportional to the operation's scale.
