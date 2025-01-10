<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javax.mail.Transport"%>
<%@ page import="javax.mail.Message"%>
<%@ page import="javax.mail.Address"%>
<%@ page import="javax.mail.internet.InternetAddress"%>
<%@ page import="javax.mail.internet.MimeMessage"%>
<%@ page import="javax.mail.Session"%>
<%@ page import="javax.mail.Authenticator"%>
<%@ page import="java.util.Properties"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="com.example.lectureevaluation.user.UserDAO" %>
<%@ page import="com.example.lectureevaluation.util.SHA256" %>
<%@ page import="com.example.lectureevaluation.util.Gmail" %>
<%
	UserDAO userDAO = new UserDAO();
	/* 로그인 확인 */
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if (userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요.');");
		script.println("location.href = 'userLogin.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
	
	/* 이메일 인증 확인 */
	boolean emailChecked = userDAO.getUserEmailChecked(userID);
	/* 이메일 인증된 회원인 경우 */
	if (emailChecked == true) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 인증된 회원입니다.');");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
	/* 이메일 인증이 안 된 회원인 경우 */
	/* 인증 메일 발송 처리 */
	String host = "http://localhost:8081/LectureEvaluation_war_exploded/";
	String from = "songgun1234@gmail.com";
	String to = userDAO.getUserEmail(userID);
	String subject = "강의평가를 위한 이메일 인증 메일입니다.";
	String content = "다음 링크에 접속하여 이메일 인증을 진행해 주세요. " +
			"<a href='" + host + "emailCheckAction.jsp?code=" + new SHA256().getSHA256(to) + "'>이메일 인증하기</a>";
	
	/* 실제로 구글 smtp 서버에 접속하기 위해 필요한 정보 입력 */
	Properties p = new Properties();
	p.put("mail.smtp.host", "smtp.gmail.com"); // SMTP 서버 주소
	p.put("mail.smtp.port", "587"); // TLS 포트
	p.put("mail.smtp.auth", "true"); // 인증 필요
	p.put("mail.smtp.starttls.enable", "true"); // TLS 사용
	p.put("mail.smtp.ssl.protocols", "TLSv1.2"); // 최신 TLS 프로토콜 지정
	p.put("mail.smtp.debug", "true"); // 디버그 활성화
	p.put("mail.smtp.ssl.trust", "smtp.gmail.com"); //

	try {
		Authenticator auth = new Gmail();
		Session ses = Session.getInstance(p, auth);
		ses.setDebug(true);
		MimeMessage msg = new MimeMessage(ses);
		msg.setSubject(subject);
		Address fromAddr = new InternetAddress(from);
		msg.setFrom(fromAddr);
		Address toAddr = new InternetAddress(to);
		msg.addRecipient(Message.RecipientType.TO, toAddr);
		msg.setContent(content, "text/html;charset=UTF8");
		Transport.send(msg);
	} catch (Exception e) {
		e.printStackTrace();
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('오류가 발생했습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
%>
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
		<div class="alert alert-success mt-4" role="alert">
			이메일 주소 인증 메일이 전송되었습니다. 회원가입 시 입력한 이메일로 로그인하여 인증해 주세요.
		</div>
	</section>
	<footer class="bg-dark mt-4 p-5 text-center" style="color: #FFFFFF;">
		Copyright &copy; 2024 송건호 All Rights Reserved.
	</footer>
	<!-- 제이쿼리 JS 추가하기 -->
	<script src="./js/jquery.min.js"></script>
	<!-- 파퍼 JS 추가하기 -->
	<script src="./js/popper.min.js"></script>
	<!-- 부트스트랩 JS 추가하기 -->
	<script src="./js/bootstrap.min.js"></script>
</body>
</html>