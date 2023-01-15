## libenessProbe YAML 파일 작성

> $ vi 4-echo-lp.yml

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