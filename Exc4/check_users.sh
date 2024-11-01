#!/bin/bash

resources=(pods "pods --subresource=log" secrets)
permissions=(get list watch create patch update delete)

for user in $(< ./.created_users); do
    if [[ -n $user ]]; then
        context_name=$user-context
        echo
        echo "Проверка пользователя:"
        # Переключение на использование созданного контекста
        kubectl config use-context $context_name
        # Проверка, что выбран созданный пользователь
        kubectl auth whoami 
        echo
        # Проверка прав пользователя
        for resource in "${resources[@]}"; do
            for permission in "${permissions[@]}"; do
                echo "Права $permission на ресурс $resource у пользователя $user:" $(kubectl auth can-i $permission $resource --all-namespaces)
            done
        done
    fi
done

echo
echo "Возвращаем контекст:"
# Переключение на использование контекста minikube
kubectl config use-context minikube
# Проверка, что выбран пользователь minikube
kubectl auth whoami 
# Проверка, что пользователь может обновлять поды во всех пространствах имен
# echo "Права на обновление подов у пользователя minikube: $(kubectl auth can-i update pods --all-namespaces)"