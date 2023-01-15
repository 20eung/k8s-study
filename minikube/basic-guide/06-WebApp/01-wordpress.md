> 출처: https://subicura.com/k8s/guide/sample.html#워드프레스-배포

## 워드프레스 배포

> MySQL

| 키            | 값                            |
|---------------|-------------------------------|
| 컨테이너 이미지 | mariadb:10.7                 |
| 포트           | 3306                         |
| 환경변수       | MYSQL_DATABASE: wordpress     |
| 환경변수       | MYSQL_ROOT_PASSWORD: password |

> Wordpress

| 키            | 값                                  |
|---------------|-------------------------------------|
| 컨테이너 이미지 | wordpress:5.9.1-php8.1-apache       |
| 포트           | 80                                  |
| 환경변수       | WORDPRESS_DB_HOST: [wordpress host] |
| 환경변수       | WORDPRESS_DB_NAME: wordpress        |
| 환경변수       | WORDPRESS_DB_USER: root             |
| 환경변수       | WORDPRESS_DB_PASSWORD: password     |