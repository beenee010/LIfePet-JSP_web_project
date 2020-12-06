<%@page import="java.util.StringTokenizer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="dto.Item" %>
<html>
<head>
<title>Insert title here</title>
</head>
<body>
	<%@ include file="/dbconn.jsp"%>

	<%
		String clickOid = (String)session.getAttribute("userOid");
		String itemUid = request.getParameter("i_uid");
		String itemOid = request.getParameter("i_oid");
		Item item = (Item)request.getAttribute("item");
		int hit = item.getHit();
		
		itemOid = itemOid.substring(4);
		if(clickOid == null || !clickOid.equals(itemUid)){
			PreparedStatement pstmt = null;
			try{
				String sql = "UPDATE ITEM SET i_hit=i_hit+1 WHERE i_oid=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, itemOid);
				pstmt.executeUpdate();
			} catch (SQLException ex){
				System.out.println("Update 실패<br>");
				System.out.println("Error: " + ex.getMessage());
			} finally{
				item.setHit(hit+1);
				if(pstmt != null)
					pstmt.close();
				if(conn != null)
					conn.close();
			}
		}
	%>
</body>
</html>