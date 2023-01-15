## libenessProbe YAML 파일 작성

> $ vi 03-echo-lp.yml
```
apiVersion: v1
kind: Pod
metadata:
  name: echo-lp
  labels:
    app: echo
spec:
  containers:
    - name: app
      image: ghcr.io/subicura/echo:v1
      livenessProbe:
        httpGet:
          path: /not/exist
          port: 8080
        initialDelaySeconds: 5
        timeoutSeconds: 2   # Default 1
        periodSeconds: 5    # Default 10
        failureThreshold: 1 # Default 3
```

## Pod 생성

> $ kubectl apply -f 4-echo-lp.yml
```
pod/echo-lp created
```

## Pod 상태 확인

> $ kubectl get pod/echo-lp
```
NAME      READY   STATUS    RESTARTS     AGE
echo-lp   1/1     Running   1 (8s ago)   18s
```

## Pod 상태 확인

> $ kubectl get pod/echo-lp
```
NAME      READY   STATUS    RESTARTS     AGE
echo-lp   1/1     Running   3 (2s ago)   32s
```

## Pod 상태 확인

> $ kubectl get pod/echo-lp
```
NAME      READY   STATUS             RESTARTS     AGE
echo-lp   0/1     CrashLoopBackOff   3 (7s ago)   47s
```

## Pod 제거

> $ kubectl delete -f 4-echo-lp.yml
```
pod "echo-lp" deleted
```