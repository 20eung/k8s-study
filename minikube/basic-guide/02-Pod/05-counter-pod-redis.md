> 출처: https://subicura.com/k8s/guide/pod.html#다중-컨테이너

## 다중 컨테이너 YAML 파일 작성

> $ vi 05-counter-pod-redis.yml
```
apiVersion: v1
kind: Pod
metadata:
  name: counter
  labels:
    app: counter
spec:
  containers:
    - name: app
      image: ghcr.io/subicura/counter:latest
      env:
        - name: REDIS_HOST
          value: "localhost"
    - name: db
      image: redis
```

## Pod 생성

> $ kubectl apply -f 05-counter-pod-redis.yml
```
pod/counter created
```

## Pod 상태 확인

> $ kubectl get pod
```
NAME      READY   STATUS              RESTARTS   AGE
counter   0/2     ContainerCreating   0          8s
```

## Pod 상태 확인

> $ kubectl get pod/counter
```
NAME      READY   STATUS    RESTARTS   AGE
counter   2/2     Running   0          20s
```

## 단일 Pod 상태 확인

> $ kubectl describe pod/counter
```
Name:             counter
Namespace:        default
Priority:         0
Service Account:  default
Node:             gcpmc/10.234.5.67
Start Time:       Mon, 09 Jan 2023 00:34:25 +0900
Labels:           app=counter
Annotations:      <none>
Status:           Running
IP:               10.42.0.24
IPs:
  IP:  10.42.0.24
Containers:
  app:
    Container ID:   containerd://93ecf48fdaf19c2b6d9368ae1a00a68a295d970a17c30925703ff8862e83e5c7
    Image:          ghcr.io/subicura/counter:latest
    Image ID:       ghcr.io/subicura/counter@sha256:2ef3130c96dc04593fc58df753c059d8aedcc6be03e83d2bfd470bf268a00844
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Mon, 09 Jan 2023 00:34:31 +0900
    Ready:          True
    Restart Count:  0
    Environment:
      REDIS_HOST:  localhost
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-2f6zn (ro)
  db:
    Container ID:   containerd://7841d26d972b1436ba2d2947c453fcb1e7271540a8939d7bd5a5bb87fd11f177
    Image:          redis
    Image ID:       docker.io/library/redis@sha256:8184cfe57f205ab34c62bd0e9552dffeb885d2a7f82ce4295c0df344cb6f0007
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Mon, 09 Jan 2023 00:34:38 +0900
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-2f6zn (ro)
Conditions:
  Type              Status
  Initialized       True
  Ready             True
  ContainersReady   True
  PodScheduled      True
Volumes:
  kube-api-access-2f6zn:
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
  Normal  Scheduled  31s   default-scheduler  Successfully assigned default/counter to gcpmc
  Normal  Pulling    31s   kubelet            Pulling image "ghcr.io/subicura/counter:latest"
  Normal  Pulled     26s   kubelet            Successfully pulled image "ghcr.io/subicura/counter:latest" in 5.139486788s
  Normal  Created    26s   kubelet            Created container app
  Normal  Started    26s   kubelet            Started container app
  Normal  Pulling    26s   kubelet            Pulling image "redis"
  Normal  Pulled     19s   kubelet            Successfully pulled image "redis" in 6.400923413s
  Normal  Created    19s   kubelet            Created container db
  Normal  Started    19s   kubelet            Started container db
```

## Pod 로그 확인

