#!/bin/bash

kubectl apply -f default-deny-ingress.yaml
kubectl apply -f non-admin-api-allow.yaml
kubectl apply -f admin-api-allow.yaml