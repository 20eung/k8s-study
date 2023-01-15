> 출처: https://potato-yong.tistory.com/128

## Kube-prometheus 설치

1. git clone으로 kube-prometheus 레포지토리를 로컬에 받아준다
> $ git clone https://github.com/coreos/kube-prometheus.git
```
Cloning into 'kube-prometheus'...
remote: Enumerating objects: 17470, done.
remote: Counting objects: 100% (23/23), done.
remote: Compressing objects: 100% (21/21), done.
remote: Total 17470 (delta 5), reused 3 (delta 1), pack-reused 17447
Receiving objects: 100% (17470/17470), 9.05 MiB | 7.15 MiB/s, done.
Resolving deltas: 100% (11503/11503), done.
```

> $ ls -l
```
total 16
drwxrwxr-x  3 ubuntu ubuntu 4096 Jan 15 17:34 ./
drwxrwxr-x  3 ubuntu ubuntu 4096 Jan 15 17:31 ../
-rw-rw-r--  1 ubuntu ubuntu  134 Jan 15 17:33 README.md
drwxrwxr-x 12 ubuntu ubuntu 4096 Jan 15 17:35 kube-prometheus/
```

> $ cd kube-prometheus
> $ ls -l
```
total 220
drwxrwxr-x 12 ubuntu ubuntu  4096 Jan 15 17:35 ./
drwxrwxr-x  3 ubuntu ubuntu  4096 Jan 15 17:34 ../
drwxrwxr-x  8 ubuntu ubuntu  4096 Jan 15 17:35 .git/
drwxrwxr-x  4 ubuntu ubuntu  4096 Jan 15 17:35 .github/
-rw-rw-r--  1 ubuntu ubuntu   141 Jan 15 17:35 .gitignore
-rw-rw-r--  1 ubuntu ubuntu  1474 Jan 15 17:35 .gitpod.yml
-rw-rw-r--  1 ubuntu ubuntu   221 Jan 15 17:35 .mdox.validate.yaml
-rw-rw-r--  1 ubuntu ubuntu 11421 Jan 15 17:35 CHANGELOG.md
-rw-rw-r--  1 ubuntu ubuntu  3782 Jan 15 17:35 CONTRIBUTING.md
-rw-rw-r--  1 ubuntu ubuntu 11325 Jan 15 17:35 LICENSE
-rw-rw-r--  1 ubuntu ubuntu  3379 Jan 15 17:35 Makefile
-rw-rw-r--  1 ubuntu ubuntu  8533 Jan 15 17:35 README.md
-rw-rw-r--  1 ubuntu ubuntu  4463 Jan 15 17:35 RELEASE.md
-rwxrwxr-x  1 ubuntu ubuntu   679 Jan 15 17:35 build.sh*
-rw-rw-r--  1 ubuntu ubuntu  2020 Jan 15 17:35 code-of-conduct.md
drwxrwxr-x  5 ubuntu ubuntu  4096 Jan 15 17:35 developer-workspace/
drwxrwxr-x  4 ubuntu ubuntu  4096 Jan 15 17:35 docs/
-rw-rw-r--  1 ubuntu ubuntu  2273 Jan 15 17:35 example.jsonnet
drwxrwxr-x  7 ubuntu ubuntu  4096 Jan 15 17:35 examples/
drwxrwxr-x  3 ubuntu ubuntu  4096 Jan 15 17:35 experimental/
-rw-rw-r--  1 ubuntu ubuntu  2127 Jan 15 17:35 go.mod
-rw-rw-r--  1 ubuntu ubuntu 66474 Jan 15 17:35 go.sum
drwxrwxr-x  3 ubuntu ubuntu  4096 Jan 15 17:35 jsonnet/
-rw-rw-r--  1 ubuntu ubuntu   206 Jan 15 17:35 jsonnetfile.json
-rw-rw-r--  1 ubuntu ubuntu  5109 Jan 15 17:35 jsonnetfile.lock.json
-rw-rw-r--  1 ubuntu ubuntu  1807 Jan 15 17:35 kubescape-exceptions.json
-rw-rw-r--  1 ubuntu ubuntu  4773 Jan 15 17:35 kustomization.yaml
drwxrwxr-x  3 ubuntu ubuntu  4096 Jan 15 17:35 manifests/
drwxrwxr-x  2 ubuntu ubuntu  4096 Jan 15 17:35 scripts/
drwxrwxr-x  3 ubuntu ubuntu  4096 Jan 15 17:35 tests/
```

