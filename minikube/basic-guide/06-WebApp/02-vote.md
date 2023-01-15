> 출처: https://subicura.com/k8s/guide/sample.html#투표-애플리케이션-배포

## 투표 애플리케이션 배포

> Redis

| 키            | 값            |
|---------------|---------------|
| 컨테이너 이미지 | redis:latest |
| 포트           | 6379         |

> Postgres

| 키            | 값                           |
|---------------|------------------------------|
| 컨테이너 이미지 | postgres:9.4                |
| 포트           | 5432                        |
| 환경변수       | POSTGRES_USER: postgres     |
| 환경변수       | POSTGRES_PASSWORD: postgres |

> worker

| 키            | 값                                     |
|---------------|----------------------------------------|
| 컨테이너 이미지 | ghcr.io/subicura/voting/worker:latest |
| 환경변수       | REDIS_HOST: [redis ip]                 |
| 환경변수       | REDIS_PORT: [redis port]               |
| 환경변수       | POSTGRES_HOST: [postgres ip]           |
| 환경변수       | POSTGRES_PORT: [postgres port]         |

> vote : 노드 31001으로 연결

| 키            | 값                                   |
|---------------|--------------------------------------|
| 컨테이너 이미지 | ghcr.io/subicura/voting/vote:latest |
| 포트           | 80                                  |
| 환경변수       | REDIS_HOST: [redis ip]              |
| 환경변수       | REDIS_PORT: [redis port]            |

> result : 노드 31001으로 연결

| 키            | 값                                     |
|---------------|----------------------------------------|
| 컨테이너 이미지 | ghcr.io/subicura/voting/result:latest |
| 포트           | 80                                    |
| 환경변수       | POSTGRES_HOST: [postgres ip]           |
| 환경변수       | POSTGRES_PORT: [postgres port]         |