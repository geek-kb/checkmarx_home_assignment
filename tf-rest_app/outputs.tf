output "eks_cluster_load_balancer_address" {
  value = "${kubernetes_service.restapi_app.load_balancer_ingress}"
}
