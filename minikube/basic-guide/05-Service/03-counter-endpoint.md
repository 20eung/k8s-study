> 출처: https://subicura.com/k8s/guide/service.html#service-생성-흐름

## Endpoint의 상태를 확인

> $ kubectl get endpoints
```
NAME         ENDPOINTS          AGE
kubernetes   10.234.5.67:6443   25h
redis        10.42.0.57:6379    11m
```

> $ kubectl get ep
```
NAME         ENDPOINTS          AGE
kubernetes   10.234.5.67:6443   25h
redis        10.42.0.57:6379    12m
```

## redis Endpoint 확인

> $ kubectl describe ep/redis
```
Name:         redis
Namespace:    default
Labels:       <none>
Annotations:  endpoints.kubernetes.io/last-change-trigger-time: 2023-01-09T09:56:25Z
Subsets:
  Addresses:          10.42.0.57
  NotReadyAddresses:  <none>
  Ports:
    Name     Port  Protocol
    ----     ----  --------
    <unset>  6379  TCP

Events:  <none>
```