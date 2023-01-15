> 출처: https://subicura.com/k8s/guide/deployment.html#deployment-만들기

## 이미지 태그만 변경하고 Deployment 만들기

> $ vi 02-echo-deployment-v2.yml
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
          image: ghcr.io/subicura/echo:v2
```

## 새로운 이미지 업데이트

> $ kubectl apply -f 03-echo-deployment-v2.yml
```
deployment.apps/echo-deploy configured
```

## 리소스 확인

> $ kubectl get po,rs,deploy
```
NAME                               READY   STATUS    RESTARTS   AGE
pod/echo-deploy-58cfb87569-bp4lh   1/1     Running   0          17s
pod/echo-deploy-58cfb87569-r59bw   1/1     Running   0          17s
pod/echo-deploy-58cfb87569-hm6gf   1/1     Running   0          12s
pod/echo-deploy-58cfb87569-whqqs   1/1     Running   0          12s

NAME                                     DESIRED   CURRENT   READY   AGE
replicaset.apps/echo-deploy-68b9dfd874   0         0         0       2m58s
replicaset.apps/echo-deploy-58cfb87569   4         4         4       17s

NAME                          READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/echo-deploy   4/4     4            4           2m59s
```

## 생성한 Deployment의 상세 상태

> $ kubectl describe deploy/echo-deploy
```
Name:                   echo-deploy
Namespace:              default
CreationTimestamp:      Mon, 09 Jan 2023 15:54:22 +0900
Labels:                 <none>
Annotations:            deployment.kubernetes.io/revision: 2
Selector:               app=echo,tier=app
Replicas:               4 desired | 4 updated | 4 total | 4 available | 0 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  25% max unavailable, 25% max surge
Pod Template:
  Labels:  app=echo
           tier=app
  Containers:
   echo:
    Image:        ghcr.io/subicura/echo:v2
    Port:         <none>
    Host Port:    <none>
    Environment:  <none>
    Mounts:       <none>
  Volumes:        <none>
Conditions:
  Type           Status  Reason
  ----           ------  ------
  Available      True    MinimumReplicasAvailable
  Progressing    True    NewReplicaSetAvailable
OldReplicaSets:  <none>
NewReplicaSet:   echo-deploy-58cfb87569 (4/4 replicas created)
Events:
  Type    Reason             Age    From                   Message
  ----    ------             ----   ----                   -------
  Normal  ScalingReplicaSet  7m51s  deployment-controller  Scaled up replica set echo-deploy-68b9dfd874 to 4
  Normal  ScalingReplicaSet  5m10s  deployment-controller  Scaled up replica set echo-deploy-58cfb87569 to 1
  Normal  ScalingReplicaSet  5m10s  deployment-controller  Scaled down replica set echo-deploy-68b9dfd874 to 3 from 4
  Normal  ScalingReplicaSet  5m10s  deployment-controller  Scaled up replica set echo-deploy-58cfb87569 to 2 from 1
  Normal  ScalingReplicaSet  5m5s   deployment-controller  Scaled down replica set echo-deploy-68b9dfd874 to 2 from 3
  Normal  ScalingReplicaSet  5m5s   deployment-controller  Scaled up replica set echo-deploy-58cfb87569 to 3 from 2
  Normal  ScalingReplicaSet  5m5s   deployment-controller  Scaled down replica set echo-deploy-68b9dfd874 to 1 from 2
  Normal  ScalingReplicaSet  5m5s   deployment-controller  Scaled up replica set echo-deploy-58cfb87569 to 4 from 3
  Normal  ScalingReplicaSet  5m4s   deployment-controller  Scaled down replica set echo-deploy-68b9dfd874 to 0 from 1
```
