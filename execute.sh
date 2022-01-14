#!/bin/bash

cd kube-prometheus
# Create the namespace and CRDs, and then wait for them to be availble before creating the remaining resources
kubectl create -f manifests/setup
until kubectl get servicemonitors --all-namespaces ; do date; sleep 1; echo ""; done
kubectl create -f manifests/

# kubectl create -f manifests/setup -f manifests

echo "Access Prometheus"
kubectl --namespace monitoring port-forward svc/prometheus-k8s 9090

echo "Access Alertmanager"
kubectl --namespace monitoring port-forward svc/alertmanager-main 9093

echo "Access Grafana"
kubectl --namespace monitoring port-forward svc/grafana 3000

# Open the internbet browser http://localhost:3000 or AKS cluster LB IP
#
# Grafana username=admin and password=admin
