# k3s nginx-ingress

## Create 2 VMs

## Install k3s on master
```
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--disable=traefik" sh -
```
### Get token node
```
sudo cat /var/lib/rancher/k3s/server/node-token
```

## Install k3s on worker
```
curl -sfL https://get.k3s.io | K3S_URL=https://<IP_MASTER>:6443 K3S_TOKEN=<TOKEN> sh -
```

## Add nginx-ingress
```
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm install nginx-ingress ingress-nginx/ingress-nginx --create-namespace --namespace ingress-nginx
```

## Apply the manifest files
```
kubectl apply -R -f nginx-ingress
```