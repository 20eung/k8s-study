## 실습 1

> 다음 조건을 만족하는 Pod을 만드세요.

| Key                | Value                       |
|--------------------|-----------------------------|
| Pod 이름           | mariadb                     |
| Pod Label          | app:mariadb                 |
| Container 이름     | mariadb                     |
| Container 이미지   | mariadb:10.7                |
| Container 환경변수 | MYSQL_ROOT_PASSWORD: 123456 |
```
apiVersion: v1
kind: Pod
metadata:
  name: mariadb
  labels:
    app: mariadb
spec:
  containers:
    - name: mariadb
      image: mariadb:10.7
      env:
        - name: MYSQL_ROOT_PASSWORD
          value: "123456"
```