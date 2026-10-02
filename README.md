# k8s-infra-foundation

## Description

This repository holds scripts, k8s manifests and configuration for bootstrapping multi–environment kubernetes clusters using lightweight kubernetes solution k3d and FluxCD for GitOps.

## Cluster Features
1. Multi-node setup with dedicated master and worker node architecture. 
2. Network Policies for network isolation
3. Scaling through horizontal pod autoscaling
4. support for onboading new teams/projects to cluster with minimul efforts.
5. Complete observability and monitoring: kube-prometheus-stack for metrics, ELK stack + filebeat for logs and Otel + jaeger for traces.
6. namespace based permissions boundry
7. resource quota, requests, limits.
8. fluxcd based gitops delivery setup for infrastructre as well as for applications.

## Tech Stack

Kubernetes, k3d, Bash, FluxCD, Helm, Kustomize, Grafana, Prometheus.


## Setup Guide

Using lightweight k3d to spin up kubernetes cluster.

Pre-requisites:
    1. Docker is required by k3d to run an kubernetes cluster: ([Install Docker](https://docs.docker.com/engine/install/))
    2. Kubectl helps us communicate with kubernetes api server: ([Install Kubectl](https://kubernetes.io/docs/tasks/tools/))
    3. For this project Flux is backbone of GitOps driven architecture: ([Install Flux CLI](https://fluxcd.io/flux/installation/)) 

Note: Script is created to run on linux based environment. So run it on wsl or machine with linux operating system with bash shell and awk binaries installed.

steps:
    1. Before running script add your user to docker group to prevent any permission related issues:
        run: sudo usermod -aG docker $USER
    2. Add environment variables to your shell.
        Generate github pat token with read write access to github and export it to GITHUB_TOKEN variable in your shell.
        run: export GITHUB_TOKEN=<your pat token>
             export GITHUB_USER=<your github username>
             export GITHUB_Email=<your github email>
             export GITHUB_BRANCH=<your github branch name to push flux manifests>
             export GITHUB_REPO_NAME=<repository where to commit flux manifest for self reconcilation>
             export ENVIRONMENT_NAME=<your environment name eg, test, prod>
             export FLUX_MANIFESTS_PATH=<path in repository to store manifests for flux>