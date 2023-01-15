> 출처: https://subicura.com/k8s/guide/deployment.html#배포-전략-설정

## 롤링업데이트RollingUpdate 방식을 사용할 때 동시에 업데이트하는 Pod의 개수를 변경

> $ vi 04-echo-strategy.yml
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: echo-deploy-st
spec:
  replicas: 4
  selector:
    matchLabels:
      app: echo
      tier: app
  minReadySeconds: 5
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 3
      maxUnavailable: 3
  template:
    metadata:
      labels:
        app: echo
        tier: app
    spec:
      containers:
        - name: echo
          image: ghcr.io/subicura/echo:v1
          livenessProbe:
            httpGet:
              path: /
              port: 3000
```

## Deployment를 생성

> $ kubectl apply -f 04-echo-strategy.yml
```
deployment.apps/echo-deploy-st created
```

## 리소스 확인

> $ kubectl get po,rs,deploy
```
NAME                                 READY   STATUS    RESTARTS   AGE
pod/echo-deploy-58cfb87569-8cfbh     1/1     Running   0          13m
pod/echo-deploy-58cfb87569-lfswz     1/1     Running   0          13m
pod/echo-deploy-58cfb87569-pvgbl     1/1     Running   0          13m
pod/echo-deploy-58cfb87569-x8bff     1/1     Running   0          13m
pod/echo-deploy-st-5694b4995-9php5   1/1     Running   0          11s
pod/echo-deploy-st-5694b4995-src9n   1/1     Running   0          11s
pod/echo-deploy-st-5694b4995-r25sg   1/1     Running   0          11s
pod/echo-deploy-st-5694b4995-8b2fk   1/1     Running   0          11s

NAME                                       DESIRED   CURRENT   READY   AGE
replicaset.apps/echo-deploy-68b9dfd874     0         0         0       25m
replicaset.apps/echo-deploy-58cfb87569     4         4         4       23m
replicaset.apps/echo-deploy-st-5694b4995   4         4         4       11s

NAME                             READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/echo-deploy      4/4     4            4           26m
deployment.apps/echo-deploy-st   4/4     4            4           11s
```

# 이미지 변경 (명령어로)

> $ kubectl set image deployment.apps/echo-deploy-st echo=ghcr.io/subicura/echo:v2
```
deployment.apps/echo-deploy-st image updated
```

# 이벤트 확인

> $ kubectl describe deploy/echo-deploy-st
```
Name:                   echo-deploy-st
Namespace:              default
CreationTimestamp:      Mon, 09 Jan 2023 16:20:11 +0900
Labels:                 <none>
Annotations:            deployment.kubernetes.io/revision: 2
Selector:               app=echo,tier=app
Replicas:               4 desired | 4 updated | 4 total | 4 available | 0 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        5
RollingUpdateStrategy:  3 max unavailable, 3 max surge
Pod Template:
  Labels:  app=echo
           tier=app
  Containers:
   echo:
    Image:        ghcr.io/subicura/echo:v2
    Port:         <none>
    Host Port:    <none>
    Liveness:     http-get http://:3000/ delay=0s timeout=1s period=10s #success=1 #failure=3
    Environment:  <none>
    Mounts:       <none>
  Volumes:        <none>
Conditions:
  Type           Status  Reason
  ----           ------  ------
  Available      True    MinimumReplicasAvailable
  Progressing    True    NewReplicaSetAvailable
OldReplicaSets:  <none>
NewReplicaSet:   echo-deploy-st-5c7d4b8c4 (4/4 replicas created)
Events:
  Type    Reason             Age   From                   Message
  ----    ------             ----  ----                   -------
  Normal  ScalingReplicaSet  71s   deployment-controller  Scaled up replica set echo-deploy-st-5694b4995 to 4
  Normal  ScalingReplicaSet  11s   deployment-controller  Scaled up replica set echo-deploy-st-5c7d4b8c4 to 3
  Normal  ScalingReplicaSet  11s   deployment-controller  Scaled down replica set echo-deploy-st-5694b4995 to 1 from 4
  Normal  ScalingReplicaSet  11s   deployment-controller  Scaled up replica set echo-deploy-st-5c7d4b8c4 to 4 from 3
  Normal  ScalingReplicaSet  3s    deployment-controller  Scaled down replica set echo-deploy-st-5694b4995 to 0 from 1
```

## 리소스 확인

> $ kubectl get po,rs,deploy
```
NAME                                 READY   STATUS    RESTARTS   AGE
pod/echo-deploy-58cfb87569-8cfbh     1/1     Running   0          14m
pod/echo-deploy-58cfb87569-lfswz     1/1     Running   0          14m
pod/echo-deploy-58cfb87569-pvgbl     1/1     Running   0          14m
pod/echo-deploy-58cfb87569-x8bff     1/1     Running   0          14m
pod/echo-deploy-st-5c7d4b8c4-b8zdj   1/1     Running   0          40s
pod/echo-deploy-st-5c7d4b8c4-lpw5n   1/1     Running   0          40s
pod/echo-deploy-st-5c7d4b8c4-r88zm   1/1     Running   0          40s
pod/echo-deploy-st-5c7d4b8c4-scxbr   1/1     Running   0          40s

NAME                                       DESIRED   CURRENT   READY   AGE
replicaset.apps/echo-deploy-68b9dfd874     0         0         0       27m
replicaset.apps/echo-deploy-58cfb87569     4         4         4       24m
replicaset.apps/echo-deploy-st-5c7d4b8c4   4         4         4       40s
replicaset.apps/echo-deploy-st-5694b4995   0         0         0       100s

NAME                             READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/echo-deploy      4/4     4            4           27m
deployment.apps/echo-deploy-st   4/4     4            4           100s
```