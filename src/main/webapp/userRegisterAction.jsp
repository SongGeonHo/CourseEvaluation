<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="com.example.lectureevaluation.user.UserDAO" %>
<%@ page import="com.example.lectureevaluation.util.SHA256" %>
<%@ page import="com.example.lectureevaluation.user.UserDTO" %>
<%
	request.setCharacterEncoding("UTF-8");
	/* 아이디, 비밀번호, 이메일 입력 */
	String userID = null;
	String userPassword = null;
	String userEmail = null;
	if (request.getParameter("userID") != null) {
		userID = request.getParameter("userID");
	}
	if (request.getParameter("userPassword") != null) {
		userPassword = request.getParameter("userPassword");
	}
	if (request.getParameter("userEmail") != null) {
		userEmail = request.getParameter("userEmail");
	}
	/* 입력사항이 하나라도 입력되지 않았을 경우 */
	if (userID.equals("") || userPassword.equals("") || userEmail.equals("")) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	
	UserDAO userDAO = new UserDAO();
	int result = userDAO.join(new UserDTO(userID, userPassword, userEmail, SHA256.getSHA256(userEmail), false));
	/* 회원가입이 성공적으로 되지 않았을 경우 */
	if (result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 존재하는 아이디입니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	/* 회원가입이 성공적으로 되었을 경우 */
	else {
		session.setAttribute("userID", userID);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'emailSendAction.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
%>