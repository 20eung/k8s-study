> 출처: https://subicura.com/k8s/guide/deployment.html#문제

## 문제1 : 

echo 서비스를 NodePort로 32000 포트로 오픈합니다.

| 키                  | 값           |
|---------------------|--------------|
| Deployment 이름     | echo         |
| Deployment Label    | app: echo    |
| Deployment 복제수   | 3             |
| Container 이름      | echo          |
| Container 이미지    | ghcr.io/subicura/echo:v1 |
| NodePort 이름       | echo          |
| NodePort Port       | 3000         |
| NodePort NodePort   | 32000        |

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: echo
spec:
  replicas: 3
  selector:
    matchLabels:
      app: echo
  template:
    metadata:
      labels:
        app: echo
    spec:
      containers:
        - name: echo
          image: ghcr.io/subicura/echo:v2

---
apiVersion: v1
kind: Service
metadata:
  name: echo
spec:
  type: NodePort
  ports:
    - port: 3000
      protocol: TCP
      nodePort: 32000
  selector:
    app: echo
```