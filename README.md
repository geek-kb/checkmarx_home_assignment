# Checkmarx home assignment

### Requirements:

- aws-cli
- terraform 

### Process:

1. Create a repo in AWS ECR:
```
aws ecr create-repository --repository-name checkmarkx_assignment
```
2. Browse to `checkmarx_task/rest_app` and build a docker image:
```
docker build -t checkmarkx_assignment .
```
3. Then tag & push the new image to the newly created ECR repo:

```
aws ecr get-login-password --region eu-central-1 | docker login --username AWS --password-stdin AWS_ECR_ADDRESS
docker tag checkmarx_assignment:latest AWS_ECR_ADDRESS/checkmarx_assignment:latest
docker push AWS_ECR_ADDRESS/checkmarx_assignment:lates
```

4. In order to create a k8s cluster in AWS EKS, browse to `checkmarkx_task/tf-eks_cluster` and run:

```
terrafrom init
terraform plan
terraform apply
```

5. Update your kubeconfig to point to the context of the new cluster:
```
aws eks --region region update-kubeconfig --name cluster_name
```
6. Update the file `checkmarx_task/tf-rest_app/vars.tf` - container_image - to point to the ECR image name.
7. Deploy the metrics-server:
```
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/download/v0.3.6/components.yaml
```
8. In order to configure the REST api deployment, service and hpa, browse to `checkmarx_task/tf-rest_app` and run:

```
terraform init
terraform plan
terraform apply
```

9. Port-forward to the Grafana service in k8s:
```
kubectl port-forward service/prometheus-grafana 8088:80 -n default
```
10. Get the Grafana server password:
```
kubectl get secret prometheus-grafana -o yaml | grep admin-password | awk -F: '{print $2}' | head -1 | tr -d " " | base64 -d
```
11. Browse to [http://localhost:8088]() and use the username "admin" and the password you retrieved from the previous step in order to log into Grafana.
