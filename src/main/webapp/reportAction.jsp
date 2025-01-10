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
<%@ page import="com.example.lectureevaluation.util.Gmail" %>
<%
	UserDAO userDAO = new com.example.lectureevaluation.user.UserDAO();
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
	
	/* 신고 내용에 입력된 정보 */
	request.setCharacterEncoding("UTF-8");
	String reportTitle = null;
	String reportContent = null;
	if (request.getParameter("reportTitle") != null) {
		reportTitle = request.getParameter("reportTitle");
	}
	if (request.getParameter("reportContent") != null) {
		reportContent = request.getParameter("reportContent");
	}
	if (reportTitle == null || reportContent == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	
	/* 관리자에게 신고 메일 발송 처리 */
	String host = "http://localhost:8081/LectureEvaluation/";
	String from = "songgun1234@gmail.com";
	String to = "songgun1234@gmail.com";
	String subject = "강의평가 사이트에서 접수된 신고 메일입니다.";
	String content = "신고자: " + userID +
			"<br>제목: " + reportTitle +
			"<br>내용: " + reportContent;
	
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
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('신고가 정상적으로 접수되었습니다.');");
	script.println("history.back();");
	script.println("</script>");
	script.close();
	return;
%>