2. 의존성 문제로 인해서 setup 모듈을 먼저 생성한다. 이 모듈은 prometheus 관련 pod들을 생성하기 위한 kubernetes CRD로 만들어져 있다.

> $ kubectl create -f manifests/setup
```
customresourcedefinition.apiextensions.k8s.io/alertmanagerconfigs.monitoring.coreos.com created
customresourcedefinition.apiextensions.k8s.io/alertmanagers.monitoring.coreos.com created
customresourcedefinition.apiextensions.k8s.io/podmonitors.monitoring.coreos.com created
customresourcedefinition.apiextensions.k8s.io/probes.monitoring.coreos.com created
customresourcedefinition.apiextensions.k8s.io/prometheuses.monitoring.coreos.com created
customresourcedefinition.apiextensions.k8s.io/prometheusrules.monitoring.coreos.com created
customresourcedefinition.apiextensions.k8s.io/servicemonitors.monitoring.coreos.com created
customresourcedefinition.apiextensions.k8s.io/thanosrulers.monitoring.coreos.com created
namespace/monitoring created
```

3. 아래의 명령어로 생성이 정상적으로 완료될 때까지 대기할 수 있다.

> $ until kubectl get servicemonitors --all-namespaces ; do date; sleep 1; echo ""; done
```
No resources found
```

4. 매니페스트로 pod 및 service와 같은 리소스들을 생성한다.

