Запуск minikube с включенными политиками

```bash
minikube start --cni calico
```

Применение политик

```bash
./apply_policy.sh
```

Запуск сервисов

```bash
./start_services.sh
```

Скрипты для проверки доступности сервисов

```bash
wget -qO- --timeout=2 http://front-end-app
wget -qO- --timeout=2 http://back-end-api-app
wget -qO- --timeout=2 http://admin-front-end-app
wget -qO- --timeout=2 http://admin-back-end-api-app
```

Удаление сервисов

```bash
./delete_services.sh
```

Удаление политик

```bash
./delete_policy.sh
```
