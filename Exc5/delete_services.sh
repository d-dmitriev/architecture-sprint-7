#!/bin/bash

for resource in $(kubectl get pods,services --no-headers=true -o name --field-selector=metadata.name!=kubernetes); do
    kubectl delete $resource
done