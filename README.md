### 강의평가 웹 사이트 [JSP]
![강의평가](https://github.com/user-attachments/assets/c0de451a-d5be-41e9-995c-0834944d168c)



**개요**
강의 평가 웹사이트를 개발하며, 서버 측 렌더링을 이해하고 직접 구현해 보는 것이 목표였습니다. JSP는 서블릿과 함께 동작하는 기본적인 웹 
기술이기 때문에, 웹 애플리케이션의 전체적인 흐름(클라이언트 Request -> 컨트롤러 -> 비즈니스 로직 -> View 반환)을 직접 다뤄볼 수 있었습니다. 또한 HTML과 Java 코드를 함께 사용하면서 서버에서 동적으로 페이지를 렌더링하는 방식을 익히는데 도움이 되었습니다.
하지만 JSP만으로는 유지보수성과 확장성이 떨어지는 한계를 경험했고, 이를 해결하기 위해 스프링 MVC 구조를 학습하며 개선 방안을 고민했습니다. 만약 실무에서 다시 구현한다면, 스프링 MVC와 타임리프(Thymeleaf) 같은 템플릿 엔진을 활용하여 보다 효율적인 아키텍처를 구성할 것입니다. 


- **기간**: 총 5일  (2025.01.06 ~ 2025.01.10)
- **팀 구성**: 1인 미니 프로젝트 
- **기술 스택**: HTML,CSS(Bootstrap 5),Java,JSP 

**구현 기능**

- SMTP API를 통해 이메일 전송 프로토콜인 SMTP(Simple Mail Transfer Protocol)를 활용하여 이메일 발송&수신 기능 구현 
- HTTP 쿠키-보안 기능 구현 - HttpOnly 사용하여 XSS 공격 방지
- 미니 검색 엔진을 구현하여 전공/교양 과목을 검색하고 원하는 방식으로 정렬 
- 회원가입 및 이메일 인증 / 로그인 및 로그아웃 / 강의평가 등록 기능 / 관리자 신고 기능 / 강의 추천 및 삭제 


**특이사항**


- **문제 해결 및 의사결정 능력**
    
    예상치 못한 문제(2018년 강의를 바탕으로 제작하여 대부분의 기능들이 동작 불능)에 대해 대안을 모색하고 우선순위를 재조정
    
    부트스트랩4를 바탕으로 한 강의였기 때문에 Bootstrap 공식페이지에서 사용하지 않는 지식 & 변경된 지식을 찾아 변경 
    
    SMTP API의 버전 또한 변경되어 공식문서 및 GPT를 활용하여 검색 후 변경 
    
 
    
- **기술 학습 및 사후 관리 역량**

    JSP 프로젝트를 해봄으로서 Spring MVC 예습 
    
    공식문서, 튜토리얼, 강의 등 다양한 리소스를 활용해 단기간에 새로운 기술이나 툴을 학습하고 적용
    
    

**참고 링크**
- **Inflearn**: [JSP 강의평가 웹 사이트 개발하기](https://www.inflearn.com/course/%EA%B0%95%EC%9D%98%ED%8F%89%EA%B0%80-%EC%82%AC%EC%9D%B4%ED%8A%B8-jsp/dashboard)
- **bootstrap**: [부트스트랩5](https://getbootstrap.kr/)
- **google**: [구글 SMTP](https://support.google.com/a/answer/176600?hl=ko)
