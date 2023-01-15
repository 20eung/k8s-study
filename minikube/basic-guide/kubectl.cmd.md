> https://subicura.com/k8s/guide/kubectl.html

## kubectl 명령어

### apply : 원하는 상태를 적용합니다. 보통 -f 옵션으로 파일과 함께 사용합니다.

> kubectl apply -f [파일명 또는 URL]
```
kubectl apply -f echo-pod.yml
kubectl apply -f https://subicura.com/k8s/code/guide/index/wordpress-k8s.yml
```

### config : kubectl 설정을 관리합니다.

```
# 현재 컨텍스트 확인
kubectl config current-context

# 컨텍스트 설정
kubectl config use-context minikube
```

### delete : 리소스를 제거합니다.

> kubectl delete [TYPE]/[NAME] 또는 [TYPE] [NAME]
```
kubectl delete -f echo-pod.yml
kubectl delete pod/echo
```

### describe : 리소스의 상태를 자세하게 보여줍니다.

> kubectl describe [TYPE]/[NAME] 또는 [TYPE] [NAME]
```
kubectl describe ep/redis
kubectl describe pod/echo
```

### exec : 컨테이너에 명령어를 전달합니다. 컨테이너에 접근할 때 주로 사용합니다.

> kubectl exec [-it] [POD_NAME] -- [COMMAND]

쉘로 접속하여 컨테이너 상태를 확인하는 경우에 -it 옵션을 사용하고

여러 개의 컨테이너가 있는 경우엔 -c 옵션으로 컨테이너를 지정합니다.
```
kubectl exec -it counter -c app -- sh
kubectl exec -it echo -- sh
```

### get : 리소스 목록을 보여줍니다.

> kubectl get [TYPE]
```
# Pod, ReplicaSet, Deployment, Service, Job 조회 => all
kubectl get all

# EndPoint 줄임말과 복수형 조회
kubectl get endpoints
kubectl get ep

# Pod 조회
kubectl get pod
kubectl get pod/echo-lp

# 줄임말(Shortname), 여러 TYPE 입력
kubectl get po,rs,svc

# Label 조회
kubectl get pod --show-labels

# Service 조회
kubectl get svc

# 결과 포멧 변경
kubectl get pod -o wide
kubectl get pod -o yaml
kubectl get pod -o  json
```

### label : 

```
kubectl label pod/echo-rs-4669t app-
kubectl label pod/echo-rs-4669t app=echo
```

### logs : 컨테이너의 로그를 봅니다.

> kubectl logs [POD_NAME]
```
# 특정 Pod 로그 조회
kubectl logs counter
kubectl logs counter app

# 실시간 로그 보기
kubectl logs -f echo
```

### run : 

```
kubectl run echo --image ghcr.io/subicura/echo:v1
```
