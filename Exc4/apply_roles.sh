#!/bin/bash

kubectl config use-context minikube

kubectl apply -f ./roles.yml
kubectl apply -f ./binding.yml
# kubectl create rolebinding developer-binding-myuser --role=developer --user=myuser