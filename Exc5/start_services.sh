#!/bin/bash

labels=(front-end back-end-api admin-front-end admin-back-end-api)

for label in "${labels[@]}"; do
    kubectl run $label-app --image=nginx --labels role=$label --expose --port 80 
done
