<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="com.example.lectureevaluation.evaluation.EvaluationDAO" %>
<%@ page import="com.example.lectureevaluation.likey.LikeyDAO" %>
<%!
	/* 사용자의 IP 가져오기 */
	public static String getClientIP(HttpServletRequest request) {
		String ip = request.getHeader("X-FORWARDED-FOR");
		if (ip == null || ip.length() == 0) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}
%>
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
		script.println("location.href = 'userLogin.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
	
	/* 추천에 필요한 정보 */
	request.setCharacterEncoding("UTF-8");
	String evaluationID = null;
	if (request.getParameter("evaluationID") != null) {
		evaluationID = request.getParameter("evaluationID");
	}
	EvaluationDAO evaluationDAO = new EvaluationDAO();
	LikeyDAO likeyDAO = new LikeyDAO();
	
	/* 추천하기 */
	int result = likeyDAO.like(userID, evaluationID, getClientIP(request));
	/* 이미 추천한 사용자와 중복되지 않아 정상적으로 추천이 가능한 경우 */
	if (result == 1){
		result = evaluationDAO.like(evaluationID);
		/* 성공적으로 완료 */
		if (result == 1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('추천이 완료되었습니다.');");
			script.println("location.href = './index.jsp'");
			script.println("</script>");
			script.close();
			return;
		}
		/* 오류 발생 */
		else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다.');");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;			
		}
	}
	/* 이미 추천하여 추천할 수 없는 경우 */
	else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 추천한 글입니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
%>