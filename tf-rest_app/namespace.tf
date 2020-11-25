resource "kubernetes_namespace" "namespace" {
  metadata {
    annotations = {
      name = var.namespace
    }

    labels = {
      namespace = var.namespace
    }

    name = var.namespace
  }
}