> $ kubectl create -f manifests/
```
alertmanager.monitoring.coreos.com/main created
networkpolicy.networking.k8s.io/alertmanager-main created
poddisruptionbudget.policy/alertmanager-main created
prometheusrule.monitoring.coreos.com/alertmanager-main-rules created
secret/alertmanager-main created
service/alertmanager-main created
serviceaccount/alertmanager-main created
servicemonitor.monitoring.coreos.com/alertmanager-main created
clusterrole.rbac.authorization.k8s.io/blackbox-exporter created
clusterrolebinding.rbac.authorization.k8s.io/blackbox-exporter created
configmap/blackbox-exporter-configuration created
deployment.apps/blackbox-exporter created
networkpolicy.networking.k8s.io/blackbox-exporter created
service/blackbox-exporter created
serviceaccount/blackbox-exporter created
servicemonitor.monitoring.coreos.com/blackbox-exporter created
secret/grafana-config created
secret/grafana-datasources created
configmap/grafana-dashboard-alertmanager-overview created
configmap/grafana-dashboard-apiserver created
configmap/grafana-dashboard-cluster-total created
configmap/grafana-dashboard-controller-manager created
configmap/grafana-dashboard-grafana-overview created
configmap/grafana-dashboard-k8s-resources-cluster created
configmap/grafana-dashboard-k8s-resources-namespace created
configmap/grafana-dashboard-k8s-resources-node created
configmap/grafana-dashboard-k8s-resources-pod created
configmap/grafana-dashboard-k8s-resources-workload created
configmap/grafana-dashboard-k8s-resources-workloads-namespace created
configmap/grafana-dashboard-kubelet created
configmap/grafana-dashboard-namespace-by-pod created
configmap/grafana-dashboard-namespace-by-workload created
configmap/grafana-dashboard-node-cluster-rsrc-use created
configmap/grafana-dashboard-node-rsrc-use created
configmap/grafana-dashboard-nodes-darwin created
configmap/grafana-dashboard-nodes created
configmap/grafana-dashboard-persistentvolumesusage created
configmap/grafana-dashboard-pod-total created
configmap/grafana-dashboard-prometheus-remote-write created
configmap/grafana-dashboard-prometheus created
configmap/grafana-dashboard-proxy created
configmap/grafana-dashboard-scheduler created
configmap/grafana-dashboard-workload-total created
configmap/grafana-dashboards created
deployment.apps/grafana created
networkpolicy.networking.k8s.io/grafana created
prometheusrule.monitoring.coreos.com/grafana-rules created
service/grafana created
serviceaccount/grafana created
servicemonitor.monitoring.coreos.com/grafana created
prometheusrule.monitoring.coreos.com/kube-prometheus-rules created
clusterrole.rbac.authorization.k8s.io/kube-state-metrics created
clusterrolebinding.rbac.authorization.k8s.io/kube-state-metrics created
deployment.apps/kube-state-metrics created
networkpolicy.networking.k8s.io/kube-state-metrics created
prometheusrule.monitoring.coreos.com/kube-state-metrics-rules created
service/kube-state-metrics created
serviceaccount/kube-state-metrics created
servicemonitor.monitoring.coreos.com/kube-state-metrics created
prometheusrule.monitoring.coreos.com/kubernetes-monitoring-rules created
servicemonitor.monitoring.coreos.com/kube-apiserver created
servicemonitor.monitoring.coreos.com/coredns created
servicemonitor.monitoring.coreos.com/kube-controller-manager created
servicemonitor.monitoring.coreos.com/kube-scheduler created
servicemonitor.monitoring.coreos.com/kubelet created
clusterrole.rbac.authorization.k8s.io/node-exporter created
clusterrolebinding.rbac.authorization.k8s.io/node-exporter created
daemonset.apps/node-exporter created
networkpolicy.networking.k8s.io/node-exporter created
prometheusrule.monitoring.coreos.com/node-exporter-rules created
service/node-exporter created
serviceaccount/node-exporter created
servicemonitor.monitoring.coreos.com/node-exporter created
clusterrole.rbac.authorization.k8s.io/prometheus-k8s created
clusterrolebinding.rbac.authorization.k8s.io/prometheus-k8s created
networkpolicy.networking.k8s.io/prometheus-k8s created
poddisruptionbudget.policy/prometheus-k8s created
prometheus.monitoring.coreos.com/k8s created
prometheusrule.monitoring.coreos.com/prometheus-k8s-prometheus-rules created
rolebinding.rbac.authorization.k8s.io/prometheus-k8s-config created
rolebinding.rbac.authorization.k8s.io/prometheus-k8s created
rolebinding.rbac.authorization.k8s.io/prometheus-k8s created
rolebinding.rbac.authorization.k8s.io/prometheus-k8s created
role.rbac.authorization.k8s.io/prometheus-k8s-config created
role.rbac.authorization.k8s.io/prometheus-k8s created
role.rbac.authorization.k8s.io/prometheus-k8s created
role.rbac.authorization.k8s.io/prometheus-k8s created
service/prometheus-k8s created
serviceaccount/prometheus-k8s created
servicemonitor.monitoring.coreos.com/prometheus-k8s created
clusterrole.rbac.authorization.k8s.io/prometheus-adapter created
clusterrolebinding.rbac.authorization.k8s.io/prometheus-adapter created
clusterrolebinding.rbac.authorization.k8s.io/resource-metrics:system:auth-delegator created
clusterrole.rbac.authorization.k8s.io/resource-metrics-server-resources created
configmap/adapter-config created
deployment.apps/prometheus-adapter created
networkpolicy.networking.k8s.io/prometheus-adapter created
poddisruptionbudget.policy/prometheus-adapter created
rolebinding.rbac.authorization.k8s.io/resource-metrics-auth-reader created
service/prometheus-adapter created
serviceaccount/prometheus-adapter created
servicemonitor.monitoring.coreos.com/prometheus-adapter created
clusterrole.rbac.authorization.k8s.io/prometheus-operator created
clusterrolebinding.rbac.authorization.k8s.io/prometheus-operator created
deployment.apps/prometheus-operator created
networkpolicy.networking.k8s.io/prometheus-operator created
prometheusrule.monitoring.coreos.com/prometheus-operator-rules created
service/prometheus-operator created
serviceaccount/prometheus-operator created
servicemonitor.monitoring.coreos.com/prometheus-operator created
Error from server (AlreadyExists): error when creating "manifests/prometheusAdapter-apiService.yaml": apiservices.apiregistration.k8s.io "v1beta1.metrics.k8s.io" already exists
Error from server (AlreadyExists): error when creating "manifests/prometheusAdapter-clusterRoleAggregatedMetricsReader.yaml": clusterroles.rbac.authorization.k8s.io "system:aggregated-metrics-reader" already exists
```