> $ kubectl logs counter
```
Defaulted container "app" out of: app, db
{"level":30,"time":1673192072216,"pid":7,"hostname":"counter","msg":"Server listening at http://0.0.0.0:3000"}
Redis Client Error Error: connect ECONNREFUSED 127.0.0.1:6379
    at TCPConnectWrap.afterConnect [as oncomplete] (node:net:1157:16) {
  errno: -111,
  code: 'ECONNREFUSED',
  syscall: 'connect',
  address: '127.0.0.1',
  port: 6379
}
Redis Client Error Error: connect ECONNREFUSED 127.0.0.1:6379
    at TCPConnectWrap.afterConnect [as oncomplete] (node:net:1157:16) {
  errno: -111,
  code: 'ECONNREFUSED',
  syscall: 'connect',
  address: '127.0.0.1',
  port: 6379
}
Redis Client Error Error: connect ECONNREFUSED 127.0.0.1:6379
    at TCPConnectWrap.afterConnect [as oncomplete] (node:net:1157:16) {
  errno: -111,
  code: 'ECONNREFUSED',
  syscall: 'connect',
  address: '127.0.0.1',
  port: 6379
}
Redis Client Error Error: connect ECONNREFUSED 127.0.0.1:6379
    at TCPConnectWrap.afterConnect [as oncomplete] (node:net:1157:16) {
  errno: -111,
  code: 'ECONNREFUSED',
  syscall: 'connect',
  address: '127.0.0.1',
  port: 6379
}
Redis Client Error Error: connect ECONNREFUSED 127.0.0.1:6379
    at TCPConnectWrap.afterConnect [as oncomplete] (node:net:1157:16) {
  errno: -111,
  code: 'ECONNREFUSED',
  syscall: 'connect',
  address: '127.0.0.1',
  port: 6379
}
Redis Client Error Error: connect ECONNREFUSED 127.0.0.1:6379
    at TCPConnectWrap.afterConnect [as oncomplete] (node:net:1157:16) {
  errno: -111,
  code: 'ECONNREFUSED',
  syscall: 'connect',
  address: '127.0.0.1',
  port: 6379
}
Redis Client Error Error: connect ECONNREFUSED 127.0.0.1:6379
    at TCPConnectWrap.afterConnect [as oncomplete] (node:net:1157:16) {
  errno: -111,
  code: 'ECONNREFUSED',
  syscall: 'connect',
  address: '127.0.0.1',
  port: 6379
}
Redis Client Error Error: connect ECONNREFUSED 127.0.0.1:6379
    at TCPConnectWrap.afterConnect [as oncomplete] (node:net:1157:16) {
  errno: -111,
  code: 'ECONNREFUSED',
  syscall: 'connect',
  address: '127.0.0.1',
  port: 6379
}
Redis Client Error Error: connect ECONNREFUSED 127.0.0.1:6379
    at TCPConnectWrap.afterConnect [as oncomplete] (node:net:1157:16) {
  errno: -111,
  code: 'ECONNREFUSED',
  syscall: 'connect',
  address: '127.0.0.1',
  port: 6379
}
Redis Client Error Error: connect ECONNREFUSED 127.0.0.1:6379
    at TCPConnectWrap.afterConnect [as oncomplete] (node:net:1157:16) {
  errno: -111,
  code: 'ECONNREFUSED',
  syscall: 'connect',
  address: '127.0.0.1',
  port: 6379
}
Redis Client Error Error: connect ECONNREFUSED 127.0.0.1:6379
    at TCPConnectWrap.afterConnect [as oncomplete] (node:net:1157:16) {
  errno: -111,
  code: 'ECONNREFUSED',
  syscall: 'connect',
  address: '127.0.0.1',
  port: 6379
}
Redis Client Error Error: connect ECONNREFUSED 127.0.0.1:6379
    at TCPConnectWrap.afterConnect [as oncomplete] (node:net:1157:16) {
  errno: -111,
  code: 'ECONNREFUSED',
  syscall: 'connect',
  address: '127.0.0.1',
  port: 6379
}
Redis Client Error Error: connect ECONNREFUSED 127.0.0.1:6379
    at TCPConnectWrap.afterConnect [as oncomplete] (node:net:1157:16) {
  errno: -111,
  code: 'ECONNREFUSED',
  syscall: 'connect',
  address: '127.0.0.1',
  port: 6379
}
Redis Client Error Error: connect ECONNREFUSED 127.0.0.1:6379
    at TCPConnectWrap.afterConnect [as oncomplete] (node:net:1157:16) {
  errno: -111,
  code: 'ECONNREFUSED',
  syscall: 'connect',
  address: '127.0.0.1',
  port: 6379
}
Redis Client Error Error: connect ECONNREFUSED 127.0.0.1:6379
    at TCPConnectWrap.afterConnect [as oncomplete] (node:net:1157:16) {
  errno: -111,
  code: 'ECONNREFUSED',
  syscall: 'connect',
  address: '127.0.0.1',
  port: 6379
}
Redis Client Error Error: connect ECONNREFUSED 127.0.0.1:6379
    at TCPConnectWrap.afterConnect [as oncomplete] (node:net:1157:16) {
  errno: -111,
  code: 'ECONNREFUSED',
  syscall: 'connect',
  address: '127.0.0.1',
  port: 6379
}
Redis Client Error Error: connect ECONNREFUSED 127.0.0.1:6379
    at TCPConnectWrap.afterConnect [as oncomplete] (node:net:1157:16) {
  errno: -111,
  code: 'ECONNREFUSED',
  syscall: 'connect',
  address: '127.0.0.1',
  port: 6379
}
Redis Client Error Error: connect ECONNREFUSED 127.0.0.1:6379
    at TCPConnectWrap.afterConnect [as oncomplete] (node:net:1157:16) {
  errno: -111,
  code: 'ECONNREFUSED',
  syscall: 'connect',
  address: '127.0.0.1',
  port: 6379
}
{"level":30,"time":1673192078519,"pid":7,"hostname":"counter","msg":"server listening on http://0.0.0.0:3000"}
```

