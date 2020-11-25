# Checkmarx home assignment

### Requirements:

- aws-cli
- terraform 

* Before running terraform, go through each `vars.tf` file and verify the variables point to the correctt resources

### Process:

1. Create a repo in AWS ECR:
```
aws ecr create-repository --repository-name checkmarkx_assignment
```
2. Browse to `checkmarx_home_assignment/rest_app` and build a docker image:
```
docker build -t checkmarkx_assignment .
```
3. Then tag & push the new image to the newly created ECR repo:

```
aws ecr get-login-password --region eu-central-1 | docker login --username AWS --password-stdin AWS_ECR_ADDRESS
docker tag checkmarx_assignment:latest AWS_ECR_ADDRESS/checkmarx_assignment:latest
docker push AWS_ECR_ADDRESS/checkmarx_assignment:latest
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
6. Update the file `checkmarx_home_assignment/tf-rest_app/vars.tf` - container_image - to point to the ECR image name.
7. Deploy the metrics-server:
```
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/download/v0.3.6/components.yaml
```
8. In order to configure the REST api deployment, service and hpa, browse to `checkmarx_home_assignment/tf-rest_app` and run:

```
terraform init
terraform plan
terraform apply
```

### Testing the environment

#### rest_app:

1. Port-forward to the rest_app AWS load balancer:
```
kubecttl port-forward service/nginx-service 8081:80 -n checkmarx-home-assignment-euc1
```

2. Browse to [http://localhost:8081/tracks]() or [http://localhost:8081/employees]()

#### HPA:

In order to create the required load on the REST api to see how it scales up the number of the pods, run (in MacOs terminal):

```
parallel --jobs 30 curl -s http://K8s-rest_app-load_balancer-endpoint_address/tracks ::: {1..400}
```

And in another terminal window, run:

```
kubectl get pods -n checkmarx-home-assignment-euc1 -w
```

#### Grafana:

1. Port-forward to the Grafana service in k8s:
```
kubectl port-forward service/prometheus-grafana 8088:80 -n default
```

2. Get the Grafana server password:
```
kubectl get secret prometheus-grafana -o yaml | grep admin-password | awk -F: '{print $2}' | head -1 | tr -d " " | base64 -d
```

3. Browse to [http://localhost:8088]() and use the username "admin" and the password you retrieved from the previous step in order to log into Grafana.

*** 

The code in [rest_app directory](https://github.com/geek-kb/checkmarx_home_assignment/tree/master/rest_app) is taken from [this url](https://www.codementor.io/@sagaragarwal94/building-a-basic-restful-api-in-python-58k02xsiq).
