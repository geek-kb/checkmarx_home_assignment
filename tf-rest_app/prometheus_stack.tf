resource "helm_release" "prometheus" {
  name  = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart = "kube-prometheus-stack"
  version = "12.2.3"

  # set {
  #   name  = "service.annotations"
  #   value = "service.beta.kubernetes.io/aws-load-balancer-backend-protocol: http"
  # }
}
