> 출처: https://subicura.com/k8s/guide/sample.html#투표-애플리케이션-배포

## 투표 애플리케이션 배포

> Redis

| 키            | 값            |
|---------------|---------------|
| 컨테이너 이미지 | redis:latest |
| 포트           | 6379         |

> Postgres

| 키            | 값                           |
|---------------|------------------------------|
| 컨테이너 이미지 | postgres:9.4                |
| 포트           | 5432                        |
| 환경변수       | POSTGRES_USER: postgres     |
| 환경변수       | POSTGRES_PASSWORD: postgres |

> worker

| 키            | 값                                     |
|---------------|----------------------------------------|
| 컨테이너 이미지 | ghcr.io/subicura/voting/worker:latest |
| 환경변수       | REDIS_HOST: [redis ip]                 |
| 환경변수       | REDIS_PORT: [redis port]               |
| 환경변수       | POSTGRES_HOST: [postgres ip]           |
| 환경변수       | POSTGRES_PORT: [postgres port]         |

> vote : 노드 31001으로 연결

| 키            | 값                                   |
|---------------|--------------------------------------|
| 컨테이너 이미지 | ghcr.io/subicura/voting/vote:latest |
| 포트           | 80                                  |
| 환경변수       | REDIS_HOST: [redis ip]              |
| 환경변수       | REDIS_PORT: [redis port]            |

> result : 노드 31001으로 연결

| 키            | 값                                     |
|---------------|----------------------------------------|
| 컨테이너 이미지 | ghcr.io/subicura/voting/result:latest |
| 포트           | 80                                    |
| 환경변수       | POSTGRES_HOST: [postgres ip]           |
| 환경변수       | POSTGRES_PORT: [postgres port]         |

> 정답 : 02-vote.yml
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: vote
spec:
  selector:
    matchLabels:
      service: vote
  template:
    metadata:
      labels:
        service: vote
    spec:
      containers:
        - name: vote
          image: ghcr.io/subicura/voting/vote
          env:
            - name: REDIS_HOST
              value: "redis"
            - name: REDIS_PORT
              value: "6379"
          livenessProbe:
            httpGet:
              path: /
              port: 80
          readinessProbe:
            httpGet:
              path: /
              port: 80
          ports:
            - containerPort: 80
              protocol: TCP

---
apiVersion: v1
kind: Service
metadata:
  name: vote
spec:
  type: NodePort
  ports:
    - port: 80
      nodePort: 31000
      protocol: TCP
  selector:
    service: vote

---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: result
spec:
  selector:
    matchLabels:
      service: result
  template:
    metadata:
      labels:
        service: result
    spec:
      containers:
        - name: result
          image: ghcr.io/subicura/voting/result
          env:
            - name: POSTGRES_HOST
              value: "db"
            - name: POSTGRES_PORT
              value: "5432"
          livenessProbe:
            httpGet:
              path: /
              port: 80
          readinessProbe:
            httpGet:
              path: /
              port: 80
          ports:
            - containerPort: 80
              protocol: TCP

---
apiVersion: v1
kind: Service
metadata:
  name: result
spec:
  type: NodePort
  ports:
    - port: 80
      nodePort: 31001
      protocol: TCP
  selector:
    service: result

---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: worker
spec:
  selector:
    matchLabels:
      service: worker
  template:
    metadata:
      labels:
        service: worker
    spec:
      containers:
        - name: worker
          image: ghcr.io/subicura/voting/worker
          env:
            - name: REDIS_HOST
              value: "redis"
            - name: REDIS_PORT
              value: "6379"
            - name: POSTGRES_HOST
              value: "db"
            - name: POSTGRES_PORT
              value: "5432"

---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: redis
spec:
  selector:
    matchLabels:
      service: redis
  template:
    metadata:
      labels:
        service: redis
    spec:
      containers:
        - name: redis
          image: redis
          ports:
            - containerPort: 6379
              protocol: TCP

---
apiVersion: v1
kind: Service
metadata:
  name: redis
spec:
  ports:
    - port: 6379
      protocol: TCP
  selector:
    service: redis

---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: db
spec:
  selector:
    matchLabels:
      service: db
  template:
    metadata:
      labels:
        service: db
    spec:
      containers:
        - name: db
          image: postgres:9.4
          env:
            - name: POSTGRES_USER
              value: "postgres"
            - name: POSTGRES_PASSWORD
              value: "postgres"
          ports:
            - containerPort: 5432
              protocol: TCP

---
apiVersion: v1
kind: Service
metadata:
  name: db
spec:
  ports:
    - port: 5432
      protocol: TCP
  selector:
    service: db
```