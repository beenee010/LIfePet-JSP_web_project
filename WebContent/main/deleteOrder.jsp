<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<title>Insert title here</title>
</head>
<body>
	<%@ include file="/dbconn.jsp" %>
	<%
		request.setCharacterEncoding("utf-8");
	
		String orderId = request.getParameter("id");
		String userOid = request.getParameter("u_oid");
		String sessId = (String) session.getAttribute("userOid");
		
		if(sessId == null){
			response.sendRedirect("/main/login.jsp");
			return;
		}
		else if(!sessId.equals(userOid)){
			response.sendRedirect("/main/logout.jsp");
			return;
		}
		
		PreparedStatement pstmt = null;

		try{
			String sql = "DELETE FROM ORDERING WHERE o_oid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, orderId);
			pstmt.executeUpdate();
		} catch (SQLException ex){
			System.out.println("Update 실패<br>");
			System.out.println("Error: " + ex.getMessage());
		} finally{
			if(pstmt != null)
				pstmt.close();
			if(conn != null)
				conn.close();
		}
	
		response.sendRedirect("/main/orderList.jsp?oid=" + userOid);
	%>
</body>
</html>