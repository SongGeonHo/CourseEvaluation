package com.example.lectureevaluation.evaluation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import com.example.lectureevaluation.util.DatabaseUtil;


public class EvaluationDAO {
    // 평가 등록
    public int write(EvaluationDTO evaluationDTO) {
        String sql = "INSERT INTO evaluation VALUES (NULL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 0)";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            // XSS 방어
            pstmt.setString(1, evaluationDTO.getUserID().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
            pstmt.setString(2, evaluationDTO.getLectureName().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
            pstmt.setString(3, evaluationDTO.getProfessorName().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
            pstmt.setInt(4, evaluationDTO.getLectureYear());
            pstmt.setString(5, evaluationDTO.getSemesterDivide().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
            pstmt.setString(6, evaluationDTO.getLectureDivide().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
            pstmt.setString(7, evaluationDTO.getEvaluationTitle().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
            pstmt.setString(8, evaluationDTO.getEvaluationContent().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
            pstmt.setString(9, evaluationDTO.getTotalScore().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
            pstmt.setString(10, evaluationDTO.getCreditScore().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
            pstmt.setString(11, evaluationDTO.getComfortableScore().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
            pstmt.setString(12, evaluationDTO.getLectureScore().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
            return pstmt.executeUpdate();	// 평가가 등록되면 1을 반환
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {if (conn != null) conn.close();} catch (SQLException e) {e.printStackTrace();}
            try {if (pstmt != null) pstmt.close();} catch (SQLException e) {e.printStackTrace();}
            try {if (rs != null) rs.close();} catch (SQLException e) {e.printStackTrace();}
        }
        return -1;	// 데이터베이스 오류
    }

    // 검색 결과 조회
    public ArrayList<EvaluationDTO> getList(String lectureDivide, String searchType, String search, int pageNumber) {
        if (lectureDivide.equals("전체")) {
            lectureDivide = "";
        }
        ArrayList<EvaluationDTO> evaluationList = null;
        String sql = "";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            if (searchType.equals("최신순")) {
                sql = "SELECT * FROM evaluation WHERE lectureDivide LIKE ? AND CONCAT(lectureName, professorName, evaluationTitle, evaluationContent) LIKE "
                        + " ? ORDER BY evaluationID DESC LIMIT " + pageNumber * 5 + ", " + pageNumber * 5 + 6;
            } else if (searchType.equals("추천순")) {
                sql = "SELECT * FROM evaluation WHERE lectureDivide LIKE ? AND CONCAT(lectureName, professorName, evaluationTitle, evaluationContent) LIKE "
                        + " ? ORDER BY likeCount DESC LIMIT " + pageNumber * 5 + ", " + pageNumber * 5 + 6;
            }
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "%" + lectureDivide + "%");
            pstmt.setString(2, "%" + search + "%");
            rs = pstmt.executeQuery();
            evaluationList = new ArrayList<EvaluationDTO>();
            while (rs.next()) {
                EvaluationDTO evaluation = new EvaluationDTO(
                        rs.getInt(1)
                        , rs.getString(2)
                        , rs.getString(3)
                        , rs.getString(4)
                        , rs.getInt(5)
                        , rs.getString(6)
                        , rs.getString(7)
                        , rs.getString(8)
                        , rs.getString(9)
                        , rs.getString(10)
                        , rs.getString(11)
                        , rs.getString(12)
                        , rs.getString(13)
                        , rs.getInt(14)
                );
                evaluationList.add(evaluation);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {if (conn != null) conn.close();} catch (SQLException e) {e.printStackTrace();}
            try {if (pstmt != null) pstmt.close();} catch (SQLException e) {e.printStackTrace();}
            try {if (rs != null) rs.close();} catch (SQLException e) {e.printStackTrace();}
        }
        return evaluationList;
    }

    // 평가 추천수 증가
    public int like(String evaluationID) {
        String sql = "UPDATE evaluation SET likeCount = likeCount + 1 WHERE evaluationID = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(evaluationID));
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {if (conn != null) conn.close();} catch (SQLException e) {e.printStackTrace();}
            try {if (pstmt != null) pstmt.close();} catch (SQLException e) {e.printStackTrace();}
            try {if (rs != null) rs.close();} catch (SQLException e) {e.printStackTrace();}
        }
        return -1;	// 데이터베이스 오류
    }

    // 평가 삭제하기
    public int delete(String evaluationID) {
        String sql = "DELETE FROM evaluation WHERE evaluationID = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(evaluationID));
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {if (conn != null) conn.close();} catch (SQLException e) {e.printStackTrace();}
            try {if (pstmt != null) pstmt.close();} catch (SQLException e) {e.printStackTrace();}
            try {if (rs != null) rs.close();} catch (SQLException e) {e.printStackTrace();}
        }
        return -1;	// 데이터베이스 오류
    }

    // 평가 작성자 아이디 조회
    public String getUserID(String evaluationID) {
        String sql = "SELECT userID FROM evaluation WHERE evaluationID = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, evaluationID);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getString(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {if (conn != null) conn.close();} catch (SQLException e) {e.printStackTrace();}
            try {if (pstmt != null) pstmt.close();} catch (SQLException e) {e.printStackTrace();}
            try {if (rs != null) rs.close();} catch (SQLException e) {e.printStackTrace();}
        }
        return null;	// 작성자 아이디 존재하지 않음
    }
}
