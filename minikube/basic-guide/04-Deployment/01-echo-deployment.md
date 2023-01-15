> 출처: https://subicura.com/k8s/guide/deployment.html#deployment-만들기

## Deployment 만들기

> $ vi 01-echo-deployment.yml
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: echo-deploy
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

## Deployment 생성

> $ kubectl apply -f 01-echo-deployment.yml
```
deployment.apps/echo-deploy created
```

## 리소스 확인

> $ kubectl get po,rs,deploy
```
NAME                               READY   STATUS    RESTARTS   AGE
pod/echo-deploy-68b9dfd874-sjsrm   1/1     Running   0          8s
pod/echo-deploy-68b9dfd874-dnr82   1/1     Running   0          8s
pod/echo-deploy-68b9dfd874-rvs7l   1/1     Running   0          8s
pod/echo-deploy-68b9dfd874-s2rzr   1/1     Running   0          8s

NAME                                     DESIRED   CURRENT   READY   AGE
replicaset.apps/echo-deploy-68b9dfd874   4         4         4       8s

NAME                          READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/echo-deploy   4/4     4            4           9s
```