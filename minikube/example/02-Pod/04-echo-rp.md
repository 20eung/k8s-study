## ReadinessProbe YAML 파일 작성

> $ vi 6-echo-rp.yml
```
apiVersion: v1
kind: Pod
metadata:
  name: echo-rp
  labels:
    app: echo
spec:
  containers:
    - name: app
      image: ghcr.io/subicura/echo:v1
      readinessProbe:
        httpGet:
          path: /not/exist
          port: 8080
        initialDelaySeconds: 5
        timeoutSeconds: 2   # Default 1
        periodSeconds: 5    # Default 10
        failureThreshold: 1 # Default 3
```

## Pod 생성

> $ kubectl apply -f 6-echo-rp.yml
```
pod/echo-rp created
```

## Pod 상태 확인

> $ kubectl get pod
```
NAME      READY   STATUS    RESTARTS     AGE
echo-rp   0/1     Running   0          8s
```

## Pod 상태 확인

> $ kubectl get pod/echo-rp
```
NAME      READY   STATUS    RESTARTS     AGE
echo-rp   0/1     Running   0          14s
```

## Pod 제거

> $ kubectl delete -f 6-echo-rp.yml
```
pod "echo-rp" deleted
```