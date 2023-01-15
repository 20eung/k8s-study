### [ 설치 ] ###
#
# docker 사용시 설치 필요, docker를 사용하지 않는 경우 virtual box 설치
curl -fsSL https://get.docker.com/ | sudo sh
sudo usermod -aG docker $USER

# docker 대신 virtual box 설치
sudo apt-get install virtualbox

# install minikube
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube
sudo mkdir -p /usr/local/bin/
sudo install minikube /usr/local/bin/


### [ 기본 명령어 ] ###
#
# 버전확인
minikube version

# 가상머신 시작
minikube start --driver=docker
# driver 에러가 발생한다면 virtual box를 사용
minikube start --driver=virtualbox
# 특정 k8s 버전 실행
minikube start --kubernetes-version=v1.23.1

# 상태확인
minikube status

# 정지
minikube stop

# 삭제
minikube delete

# ssh 접속
minikube ssh

# ip 확인
minikube ip


### [ 서비스 ] ###
#
# 쿠버네티스 서비스 이름이 wordpress라면..
minikube service wordpress

# 실행화면
|-----------|-----------|-------------|---------------------------|
| NAMESPACE |   NAME    | TARGET PORT |            URL            |
|-----------|-----------|-------------|---------------------------|
| default   | wordpress |          80 | http://192.168.49.2:31569 |
|-----------|-----------|-------------|---------------------------|
🏃  Starting tunnel for service wordpress.
|-----------|-----------|-------------|------------------------|
| NAMESPACE |   NAME    | TARGET PORT |          URL           |
|-----------|-----------|-------------|------------------------|
| default   | wordpress |             | http://127.0.0.1:57094 |
|-----------|-----------|-------------|------------------------|
🎉  Opening service default/wordpress in default browser...
❗  Because you are using a Docker driver on darwin, the terminal needs to be open to run it.

# minikube service를 실행한 상태에서 127.0.0.1:31569이 아닌 127.0.0.1:57094로 접속합니다.
