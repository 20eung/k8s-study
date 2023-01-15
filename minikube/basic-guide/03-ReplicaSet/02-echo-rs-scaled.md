> 출처: https://subicura.com/k8s/guide/replicaset.html#스케일-아웃

## 스케일 아웃 만들기

> $ vi 02-echo-rs-scaled.yml
```
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: echo-rs
spec:
  replicas: 4
  selector:
    matchLabels:
      app: echo
      tier: app
  template:
    metadata:
      labels:
        app: echo
        tier: app
    spec:
      containers:
        - name: echo
          image: ghcr.io/subicura/echo:v1
```

## ScaledOut 생성

> $ kubectl apply -f 02-echo-rs-scaled.yml
```
replicaset.apps/echo-rs configured
```

## Pod 확인

> $ kubectl get po,rs
```
NAME                READY   STATUS    RESTARTS   AGE
pod/echo-rs-4669t   1/1     Running   0          7m34s
pod/echo-rs-khfvl   1/1     Running   0          19s
pod/echo-rs-2sfqr   1/1     Running   0          19s
pod/echo-rs-fgmg8   1/1     Running   0          19s

NAME                      DESIRED   CURRENT   READY   AGE
replicaset.apps/echo-rs   4         4         4       7m34s
```

## 기존 Pod 제거

> $ kubectl delete -f 02-echo-rs-scaled.yml