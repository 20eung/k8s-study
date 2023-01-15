> 출처: https://subicura.com/k8s/guide/service.html#service-nodeport-만들기

## NodePort 서비스 만들기

> $ vi 04-counter-nodeport.yml
```
apiVersion: v1
kind: Service
metadata:
  name: counter-np
spec:
  type: NodePort
  ports:
    - port: 3000
      protocol: TCP
      nodePort: 31000
  selector:
    app: counter
    tier: app
```

> $ kubectl apply -f 04-counter-nodeport.yml
```
service/counter-np created
```

## 서비스 상태 확인

> $ kubectl get svc
```
NAME         TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)          AGE
kubernetes   ClusterIP   10.43.0.1      <none>        443/TCP          2d4h
redis        ClusterIP   10.43.30.147   <none>        6379/TCP         27h
counter-np   NodePort    10.43.95.3     <none>        3000:31000/TCP   9s
```

## minikube ip로 테스트 클러스터의 노드 IP를 구하고 31000으로 접근해봅니다.

> $ curl 10.234.5.67:31000
```
3
```

> $ curl 10.234.5.67:31000
```
4
```

> $ curl 10.234.5.67:31000
```
5
```