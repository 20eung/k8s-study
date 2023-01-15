> 출처: https://subicura.com/k8s/guide/replicaset.html#문제

## 문제

> 다음 조건을 만족하는 ReplicaSet을 만드세요.

| 키                  | 값           |
|---------------------|--------------|
| ReplicaSet 이름     | nginx        |
| ReplicaSet selector | app: nginx  |
| ReplicaSet  복제수  |	3            |
| Container 이름      | nginx        |
| Container 이미지    | nginx:latest |

```
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: nginx
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
        - name: nginx
          image: nginx:latest
```