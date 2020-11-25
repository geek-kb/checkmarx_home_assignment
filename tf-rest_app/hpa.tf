resource "kubernetes_horizontal_pod_autoscaler" "hpa" {
  metadata {
    name = "hpa-app-metrics"
    namespace = var.namespace
  }

  spec {
    max_replicas = 3
    min_replicas = 1
    target_cpu_utilization_percentage = 1

    scale_target_ref {
      kind = "Deployment"
      name = var.rest_app
    }
  }
}
