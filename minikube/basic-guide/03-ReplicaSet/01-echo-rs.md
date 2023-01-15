> https://subicura.com/k8s/guide/replicaset.html#replicaset-만들기

## ReplicaSet 만들기

> vi 01-echo-rs.yml
```
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: echo-rs
spec:
  replicas: 1
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

## ReplicaSet 생성

> $ kubectl apply -f 01-echo-rs.yml
```
replicaset.apps/echo-rs created
```

## 리소스 확인

> $ kubectl get po,rs
```
NAME                READY   STATUS    RESTARTS   AGE
pod/echo-rs-4669t   1/1     Running   0          12s

NAME                      DESIRED   CURRENT   READY   AGE
replicaset.apps/echo-rs   1         1         1       12s
```

## 생성된 Pod의 label 확인

> $ kubectl get pod --show-labels
```
NAME            READY   STATUS    RESTARTS   AGE     LABELS
echo-rs-4669t   1/1     Running   0          3m30s   app=echo,tier=app
```

## app- 를 지정하면 app label을 제거

> $ kubectl label pod/echo-rs-4669t app-
```
pod/echo-rs-4669t unlabeled
```

## 다시 Pod 확인

> $ kubectl get pod --show-labels
```
NAME            READY   STATUS    RESTARTS   AGE     LABELS
echo-rs-4669t   1/1     Running   0          4m40s   tier=app
echo-rs-f7dzd   1/1     Running   0          5s      app=echo,tier=app
```

## app=echo 를 지정하면 app label을 추가

> $ kubectl label pod/echo-rs-4669t app=echo
```
pod/echo-rs-4669t labeled
```

## 다시 Pod 확인

> $ kubectl get pod --show-labels
```
NAME            READY   STATUS    RESTARTS   AGE     LABELS
echo-rs-4669t   1/1     Running   0          5m11s   app=echo,tier=app
```

## 기존 Pod 제거

> $ kubectl delete -f 01-echo-rs.yml
