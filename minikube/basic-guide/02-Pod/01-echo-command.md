> 출처: https://subicura.com/k8s/guide/pod.html#빠르게-pod-만들기

## 빠르게 Pod 만들기

> $ kubectl run echo --image ghcr.io/subicura/echo:v1
```
pod/echo created
```

## Pod 목록 조회

> $ kubectl get pod
```
NAME   READY   STATUS    RESTARTS   AGE
echo   1/1     Running   0          10s
```

## 단일 Pod 상세 확인

> $ kubectl describe pod/echo
```
Name:             echo
Namespace:        default
Priority:         0
Service Account:  default
Node:             gcpmc/10.234.5.67
Start Time:       Sun, 08 Jan 2023 23:54:28 +0900
Labels:           run=echo
Annotations:      <none>
Status:           Running
IP:               10.42.0.19
IPs:
  IP:  10.42.0.19
Containers:
  echo:
    Container ID:   containerd://c2988a83aa376c8f3e588cc95ba3b8a5fc8746efa4cdd321b0bcf1037bdd83fc
    Image:          ghcr.io/subicura/echo:v1
    Image ID:       ghcr.io/subicura/echo@sha256:486ea26869d277e4090812fe5eebb694eb754791bb5568f23983775948eee3c3
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Sun, 08 Jan 2023 23:54:37 +0900
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-9b6b6 (ro)
Conditions:
  Type              Status
  Initialized       True
  Ready             True
  ContainersReady   True
  PodScheduled      True
Volumes:
  kube-api-access-9b6b6:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason     Age   From               Message
  ----    ------     ----  ----               -------
  Normal  Scheduled  28s   default-scheduler  Successfully assigned default/echo to gcpmc
  Normal  Pulling    28s   kubelet            Pulling image "ghcr.io/subicura/echo:v1"
  Normal  Pulled     19s   kubelet            Successfully pulled image "ghcr.io/subicura/echo:v1" in 8.22990468s
  Normal  Created    19s   kubelet            Created container echo
  Normal  Started    19s   kubelet            Started container echo
```

## Pod 제거

> $ kubectl delete pod/echo
```
pod "echo" deleted
```