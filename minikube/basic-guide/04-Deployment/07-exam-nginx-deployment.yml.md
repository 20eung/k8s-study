> 출처: https://subicura.com/k8s/guide/deployment.html#문제

## 문제3: 이미지를 nginx:1.19.5로 변경합니다

> 다음 조건을 만족하는 Deployment를 만드세요.

| 키                  | 값           |
|---------------------|--------------|
| Deployment 이름     | nginx        |
| Deployment Label    | app: nginx   |
| Deployment 복제수   | 5            |
| Container 이름      | nginx        |
| Container 이미지    | nginx:1.19.5 |

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx
spec:
  replicas: 5
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
          image: nginx:1.19.5
