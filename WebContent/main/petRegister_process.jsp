<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<html>
<head>
<title>Pet Register Process</title>
</head>
<body>
	<%@ include file="/dbconn.jsp" %>
	<%
		request.setCharacterEncoding("utf-8");
	
		String p_guardian = request.getParameter("oid");
		
		String name = request.getParameter("petName");
		String breed = request.getParameter("petBreed");
		String gender = request.getParameter("petGender");
		int age = Integer.parseInt(request.getParameter("petAge"));
		
		PreparedStatement pstmt = null;
		try{
			String sql = "INSERT INTO PET(p_guardian, p_name, p_breed, p_age, p_gender) "
							+ "values(?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, p_guardian);
			pstmt.setString(2, name);
			pstmt.setString(3, breed);
			pstmt.setInt(4, age);
			pstmt.setString(5, gender);
			
			pstmt.executeUpdate();
		} catch(SQLException ex){
			System.out.println("Update 실패<br>");
			System.out.println("Error: " + ex.getMessage());
		} finally{
			if(pstmt != null)
				pstmt.close();
			if(conn != null)
				conn.close();
		}
		
		response.sendRedirect("/main/login.jsp");
	%>
</body>
</html>