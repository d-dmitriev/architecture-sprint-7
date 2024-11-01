#!/bin/bash

for pod in $(kubectl get pods --no-headers=true -o name | awk -F "/" '{print $2}'); do
    kubectl delete pod $pod
done

for service in $(kubectl get services --no-headers=true -o name | awk -F "/" '{print $2}'); do
    kubectl delete service $service
done