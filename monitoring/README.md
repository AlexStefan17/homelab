# Monitoring Stack (Grafana, Prometheus, Node Exporter, PVE Exporter)

## 1. Edit .env file

## 2. Run this command from /monitoring to generate pve.yml
```
export $(cat .env | xargs) && envsubst < ./config/pve.yml.template > ./config/pve.yml
```