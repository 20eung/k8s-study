> 출처: https://subicura.com/k8s/guide/service.html#service-clusterip-만들기

## Service(ClusterIP) 만들기

> $ vi 01-counter-redis-svc.yml
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: redis
spec:
  selector:
    matchLabels:
      app: counter
      tier: db
  template:
    metadata:
      labels:
        app: counter
        tier: db
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
    app: counter
    tier: db
```

## redis를 먼저 만들어 봅니다

> $ kubectl apply -f 01-counter-redis-svc.yml
```
deployment.apps/redis created
service/redis created
```

## Pod, ReplicaSet, Deployment, Service 상태 확인

> $ kubectl get all
```
NAME                         READY   STATUS    RESTARTS   AGE
pod/redis-5cb78b9855-whpz7   1/1     Running   0          12s

NAME                 TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)    AGE
service/kubernetes   ClusterIP   10.43.0.1      <none>        443/TCP    25h
service/redis        ClusterIP   10.43.30.147   <none>        6379/TCP   12s

NAME                    READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/redis   1/1     1            1           12s

NAME                               DESIRED   CURRENT   READY   AGE
replicaset.apps/redis-5cb78b9855   1         1         1       12s
```

## redis에 접근할 counter 앱을 Deployment로 만듭니다.

> $ vi 02-counter-app.yml
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: counter
spec:
  selector:
    matchLabels:
      app: counter
      tier: app
  template:
    metadata:
      labels:
        app: counter
        tier: app
    spec:
      containers:
        - name: counter
          image: ghcr.io/subicura/counter:latest
          env:
            - name: REDIS_HOST
              value: "redis"
            - name: REDIS_PORT
              value: "6379"
```

> $ kubectl apply -f 02-counter-app.yml
```
deployment.apps/counter created
```

## Pod, ReplicaSet, Deployment, Service 상태 확인

> $ kubectl get all
```
NAME                          READY   STATUS    RESTARTS   AGE
pod/redis-5cb78b9855-whpz7    1/1     Running   0          7m28s
pod/counter-985748f4c-jm96n   1/1     Running   0          10s

NAME                 TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)    AGE
service/kubernetes   ClusterIP   10.43.0.1      <none>        443/TCP    25h
service/redis        ClusterIP   10.43.30.147   <none>        6379/TCP   7m28s

NAME                      READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/redis     1/1     1            1           7m28s
deployment.apps/counter   1/1     1            1           10s

NAME                                DESIRED   CURRENT   READY   AGE
replicaset.apps/redis-5cb78b9855    1         1         1       7m28s
replicaset.apps/counter-985748f4c   1         1         1       10s
```

## counter app에 접근

> $ kubectl exec -it counter-985748f4c-jm96n -- sh
```
/app # curl localhost:3000
1

/app # curl localhost:3000
2

/app # telnet redis 6379
Connected to redis
dbsize
:1

KEYS *
*1
$5
count

GET count
$1
2

quit
+OK
Connection closed by foreign host

/app # exit
command terminated with exit code 1
```