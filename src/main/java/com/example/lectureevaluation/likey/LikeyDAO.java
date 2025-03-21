package com.example.lectureevaluation.likey;

import com.example.lectureevaluation.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LikeyDAO {
    public int like(String userID, String evaluationID, String userIP) {
        String sql = "INSERT INTO likey VALUES (?, ?, ?)";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userID);
            pstmt.setString(2, evaluationID);
            pstmt.setString(3, userIP);
            return pstmt.executeUpdate();
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            try { if(conn != null) conn.close(); }
            catch (Exception e) { e.printStackTrace(); }
            try { if(pstmt != null) pstmt.close(); }
            catch (Exception e) { e.printStackTrace(); }
            try { if(rs != null) rs.close(); }
            catch (Exception e) { e.printStackTrace(); }
        }
        return -1; //추천 중복 오류
    }
}