## Pod 로그 확인

> $ kubectl logs counter app
```
{"level":30,"time":1673192072216,"pid":7,"hostname":"counter","msg":"Server listening at http://0.0.0.0:3000"}
Redis Client Error Error: connect ECONNREFUSED 127.0.0.1:6379
    at TCPConnectWrap.afterConnect [as oncomplete] (node:net:1157:16) {
  errno: -111,
  code: 'ECONNREFUSED',
  syscall: 'connect',
  address: '127.0.0.1',
  port: 6379
}
Redis Client Error Error: connect ECONNREFUSED 127.0.0.1:6379
    at TCPConnectWrap.afterConnect [as oncomplete] (node:net:1157:16) {
  errno: -111,
  code: 'ECONNREFUSED',
  syscall: 'connect',
  address: '127.0.0.1',
  port: 6379
}
Redis Client Error Error: connect ECONNREFUSED 127.0.0.1:6379
    at TCPConnectWrap.afterConnect [as oncomplete] (node:net:1157:16) {
  errno: -111,
  code: 'ECONNREFUSED',
  syscall: 'connect',
  address: '127.0.0.1',
  port: 6379
}
Redis Client Error Error: connect ECONNREFUSED 127.0.0.1:6379
    at TCPConnectWrap.afterConnect [as oncomplete] (node:net:1157:16) {
  errno: -111,
  code: 'ECONNREFUSED',
  syscall: 'connect',
  address: '127.0.0.1',
  port: 6379
}
Redis Client Error Error: connect ECONNREFUSED 127.0.0.1:6379
    at TCPConnectWrap.afterConnect [as oncomplete] (node:net:1157:16) {
  errno: -111,
  code: 'ECONNREFUSED',
  syscall: 'connect',
  address: '127.0.0.1',
  port: 6379
}
Redis Client Error Error: connect ECONNREFUSED 127.0.0.1:6379
    at TCPConnectWrap.afterConnect [as oncomplete] (node:net:1157:16) {
  errno: -111,
  code: 'ECONNREFUSED',
  syscall: 'connect',
  address: '127.0.0.1',
  port: 6379
}
Redis Client Error Error: connect ECONNREFUSED 127.0.0.1:6379
    at TCPConnectWrap.afterConnect [as oncomplete] (node:net:1157:16) {
  errno: -111,
  code: 'ECONNREFUSED',
  syscall: 'connect',
  address: '127.0.0.1',
  port: 6379
}
Redis Client Error Error: connect ECONNREFUSED 127.0.0.1:6379
    at TCPConnectWrap.afterConnect [as oncomplete] (node:net:1157:16) {
  errno: -111,
  code: 'ECONNREFUSED',
  syscall: 'connect',
  address: '127.0.0.1',
  port: 6379
}
Redis Client Error Error: connect ECONNREFUSED 127.0.0.1:6379
    at TCPConnectWrap.afterConnect [as oncomplete] (node:net:1157:16) {
  errno: -111,
  code: 'ECONNREFUSED',
  syscall: 'connect',
  address: '127.0.0.1',
  port: 6379
}
Redis Client Error Error: connect ECONNREFUSED 127.0.0.1:6379
    at TCPConnectWrap.afterConnect [as oncomplete] (node:net:1157:16) {
  errno: -111,
  code: 'ECONNREFUSED',
  syscall: 'connect',
  address: '127.0.0.1',
  port: 6379
}
Redis Client Error Error: connect ECONNREFUSED 127.0.0.1:6379
    at TCPConnectWrap.afterConnect [as oncomplete] (node:net:1157:16) {
  errno: -111,
  code: 'ECONNREFUSED',
  syscall: 'connect',
  address: '127.0.0.1',
  port: 6379
}
Redis Client Error Error: connect ECONNREFUSED 127.0.0.1:6379
    at TCPConnectWrap.afterConnect [as oncomplete] (node:net:1157:16) {
  errno: -111,
  code: 'ECONNREFUSED',
  syscall: 'connect',
  address: '127.0.0.1',
  port: 6379
}
Redis Client Error Error: connect ECONNREFUSED 127.0.0.1:6379
    at TCPConnectWrap.afterConnect [as oncomplete] (node:net:1157:16) {
  errno: -111,
  code: 'ECONNREFUSED',
  syscall: 'connect',
  address: '127.0.0.1',
  port: 6379
}
Redis Client Error Error: connect ECONNREFUSED 127.0.0.1:6379
    at TCPConnectWrap.afterConnect [as oncomplete] (node:net:1157:16) {
  errno: -111,
  code: 'ECONNREFUSED',
  syscall: 'connect',
  address: '127.0.0.1',
  port: 6379
}
Redis Client Error Error: connect ECONNREFUSED 127.0.0.1:6379
    at TCPConnectWrap.afterConnect [as oncomplete] (node:net:1157:16) {
  errno: -111,
  code: 'ECONNREFUSED',
  syscall: 'connect',
  address: '127.0.0.1',
  port: 6379
}
Redis Client Error Error: connect ECONNREFUSED 127.0.0.1:6379
    at TCPConnectWrap.afterConnect [as oncomplete] (node:net:1157:16) {
  errno: -111,
  code: 'ECONNREFUSED',
  syscall: 'connect',
  address: '127.0.0.1',
  port: 6379
}
Redis Client Error Error: connect ECONNREFUSED 127.0.0.1:6379
    at TCPConnectWrap.afterConnect [as oncomplete] (node:net:1157:16) {
  errno: -111,
  code: 'ECONNREFUSED',
  syscall: 'connect',
  address: '127.0.0.1',
  port: 6379
}
Redis Client Error Error: connect ECONNREFUSED 127.0.0.1:6379
    at TCPConnectWrap.afterConnect [as oncomplete] (node:net:1157:16) {
  errno: -111,
  code: 'ECONNREFUSED',
  syscall: 'connect',
  address: '127.0.0.1',
  port: 6379
}
{"level":30,"time":1673192078519,"pid":7,"hostname":"counter","msg":"server listening on http://0.0.0.0:3000"}
```

## Pod 로그 확인

> $ kubectl logs counter db
```
1:C 08 Jan 2023 15:34:38.134 # oO0OoO0OoO0Oo Redis is starting oO0OoO0OoO0Oo
1:C 08 Jan 2023 15:34:38.134 # Redis version=7.0.7, bits=64, commit=00000000, modified=0, pid=1, just started
1:C 08 Jan 2023 15:34:38.134 # Warning: no config file specified, using the default config. In order to specify a config file use redis-server /path/to/redis.conf
1:M 08 Jan 2023 15:34:38.135 * monotonic clock: POSIX clock_gettime
1:M 08 Jan 2023 15:34:38.138 * Running mode=standalone, port=6379.
1:M 08 Jan 2023 15:34:38.138 # Server initialized
1:M 08 Jan 2023 15:34:38.139 * Ready to accept connections
```

## Pod의 app 컨테이너 접속

> $ kubectl exec -it counter -c app -- sh
```
/app # curl localhost:3000
1

/app # curl localhost:3000
2

/app # telnet localhost 6379
Connected to localhost
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
$
```

## Pod 제거

> $ kubectl delete -f 05-counter-pod-redis.yml
```
pod "counter" deleted
```