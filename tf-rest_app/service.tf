resource "kubernetes_service" "restapi_app" {
  metadata {
    name = "nginx-service"
    namespace = var.namespace
  }
  spec {
    type = "LoadBalancer"

    selector = {
      app = var.rest_app
    }
    port {
      port        = var.service_port
      target_port = var.service_port
    }
  }
}
