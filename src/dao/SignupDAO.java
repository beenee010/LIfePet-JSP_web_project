package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class SignupDAO {
	
	private static SignupDAO instance = new SignupDAO();
	
	public static SignupDAO getInstance() {
		return instance;
	}
	
	public boolean confirmId(String id) {
		Connection conn = null;

		boolean res = false;
		
		String url = "jdbc:mysql://localhost:3306/PetWebDB?useSSL=false&serverTimezone=Asia/Seoul";
		String user = "root";
		String pass = "password";
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e1) {
			e1.printStackTrace();
		}
		try {
			conn = DriverManager.getConnection(url, user, pass);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try{
			String sql = "SELECT u_id FROM USER WHERE u_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) res = true;
			
		} catch(SQLException ex){
			System.out.println("Update 실패");
			System.out.println("Error: " + ex.getMessage());
		} finally{
			if(rs != null)
				try {rs.close(); } catch (SQLException e) { e.printStackTrace(); }
			if(pstmt != null)
				try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
			if(conn != null)
				try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
		}
		
		return res;
	}
	
	public String findPassword(String id, String name) {
		Connection conn = null;

		String passwd = "";
		
		String url = "jdbc:mysql://localhost:3306/PetWebDB?useSSL=false&serverTimezone=Asia/Seoul";
		String user = "root";
		String pass = "password";
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e1) {
			e1.printStackTrace();
		}
		try {
			conn = DriverManager.getConnection(url, user, pass);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try{
			String sql = "SELECT u_passwd FROM USER WHERE u_id=? AND u_name=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, name);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				passwd = rs.getString(1);
			}
			
		} catch(SQLException ex){
			System.out.println("Update 실패");
			System.out.println("Error: " + ex.getMessage());
		} finally{
			if(rs != null)
				try {rs.close(); } catch (SQLException e) { e.printStackTrace(); }
			if(pstmt != null)
				try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
			if(conn != null)
				try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
		}
		
		return passwd;
	}
}
