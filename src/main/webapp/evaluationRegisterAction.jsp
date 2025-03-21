<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="com.example.lectureevaluation.evaluation.EvaluationDAO" %>
<%@ page import="com.example.lectureevaluation.evaluation.EvaluationDTO" %>
<%
	request.setCharacterEncoding("UTF-8");
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
	
	/* 평가 등록에 필요한 정보 입력 */
	String lectureName = null;
	String professorName = null;
	int lectureYear = 0;
	String semesterDivide = null;
	String lectureDivide = null;
	String evaluationTitle = null;
	String evaluationContent = null;
	String totalScore = null;
	String creditScore = null;
	String comfortableScore = null;
	String lectureScore = null;
	
	if (request.getParameter("lectureName") != null) {
		lectureName = request.getParameter("lectureName");
	}
	if (request.getParameter("professorName") != null) {
		professorName = request.getParameter("professorName");
	}
	if (request.getParameter("lectureYear") != null) {
		try {
			lectureYear = Integer.parseInt(request.getParameter("lectureYear"));			
		} catch (Exception e) {
			System.out.println("강의 연도 데이터 오류");
		}
	}
	if (request.getParameter("semesterDivide") != null) {
		semesterDivide = request.getParameter("semesterDivide");
	}
	if (request.getParameter("lectureDivide") != null) {
		lectureDivide = request.getParameter("lectureDivide");
	}
	if (request.getParameter("evaluationTitle") != null) {
		evaluationTitle = request.getParameter("evaluationTitle");
	}
	if (request.getParameter("evaluationContent") != null) {
		evaluationContent = request.getParameter("evaluationContent");
	}
	if (request.getParameter("totalScore") != null) {
		totalScore = request.getParameter("totalScore");
	}
	if (request.getParameter("creditScore") != null) {
		creditScore = request.getParameter("creditScore");
	}
	if (request.getParameter("comfortableScore") != null) {
		comfortableScore = request.getParameter("comfortableScore");
	}
	if (request.getParameter("lectureScore") != null) {
		lectureScore = request.getParameter("lectureScore");
	}
	
	/* 입력사항이 하나라도 입력되지 않았을 경우 */
	if (lectureName == null || professorName == null || lectureYear == 0 || semesterDivide == null || 
			lectureDivide == null || evaluationTitle == null || evaluationContent == null || 
			totalScore == null || creditScore == null || comfortableScore == null || 
			lectureScore == null || evaluationTitle.equals("") || evaluationContent.equals("")) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	
	// 평가 등록 처리
	EvaluationDAO evaluationDAO = new EvaluationDAO();
	int result = evaluationDAO.write(new EvaluationDTO(0, userID, lectureName, professorName,
			lectureYear, semesterDivide, lectureDivide, evaluationTitle, evaluationContent, 
			totalScore, creditScore, comfortableScore, lectureScore, 0));
	/* 평가 등록에 실패한 경우 */
	if (result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('강의 평가 등록에 실패했습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	/* 평가가 성공적으로 등록된 경우 */
	else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('강의 평가가 등록되었습니다.');");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
%>