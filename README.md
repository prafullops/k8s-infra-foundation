# k8s-infra-foundation
This repository scripts, k8s manifests, terraform files for bootstrapping multi–environment Kubernetes clusters.  

## Description

Bootstrapping local multi-environments kubernetes cluster using kind and fluxcd for gitops.

## What will this clusters have
1. Multi-node setup with dedicated master and worker node architecture. 
2. Network Policies for network isolation
3. Scaling through horizontal pod autoscaling
4. support for onboading new teams/projects to cluster with minimul efforts.
5. Complete observability and monitoring: kube-prometheus-stack for metrics, ELK stack + filebeat for logs and Otel + jaeger for traces.
6. namespace based permissions boundry
7. resource quota, requests, limits.
8. fluxcd based gitops delivery setup for infrastructre as well as for applications.

## Tech Stack

Kubernetes, kind, bash, fluxcd, helm, kustomize, grafana, prometheus, openTelemetry, jaeger, filebeat, kibana, elastic search.  
