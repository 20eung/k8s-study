> 출처: https://subicura.com/k8s/guide/sample.html#워드프레스-배포

## 워드프레스 배포

> MySQL

| 키            | 값                            |
|---------------|-------------------------------|
| 컨테이너 이미지 | mariadb:10.7                 |
| 포트           | 3306                         |
| 환경변수       | MYSQL_DATABASE: wordpress     |
| 환경변수       | MYSQL_ROOT_PASSWORD: password |

> Wordpress

| 키            | 값                                  |
|---------------|-------------------------------------|
| 컨테이너 이미지 | wordpress:5.9.1-php8.1-apache       |
| 포트           | 80                                  |
| 환경변수       | WORDPRESS_DB_HOST: [wordpress host] |
| 환경변수       | WORDPRESS_DB_NAME: wordpress        |
| 환경변수       | WORDPRESS_DB_USER: root             |
| 환경변수       | WORDPRESS_DB_PASSWORD: password     |

> 정답 : 01-wordpress.yml
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: wordpress-mysql
  labels:
    app: wordpress
spec:
  selector:
    matchLabels:
      app: wordpress
      tier: mysql
  template:
    metadata:
      labels:
        app: wordpress
        tier: mysql
    spec:
      containers:
        - image: mariadb:10.7
          name: mysql
          env:
            - name: MYSQL_DATABASE
              value: wordpress
            - name: MYSQL_ROOT_PASSWORD
              value: password
          ports:
            - containerPort: 3306
              name: mysql

---
apiVersion: v1
kind: Service
metadata:
  name: wordpress-mysql
  labels:
    app: wordpress
spec:
  ports:
    - port: 3306
  selector:
    app: wordpress
    tier: mysql

---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: wordpress
  labels:
    app: wordpress
spec:
  selector:
    matchLabels:
      app: wordpress
      tier: frontend
  template:
    metadata:
      labels:
        app: wordpress
        tier: frontend
    spec:
      containers:
        - image: wordpress:5.9.1-php8.1-apache
          name: wordpress
          env:
            - name: WORDPRESS_DB_HOST
              value: wordpress-mysql
            - name: WORDPRESS_DB_NAME
              value: wordpress
            - name: WORDPRESS_DB_USER
              value: root
            - name: WORDPRESS_DB_PASSWORD
              value: password
          ports:
            - containerPort: 80
              name: wordpress

---
apiVersion: v1
kind: Service
metadata:
  name: wordpress
  labels:
    app: wordpress
spec:
  type: NodePort
  ports:
    - port: 80
      nodePort: 30000
  selector:
    app: wordpress
    tier: frontend
```