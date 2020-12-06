<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<html>
<head>
<title>Register Process</title>
</head>
<body>
	<%@ include file="/dbconn.jsp" %>
	<%
		request.setCharacterEncoding("utf-8");
	
		String name = request.getParameter("name");
		String phone = request.getParameter("phone1") + "-" + request.getParameter("phone2") + "-" + request.getParameter("phone3");
		String id = request.getParameter("id");
		String passwd = request.getParameter("password");
		String email = request.getParameter("email1") + "@" + request.getParameter("email2");
		String address = request.getParameter("address");
		String agree = request.getParameter("mailAgree");
		
		String u_oid = "";
		
		PreparedStatement pstmt = null;
		Statement stmt = null;
		try{
			String sql = "insert into USER(u_id, u_passwd, u_name, u_phone, u_email, u_address, u_advAgree) "
							+ "values(?, ?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, passwd);
			pstmt.setString(3, name);
			pstmt.setString(4, phone);
			pstmt.setString(5, email);
			pstmt.setString(6, address);
			if(agree == null)
				pstmt.setBoolean(7, false);
			else
				pstmt.setBoolean(7, true);
			
			pstmt.executeUpdate();
		} catch(SQLException ex){
			System.out.println("Update 실패<br>");
			System.out.println("Error: " + ex.getMessage());
		} finally{
			try{
			String sql = "SELECT u_oid FROM USER WHERE u_id ='" + id + "'";
			stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			if(rs.next())
				u_oid = rs.getString(1);
			} catch(SQLException ex){
				System.out.println("Update 실패<br>");
				System.out.println("Error: " + ex.getMessage());
			} finally{
				if(stmt != null)
					stmt.close();
			}
			if(pstmt != null)
				pstmt.close();
			if(conn != null)
				conn.close();
		}
		System.out.println(u_oid);
		response.sendRedirect("/main/petRegister.jsp?oid=" + u_oid);
	%>
</body>
</html>