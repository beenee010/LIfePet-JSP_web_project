<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<title>Insert title here</title>
</head>
<body>
	<%@ include file="/dbconn.jsp"%>
	
	<%
		String userOid = (String)session.getAttribute("userOid");
		if(userOid == null)
			response.sendRedirect("/main/login.jsp");
		
		request.setCharacterEncoding("utf-8");
		
		String u_oid = request.getParameter("oid");
		String name = request.getParameter("name");
		String phone1 = request.getParameter("phone1");
		String phone2 = request.getParameter("phone2");
		String phone3 = request.getParameter("phone3");
		String phone = phone1 + "-" + phone2 + "-" + phone3;
		String passwd = request.getParameter("password");
		String email1 = request.getParameter("email1");
		String email2 = request.getParameter("email2");
		String email = email1 + "@" + email2;
		String address = request.getParameter("address");
		String agree = request.getParameter("mailAgree");
		
		if(agree != null && agree.equals("on")) agree = "1";
		else agree = "0";
		
		PreparedStatement pstmt = null;
		try{
			String sql = "UPDATE USER SET u_passwd=?, u_name=?, u_phone=?, u_email=?, u_address=?, u_advAgree=? WHERE u_oid=?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, passwd);
			pstmt.setString(2, name);
			pstmt.setString(3, phone);
			pstmt.setString(4, email);
			pstmt.setString(5, address);
			pstmt.setString(6, agree);
			pstmt.setString(7, u_oid);
			
			pstmt.executeUpdate();
		} catch(SQLException ex){
			// 에러 구현
			System.out.println("Update 실패<br>");
			System.out.println("Error: " + ex.getMessage());
		} finally{
			if(pstmt != null)
				pstmt.close();
			if(conn != null)
				conn.close();
			
			session.setAttribute("userPW", passwd);
			response.sendRedirect("/main/myPage.jsp?id="+u_oid);
		}

	%>
	

</body>
</html>