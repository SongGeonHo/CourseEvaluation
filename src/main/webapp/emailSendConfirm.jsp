<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>강의평가 웹 사이트</title>
	<!-- 부트스트랩 CSS 추가하기 -->
	<link rel="stylesheet" href="./css/bootstrap.min.css">
	<!-- 커스텀 CSS 추가하기 -->
	<link rel="stylesheet" href="./css/custom.css">
</head>
<body>
<%
	/* 로그인 확인 */
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if (userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요.');");
		script.println("location.href = 'userLogin.jsp';");
		script.println("</script>");
		script.close();
		return;
	}
%>
<nav class="navbar navbar-expand-lg navbar-light bg-light py-3">
	<div class="container">
		<a class="navbar-brand" href="index.jsp">강의평가 웹 사이트</a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbar">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div id="navbar" class="collapse navbar-collapse">
			<ul class="navbar-nav me-auto">
				<li class="nav-item active">
					<a class="nav-link" href="index.jsp">메인</a>
				</li>
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" id="dropdown" data-bs-toggle="dropdown" aria-expanded="false">
						회원 관리
					</a>
					<ul class="dropdown-menu" aria-labelledby="dropdown">
						<%
							if (userID == null) {
						%>
						<li><a class="dropdown-item" href="userLogin.jsp">로그인</a></li>
						<li><a class="dropdown-item" href="userJoin.jsp">회원가입</a></li>
						<%
						} else {
						%>
						<li><a class="dropdown-item" href="userLogout.jsp">로그아웃</a></li>
						<%
							}
						%>
					</ul>
				</li>
			</ul>
			<form action="index.jsp" method="get" class="d-flex" style="max-width: 300px;">
				<input type="text" name="search" class="form-control me-2" placeholder="내용을 입력하세요." aria-label="Search">
				<button class="btn btn-outline-success" type="submit">검색</button>
			</form>
		</div>
	</div>
</nav>
	<section class="container mt-3" style="max-width: 560px;">
		<div class="alert alert-warning mt-4" role="alert">
			이메일 주소 인증을 하셔야 이용 가능합니다. 인증 메일을 받지 못하셨나요?
		</div>
		<a href="emailSendAction.jsp" class="btn btn-primary">인증 메일 다시 받기</a>
	</section>
	<footer class="bg-dark mt-4 p-5 text-center" style="color: #FFFFFF;">
		Copyright &copy; 2024 송건호 All Rights Reserved.
	</footer>
	<!-- 제이쿼리 JS 추가하기 -->
	<script src="./js/jquery.min.js"></script>
	<!-- 파퍼 JS 추가하기 -->
	<script src="./js/popper.js"></script>
	<!-- 부트스트랩 JS 추가하기 -->
	<script src="./js/bootstrap.min.js"></script>
</body>
</html>