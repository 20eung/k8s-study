> 출처: https://subicura.com/k8s/guide/pod.html#yaml로-설정파일spec-작성하기

## echo pod YAML 파일 작성

> $ vi 02-echo-pod.yml
```
apiVersion: v1
kind: Pod
metadata:
  name: echo
  labels:
    app: echo
spec:
  containers:
    - name: app
      image: ghcr.io/subicura/echo:v1
```

### Pod 생성

> $ kubectl apply -f 02-echo-pod.yml
```
pod/echo created
```

### Pod 목록 조회

> $ kubectl get pod
```
NAME   READY   STATUS    RESTARTS   AGE
echo   1/1     Running   0          7s
```

### Pod 로그 확인

> $ kubectl logs echo
```
{"level":30,"time":1673189907363,"pid":7,"hostname":"echo","msg":"Server listening at http://0.0.0.0:3000"}
{"level":30,"time":1673189907363,"pid":7,"hostname":"echo","msg":"server listening on http://0.0.0.0:3000"}
```

## Pod 로그 확인

> $ kubectl logs -f echo
```
{"level":30,"time":1673189907363,"pid":7,"hostname":"echo","msg":"Server listening at http://0.0.0.0:3000"}
{"level":30,"time":1673189907363,"pid":7,"hostname":"echo","msg":"server listening on http://0.0.0.0:3000"}
^C
```

## Pod 컨테이너 접속

> $ kubectl exec -it echo -- sh
```
/app # cd /
/ # ls
app    dev    home   media  opt    root   sbin   sys    usr
bin    etc    lib    mnt    proc   run    srv    tmp    var
/ # ps
PID   USER     TIME  COMMAND
    1 root      0:00 /sbin/tini -- node app.js
    7 root      0:00 node app.js
   14 root      0:00 sh
   22 root      0:00 ps
~ # exit
```

## Pod 제거

> $ kubectl delete -f 02-echo-pod.yml
```
pod "echo" deleted
```