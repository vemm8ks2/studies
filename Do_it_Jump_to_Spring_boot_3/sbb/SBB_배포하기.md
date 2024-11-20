### SBB 배포하기 (4-05)

#### 서버 환경 설정하기 <small>[MobaXterm]</small>

##### 호스트 이름 변경하기 

1. 호스트 이름 변경 : ```sudo hostnamectl set-hostname <설정할 호스트명>```
2. 서버 재시작 : ```sudo reboot```
3. 호스트명 확인 : ```hostname```

##### 서버 시간 설정하기

1. 서버 시간 확인 : ```date```
2. 한국 시간(KST)으로 설정 : ```sudo ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime```
3. 서버 시간 확인 : ```date```

##### 서버에 자바 설치하기

1. 자바 설치 확인 : ```java```
2. 자바 설치 전 우분투 패키지 업그레이드 : ```sudo apt update```
3. 자바 설치 : ```sudo apt install openjdk-19-jdk```
4. 설치 확인 : ```java -version```

##### 프로젝트 디렉터리 생성하기

1. 디렉터리 생성 : ```mkdir sbb```
2. 디렉터리 나열 : ```ls```


#### STS에서 SBB 배포 파일 생성하기 <small>[STS4]</small>

1. Gradle에 JDK 설정하기 : ```Window --> Preferences --> Gradle```
2. 'Java home' 항목에 설치한 JDK 디렉터리를 입력한다. ex. ```C:/Program Files/Java/jdk-21```
3. AWS 서버에는 JDK19 버전을 설치하여 build.gradle의 java 항목에 추가 : ```sourceCompatibility = '19'```
4. SBB 배포 파일(jar 파일) 만들기 : ```Run --> Run Configurations --> Gradle Task 우클릭 --> New Configuration```
5. 항목 입력
```
1. Name --> 'sbb'를 입력
2. [Workspace] 버튼을 클릭하여 프로젝트 선택
3. [Add] 버튼을 클릭하여 Gradle Tasks --> task 생성
4. task 클릭 후 이름을 bootJar 입력
5. [Apply] 버튼 클릭 후 적용
6. [Run] 버튼 클릭
```
6. build 디렉터리 생성 및 빌드 결과 확인

#### SFTP로 SBB 배포 파일 전송하기 <small>[FileZilla, MobaXterm]</small>

1. [FileZilla] 빌드 결과 .jar 파일을 서버의 /home/ubuntu/sbb 디렉터리로 드래그 앤 드롭하여 옮긴다.
2. [MobaXterm] ```cd sbb``` 명령어를 입력하여 디렉터리 이동 후 ```java -jar <빌드 결과 .jar 파일>``` 명령어를 실행한다.