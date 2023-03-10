> 출처: https://subicura.com/k8s/guide/deployment.html#버전관리

## 히스토리 확인

> $ kubectl rollout history deploy/echo-deploy
```
deployment.apps/echo-deploy
REVISION  CHANGE-CAUSE
1         <none>
2         <none>
```

## revision 1 히스토리 상세 확인

> $ kubectl rollout history deploy/echo-deploy --revision=1
```
deployment.apps/echo-deploy with revision #1
Pod Template:
  Labels:       app=echo
        pod-template-hash=68b9dfd874
        tier=app
  Containers:
   echo:
    Image:      ghcr.io/subicura/echo:v1
    Port:       <none>
    Host Port:  <none>
    Environment:        <none>
    Mounts:     <none>
  Volumes:      <none>
```

## 바로 전으로 롤백

> $ kubectl rollout history deploy/echo-deploy --revision=2
```
deployment.apps/echo-deploy with revision #2
Pod Template:
  Labels:       app=echo
        pod-template-hash=58cfb87569
        tier=app
  Containers:
   echo:
    Image:      ghcr.io/subicura/echo:v2
    Port:       <none>
    Host Port:  <none>
    Environment:        <none>
    Mounts:     <none>
  Volumes:      <none>
```

## 바로 전으로 롤백

> $ kubectl rollout undo deploy/echo-deploy
```
deployment.apps/echo-deploy rolled back
```

## 특정 버전으로 롤백

> $ kubectl rollout history deploy/echo-deploy --revision=1
```
error: unable to find the specified revision
```

> $ kubectl rollout history deploy/echo-deploy --revision=2
```
deployment.apps/echo-deploy with revision #2
Pod Template:
  Labels:       app=echo
        pod-template-hash=58cfb87569
        tier=app
  Containers:
   echo:
    Image:      ghcr.io/subicura/echo:v2
    Port:       <none>
    Host Port:  <none>
    Environment:        <none>
    Mounts:     <none>
  Volumes:      <none>
```

## 리소스 확인

> $ kubectl get po,rs,deploy
```
NAME                               READY   STATUS    RESTARTS   AGE
pod/echo-deploy-68b9dfd874-xh4cs   1/1     Running   0          48s
pod/echo-deploy-68b9dfd874-bgswv   1/1     Running   0          48s
pod/echo-deploy-68b9dfd874-m2br4   1/1     Running   0          47s
pod/echo-deploy-68b9dfd874-26mtf   1/1     Running   0          47s

NAME                                     DESIRED   CURRENT   READY   AGE
replicaset.apps/echo-deploy-58cfb87569   0         0         0       8m47s
replicaset.apps/echo-deploy-68b9dfd874   4         4         4       11m

NAME                          READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/echo-deploy   4/4     4            4           11m
```

> $ kubectl describe deploy/echo-deploy
```
Name:                   echo-deploy
Namespace:              default
CreationTimestamp:      Mon, 09 Jan 2023 15:54:22 +0900
Labels:                 <none>
Annotations:            deployment.kubernetes.io/revision: 3
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
    Image:        ghcr.io/subicura/echo:v1
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
NewReplicaSet:   echo-deploy-68b9dfd874 (4/4 replicas created)
Events:
  Type    Reason             Age                From                   Message
  ----    ------             ----               ----                   -------
  Normal  ScalingReplicaSet  12m                deployment-controller  Scaled up replica set echo-deploy-68b9dfd874 to 4
  Normal  ScalingReplicaSet  9m19s              deployment-controller  Scaled up replica set echo-deploy-58cfb87569 to 1
  Normal  ScalingReplicaSet  9m19s              deployment-controller  Scaled down replica set echo-deploy-68b9dfd874 to 3 from 4
  Normal  ScalingReplicaSet  9m19s              deployment-controller  Scaled up replica set echo-deploy-58cfb87569 to 2 from 1
  Normal  ScalingReplicaSet  9m14s              deployment-controller  Scaled down replica set echo-deploy-68b9dfd874 to 2 from 3
  Normal  ScalingReplicaSet  9m14s              deployment-controller  Scaled up replica set echo-deploy-58cfb87569 to 3 from 2
  Normal  ScalingReplicaSet  9m14s              deployment-controller  Scaled down replica set echo-deploy-68b9dfd874 to 1 from 2
  Normal  ScalingReplicaSet  9m14s              deployment-controller  Scaled up replica set echo-deploy-58cfb87569 to 4 from 3
  Normal  ScalingReplicaSet  9m13s              deployment-controller  Scaled down replica set echo-deploy-68b9dfd874 to 0 from 1
  Normal  ScalingReplicaSet  75s (x8 over 80s)  deployment-controller  (combined from similar events): Scaled down replica set echo-deploy-58cfb87569 to 0 from 1
```

> $ kubectl rollout undo deploy/echo-deploy --to-revision=2
```
deployment.apps/echo-deploy rolled back
``` 
 
> $ kubectl get po,rs,deploy
```
NAME                               READY   STATUS    RESTARTS   AGE
pod/echo-deploy-58cfb87569-8cfbh   1/1     Running   0          7s
pod/echo-deploy-58cfb87569-lfswz   1/1     Running   0          7s
pod/echo-deploy-58cfb87569-pvgbl   1/1     Running   0          6s
pod/echo-deploy-58cfb87569-x8bff   1/1     Running   0          5s

NAME                                     DESIRED   CURRENT   READY   AGE
replicaset.apps/echo-deploy-68b9dfd874   0         0         0       12m
replicaset.apps/echo-deploy-58cfb87569   4         4         4       10m

NAME                          READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/echo-deploy   4/4     4            4           12m
```