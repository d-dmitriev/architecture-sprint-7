Создание ролей и их биндинг в группы

```bash
./apply_roles.sh
```

Создание пользователя test

```bash
./create_users.sh test
```

Создание пользователя test1 входящего в группу developers

```bash
./create_users.sh test1 developers
```

Создание пользователя test2 входящего в группу cluster-users

```bash
./create_users.sh test2 cluster-users
```

Создание пользователя test3 входящего в группу cluster-admins

```bash
./create_users.sh test3 cluster-admins
```

Создание пользователя test4 входящего в группу secrets-admin

```bash
./create_users.sh test4 secrets-admin
```

Проверка всех созданных пользователей

```bash
./check_users.sh
```

Удаление всех созданных пользователей

```bash
./delete_users.sh
```
