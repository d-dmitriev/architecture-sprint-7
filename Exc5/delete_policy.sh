#!/bin/bash

kubectl delete -f default-deny-ingress.yaml
kubectl delete -f non-admin-api-allow.yaml
kubectl delete -f admin-api-allow.yaml