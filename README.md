# Kubernetes Ingress 도메인 라우팅 규칙 적용

웹 풀스택 코드를 사용하여 **도커와 쿠버네티스를 적용하기 위한 프로젝트**입니다.<br>
프로젝트에 대한 해결 과정은 아래 **기술 블로그**를 통해서 확인하실 수 있습니다. <br>

[해결 과정](https://velog.io/@mdev97/K8S-Ingress-%EB%8F%84%EB%A9%94%EC%9D%B8-%EB%9D%BC%EC%9A%B0%ED%8C%85-%EA%B7%9C%EC%B9%99-%EC%A0%81%EC%9A%A9-Mac-M1-with-Docker-Desktop)

## 📝 Summary
1. React와 Node.js 그리고 MySQL을 사용한 풀스택 웹 서버 **도커 이미지를 통해서 웹서버에 접근**하는 실습
2. 쿠버네티스 클러스터에 웹 서버를 띄우고, **Ingress 오브젝트를 통해 도메인 라우팅 규칙을 적용**하기 위한 실습

<br>

## 💻 Development Environment
- React 16.13.1
- Node.js 1.18.3
- Docker 24.0.6
- MySQL:8
- Kubernetes Client: v1.28.2
- Kubernetes Server: v1.27.2

<br>

## **⭐️ 실습과제**

주제는 **ingress 오브젝트를 통해 도메인 라우팅 규칙 적용하기** 입니다

**First! 두 개의 서비스(Service) 배포**

먼저, 두 개의 서비스를 배포합니다. 

"web-service"와 "api-service"라는 이름으로 포트 80과 8080으로 서비스를 생성합니다.

- Service Object 2개

1. web-service 오브젝트 80 포트

2. api-service 오브젝트 8080 포트

- web-app이라는 이름의 deployment 배포

1. 웹 에플리케이션 Image 중 하나

2. Replicas는 2

3. Container Port는 80

- api-app 이라는 이름의 deployment 배포.

1. API 어플리케이션 Image 중 하나.

2. Replicas는 2

3. Container Port는 8080

---

**Second! Ingress 리소스 생성**

다음으로, Ingress 리소스를 생성하여 서비스들을 라우팅할 규칙을 정의합니다.

---

**Third! Ingress 적용**

Ingress 리소스를 적용하여 외부에서 [yourdomain.com/web](http://yourdomain.com/web) 으로 접근하면 "web-service"로

[yourdomain.com/api](http://yourdomain.com/api) 로 접근하면 "api-service"로 연결되도록 설정합니다.

---

**Last! 위 명령을 실행하여 Ingress 리소스를 적용합니다.** 

그리고 나서 도메인 주소를 통해 [yourdomain.com/web](http://yourdomain.com/web) 과 [yourdomain.com/api](http://yourdomain.com/api) 로 접근해보세요.

이렇게 설정된 Ingress를 통해 서비스들이 제대로 라우팅되는지 확인하실 수 있습니다.

※ 도메인 주소의 DNS 설정은 따로 하지 않습니다.

<br>

## **◉ 해결과정**

**📌 실습 시작 전 예상 다이어그램**
![diagram](https://github.com/moonstar0331/docker-fullstack-app/assets/79830859/c23d922c-f194-4971-a968-2c5f4d05cbc5)
