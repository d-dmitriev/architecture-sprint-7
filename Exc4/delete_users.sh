#!/bin/bash

for user in $(< ./.created_users); do
    if [[ -n $user ]]; then
        csr_name=$user-csr
        context_name=$user-context
        echo
        echo "Удаление пользователя: $user"
        # Удаление запроса сертификата для пользователя, чтобы при повторном запросе был создан новый
        kubectl delete csr $csr_name
        # Удаление контекста пользователя
        kubectl config delete-context $context_name
        # Удаление пользователя
        kubectl config delete-user $user
        # Удаление папки с сертификатом пользователя
        rm -rf $user
        #Удаление первой строки из файла
        sed -i '' '1d' .created_users
    fi
done

echo
# Просмотр списка контекстов
echo "Список контекстов после очистки:"
kubectl config get-contexts
echo
# Просмотр списка пользователей
echo "Список пользователей после очистки:"
kubectl config get-users