> 출처: https://subicura.com/k8s/guide/pod.html#컨테이너-상태-모니터링

## livenessProbe + readinessProbe YAML 파일 작성

> $ vi 04-echo-pod-health.yml
```
apiVersion: v1
kind: Pod
metadata:
  name: echo-health
  labels:
    app: echo
spec:
  containers:
    - name: app
      image: ghcr.io/subicura/echo:v1
      livenessProbe:
        httpGet:
          path: /
          port: 3000
      readinessProbe:
        httpGet:
          path: /
          port: 3000
```

## Pod 생성

> $ kubectl apply -f 04-echo-pod-health.yml
```
pod/echo-health created
```

## Pod 상태 확인

> $ kubectl get pod
```
NAME          READY   STATUS    RESTARTS   AGE
echo-health   1/1     Running   0          7s
```

## 단일 Pod 상태 확인

> $ kubectl describe pod/echo-health
```
Name:             echo-health
Namespace:        default
Priority:         0
Service Account:  default
Node:             gcpmc/10.234.5.67
Start Time:       Mon, 09 Jan 2023 00:26:55 +0900
Labels:           app=echo
Annotations:      <none>
Status:           Running
IP:               10.42.0.23
IPs:
  IP:  10.42.0.23
Containers:
  app:
    Container ID:   containerd://7a75ff4e17094e473d2833ee2e03d1e575a32f0bd90ec676619e0d6f0f3fd73d
    Image:          ghcr.io/subicura/echo:v1
    Image ID:       ghcr.io/subicura/echo@sha256:486ea26869d277e4090812fe5eebb694eb754791bb5568f23983775948eee3c3
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Mon, 09 Jan 2023 00:26:56 +0900
    Ready:          True
    Restart Count:  0
    Liveness:       http-get http://:3000/ delay=0s timeout=1s period=10s #success=1 #failure=3
    Readiness:      http-get http://:3000/ delay=0s timeout=1s period=10s #success=1 #failure=3
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-tfgc5 (ro)
Conditions:
  Type              Status
  Initialized       True
  Ready             True
  ContainersReady   True
  PodScheduled      True
Volumes:
  kube-api-access-tfgc5:
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
  Normal  Scheduled  38s   default-scheduler  Successfully assigned default/echo-health to gcpmc
  Normal  Pulled     38s   kubelet            Container image "ghcr.io/subicura/echo:v1" already present on machine
  Normal  Created    38s   kubelet            Created container app
  Normal  Started    38s   kubelet            Started container app
```

## Pod 제거

> $ kubectl delete -f 04-echo-pod-health.yml
```
pod "echo-health" deleted
```