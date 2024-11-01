#!/bin/bash

user="${1:-test}"
group1="${2:-group1}"
group2="${3:-group2}"
user_dir=$user
user_file=$user

if [[ -d "$user" ]]; then
    echo "Папка пользователя существует" && exit
fi

kubectl config use-context minikube

# Создание папки для ключа и сектификата пользователя
mkdir $user

echo "Создание сертификатов для пользователя: $user"

key_file=$user_dir/$user_file.key
crt_file=$user_dir/$user_file.crt
context_name=$user-context
csr_name=$user-csr

# Генкрация закрытого ключа
openssl genrsa -out $key_file 2048

# Отправка запроса на подписание сертификата для пользователя
cat <<EOF | kubectl apply -f -
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: $csr_name
spec:
  request: $(openssl req -new -key $key_file -subj "/CN=$user/O=$group1/O=$group2" | base64 | tr -d "\n")
  signerName: kubernetes.io/kube-apiserver-client
  expirationSeconds: 86400  # one day
  usages:
  - client auth
EOF

# Подтверждение сертификата пользователя
kubectl certificate approve $csr_name
# Ожидание сертификата
kubectl wait --for=jsonpath='{.status.certificate}' csr/$csr_name
# Сохранение сертификата в файл
kubectl get csr $csr_name -o jsonpath='{.status.certificate}'| base64 -d > $crt_file
# Удаление файла запроса

echo "Создание контекста пользователя: $user"
# Добавление пользователя в конфигурацию
kubectl config set-credentials $user --client-key=$key_file --client-certificate=$crt_file --embed-certs=true
# Создание контекста для пользователя
kubectl config set-context $context_name --cluster=minikube --user=$user

echo $user | tee -a .created_users