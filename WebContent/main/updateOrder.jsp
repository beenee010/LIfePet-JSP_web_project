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
		
		boolean admin = (Boolean) session.getAttribute("admin");
		
		if(!admin)
			response.sendRedirect("/main/welcome.jsp");
		
		request.setCharacterEncoding("utf-8");
		
		String o_oid = request.getParameter("oid");
		String state = request.getParameter("state");
		System.out.println(state);
		System.out.println(o_oid);
		
		PreparedStatement pstmt = null;
		try{
			String sql = "UPDATE ORDERING SET o_state=? WHERE o_oid=?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, state);
			pstmt.setString(2, o_oid);
			
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
			
			response.sendRedirect("/main/orderList.jsp?oid="+ userOid);
		}

	%>
</body>
</html>