### HTTPS로 전환하기 (4-11)

#### SSL 인증서를 발급받아 HTTPS로 접속하기

1. Let's Encrypt SSL 인증서를 쉽게 생성 및 관리할 수 있는 도구와 라이브러리 설치
```
> sudo apt install certbot
> sudo apt install python3-certbot-nginx
```

2. Let's Encrypt 인증서 발급
```
> sudo certbot certonly --nginx

Saving debug log to /var/log/letsencrypt/letsencrypt.log
Enter email address (used for urgent renewal and security notices)
 (Enter 'c' to cancel): <관리자 이메일>

...

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Please read the Terms of Service at
https://letsencrypt.org/documents/LE-SA-v1.4-April-3-2024.pdf. You must agree in
order to register with the ACME server. Do you agree?
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
(Y)es/(N)o: y

...

(Y)es/(N)o: y
Account registered.

Which names would you like to activate HTTPS for?
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
1: <도메인명>
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Select the appropriate numbers separated by commas and/or spaces, or leave input
blank to select all options shown (Enter 'c' to cancel): <등록할 도메인명 번호>

...

Successfully received certificate.
Certificate is saved at: /etc/letsencrypt/live/<도메인명>/fullchain.pem
Key is saved at:         /etc/letsencrypt/live/<도메인명>/privkey.pem
This certificate expires on 20XX-XX-XX.
...
```

3. SSL 인증서를 nginx에 적용하기 위해 /etc/nginx/sites-available 경로에 있는 sbb 파일을 수정합니다. HTTP 요청(80)을 HTTPS(443)로 리다이렉트하도록 설정하며 SSL 인증서 적용을 위해 관련 설정을 적용합니다.
```
server {
        listen 80;
        server_name <도메인명>;
        rewrite         ^ https://$server_name$request_uri? permanent;
}

server {
        listen 443 ssl;
        server_name <도메인명>;

        ssl_certificate /etc/letsencrypt/live/<도메인명>/fullchain.pem;
        ssl_certificate_key /etc/letsencrypt/live/<도메인명>/privkey.pem;
        include /etc/letsencrypt/options-ssl-nginx.conf;

        location / {
                proxy_pass http://localhost:8080;
                proxy_set_header X-RealIP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header Host $http_host;
        }
}
```

4. nginx 설정을 바꾸었으므로 재시작 : ```sudo systemctl restart nginx.service```

5. Lightsail 인스턴스에 443번 포트 방화벽 해제.