kubectl apply -f echo-pod.yml

kubectl delete -f echo-pod.yml
kubectl delete pod/echo

kubectl describe ep/redis
kubectl describe pod/echo

kubectl exec -it counter -c app -- sh
kubectl exec -it echo -- sh

kubectl get all
kubectl get endpoints
kubectl get ep
kubectl get pod
kubectl get pod/echo-lp
kubectl get po,rs
kubectl get pod --show-labels
kubectl get svc

kubectl label pod/echo-rs-4669t app-
kubectl label pod/echo-rs-4669t app=echo

kubectl logs -f echo
kubectl logs counter
kubectl logs counter app

kubectl run echo --image ghcr.io/subicura/echo:v1

