<%@page import="java.util.StringTokenizer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="dto.Post" %>
<html>
<head>
<title>Insert title here</title>
</head>
<body>
	<%@ include file="/dbconn.jsp"%>

	<%
		String clickOid = (String)session.getAttribute("userOid");
		String postUid = request.getParameter("p_uid");
		String postOid = request.getParameter("p_oid");
		Post post = (Post)request.getAttribute("post");
		int hit = post.getHit();
		
		postOid = postOid.substring(4);
		if(clickOid == null || !clickOid.equals(postUid)){
			PreparedStatement pstmt = null;
			try{
				String sql = "UPDATE POST SET p_hit=p_hit+1 WHERE p_oid=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, postOid);
				pstmt.executeUpdate();
			} catch (SQLException ex){
				System.out.println("Update 실패<br>");
				System.out.println("Error: " + ex.getMessage());
			} finally{
				post.setHit(hit+1);
				if(pstmt != null)
					pstmt.close();
				if(conn != null)
					conn.close();
			}
		}
	%>
</body>
</html>