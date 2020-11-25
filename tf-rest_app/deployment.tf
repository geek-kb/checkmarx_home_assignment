resource "kubernetes_deployment" "restapi_app" {
  metadata {
    name = var.rest_app
    labels = {
      app = var.rest_app
    }
    namespace = var.namespace
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = {
        app = var.rest_app
      }
    }

    template {
      metadata {
        labels = {
          app = var.rest_app
        }
      }

      spec {
        container {
          image = var.container_image
          name  = var.rest_app

          port {
            name = var.service_name
            container_port = var.service_port
          }

          resources {
            limits {
              cpu    = var.resources_limits[0]
              memory = var.resources_limits[1]
            }
            requests {
              cpu    = var.resources_requests[0]
              memory = var.resources_requests[1]
            }
          }

          liveness_probe {
            http_get {
              path = var.liveness_probe_string
              port = var.liveness_probe_port
            }

            initial_delay_seconds = 30
            period_seconds        = 3
          }
        }
      }
    }
  }
}
