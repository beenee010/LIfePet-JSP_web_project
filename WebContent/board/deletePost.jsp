<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="dto.Post" %>
<%@ page import="dao.PostRepository" %>
<html>
<head>
<title>Insert title here</title>
</head>
<body>
	<%@ include file="/dbconn.jsp" %>
	<%
		request.setCharacterEncoding("utf-8");
	
		String postId = request.getParameter("id");
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
			String sql = "DELETE FROM POST WHERE p_oid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, postId);
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
		PostRepository dao = PostRepository.getInstance();
		
		HashMap<String, Post> postMap = dao.getPostes();
		postMap.remove("POST" + postId);
		response.sendRedirect("/board/board.jsp");
	%>
</body>
</html>