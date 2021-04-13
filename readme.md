# Using Google Kubernetes Engine

Hello and welcome to my GKE course. To get started follow these steps.

1. Create a GKE cluster
```
terraform apply -auto-approve
```

2. Deploy k8s secrets
```
kubectl apply -f secrets
```

3. Deploy mysql database to the cluster
```
kubectl apply -f database
```

4. Deploy Ghost blog to the container
```
kubectl apply -f ghost
```

5. Deploy cert-manager and Ingress controller
```
kubectl create namespace cert-manager
```
```
kubectl create clusterrolebinding cluster-admin-binding --clusterrole cluster-admin --user $(gcloud config get-value account)
```
```
kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v1.1.0/cert-manager.yaml
```

```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.43.0/deploy/static/provider/cloud/deploy.yaml
```

6. Deploy Cert
```
kubectl apply -f cert
```

7. Deploy ingress
```
kubectl apply -f ingress
```

### Retrieving the public IP
```
kubectl get svc ingress-nginx-controller --namespace ingress-nginx -o json | jq -r '.["status"]["loadBalancer"]["ingress"][0]["ip"]'
```