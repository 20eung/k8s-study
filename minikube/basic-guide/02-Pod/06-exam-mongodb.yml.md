> 출처: https://subicura.com/k8s/guide/pod.html#실습

## 실습 1

> 다음 조건을 만족하는 Pod을 만드세요.

| Key              | Value   |
|------------------|---------|
| Pod 이름         | mongodb |
| Container 이름   | mongodb |
| Container 이미지 | mongo:4 |

```
apiVersion: v1
kind: Pod
metadata:
  name: mongodb
  labels:
    app: mongo
spec:
  containers:
    - name: mongodb
      image: mongo:4
```