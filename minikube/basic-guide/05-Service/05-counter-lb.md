> 출처: https://subicura.com/k8s/guide/service.html#service-loadbalancer-만들기

## Service(LoadBalancer) 만들기

> $ vi 05-counter-lb.yml
```
apiVersion: v1
kind: Service
metadata:
  name: counter-lb
spec:
  type: LoadBalancer
  ports:
    - port: 30000
      targetPort: 3000
      protocol: TCP
  selector:
    app: counter
    tier: app
```

> $ kubectl apply -f 05-counter-lb.yml
```
service/counter-lb created
```

## Service 상태 확인

> $ kubectl get svc
```
NAME         TYPE           CLUSTER-IP     EXTERNAL-IP   PORT(S)           AGE
kubernetes   ClusterIP      10.43.0.1      <none>        443/TCP           2d4h
redis        ClusterIP      10.43.30.147   <none>        6379/TCP          27h
counter-np   NodePort       10.43.95.3     <none>        3000:31000/TCP    11m
counter-lb   LoadBalancer   10.43.18.112   10.234.5.67   30000:30683/TCP   46s
```

## Pod, ReplicaSet, Deployment, Service 상태 확인

> $ kubectl get all
```
NAME                          READY   STATUS    RESTARTS   AGE
pod/redis-5cb78b9855-whpz7    1/1     Running   0          27h
pod/counter-985748f4c-jm96n   1/1     Running   0          27h

NAME                 TYPE           CLUSTER-IP     EXTERNAL-IP   PORT(S)           AGE
service/kubernetes   ClusterIP      10.43.0.1      <none>        443/TCP           2d4h
service/redis        ClusterIP      10.43.30.147   <none>        6379/TCP          27h
service/counter-np   NodePort       10.43.95.3     <none>        3000:31000/TCP    10m
service/counter-lb   LoadBalancer   10.43.18.112   10.234.5.67   30000:30683/TCP   5s

NAME                      READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/redis     1/1     1            1           27h
deployment.apps/counter   1/1     1            1           27h

NAME                                DESIRED   CURRENT   READY   AGE
replicaset.apps/redis-5cb78b9855    1         1         1       27h
replicaset.apps/counter-985748f4c   1         1         1       27h
```

## minikube에 가상 LoadBalancer 만들기

> $ minikube addons enable metallb
```
❗  metallb is a 3rd party addon and is not maintained or verified by minikube maintainers, enable at your own risk.
❗  metallb does not currently have an associated maintainer.
    ▪ Using image docker.io/metallb/speaker:v0.9.6
    ▪ Using image docker.io/metallb/controller:v0.9.6
🌟  The 'metallb' addon is enabled
```

## minikube IP 확인

> $ minikube ip
```
192.168.49.2
```

## metallb 설정

> $ minikube addons configure metallb
```
-- Enter Load Balancer Start IP: 192.168.49.2 # minikube ip
-- Enter Load Balancer End IP: 192.168.49.2   # minikube ip
    ▪ Using image docker.io/metallb/speaker:v0.9.6
    ▪ Using image docker.io/metallb/controller:v0.9.6
✅  metallb was successfully configured
```

## minikube를 사용하지 않고 직접 ConfigMap 작성 방법

> $ vi 06-metallb-cm.yml
```
apiVersion: v1
kind: ConfigMap
metadata:
  namespace: metallb-system
  name: config
data:
  config: |
    address-pools:
    - name: default
      protocol: layer2
      addresses:
      - 192.168.49.2 # minikube ip
```

> $ kubectl apply -f 06-metallb-cm.yml
```
Error from server (BadRequest): error when creating "09-metallb-cm.yml": ConfigMap in version "v1" cannot be handled as a ConfigMap: json: cannot unmarshal object into Go struct field ConfigMap.data of type string
```

## 다시 서비스 확인

> $ kubectl get svc
```
NAME         TYPE           CLUSTER-IP     EXTERNAL-IP   PORT(S)           AGE
kubernetes   ClusterIP      10.43.0.1      <none>        443/TCP           2d4h
redis        ClusterIP      10.43.30.147   <none>        6379/TCP          27h
counter-np   NodePort       10.43.95.3     <none>        3000:31000/TCP    18m
counter-lb   LoadBalancer   10.43.18.112   10.234.5.67   30000:30683/TCP   7m47s
```

## counter lb 접근

> $ curl 10.234.5.67:30000
```
6
```

## Docker driver를 사용중이라면

> $ minikube service counter-lb
```
💣  Failed to get service URL: client: client config: context "minikube" does not exist
📌  Check that minikube is running and that you have specified the correct namespace (-n flag) if required.
```