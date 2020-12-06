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
	
		String id = request.getParameter("id");
		String passwd = request.getParameter("passwd");
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try{
			String sql = "SELECT u_oid, u_id, u_passwd, u_admin FROM USER WHERE u_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				String rOid = Integer.toString(rs.getInt("u_oid"));				
				String rId = rs.getString("u_id");
				String rPass = rs.getString("u_passwd");

				boolean rAdmin = rs.getBoolean("u_admin");
				
				if(id.equals(rId) && passwd.equals(rPass)){
					session.setAttribute("userOid", rOid);
					session.setAttribute("userID", id);
					session.setAttribute("userPW", passwd);
					session.setAttribute("admin", rAdmin);
					response.sendRedirect("/welcome.jsp");
				}
				else
					response.sendRedirect("/main/login.jsp?error=1");
			}
			else
				response.sendRedirect("/main/login.jsp?error=2");
			
		} catch (SQLException ex){
			System.out.println("Update 실패<br>");
			System.out.println("Error: " + ex.getMessage());
		} finally{
			if(pstmt != null)
				pstmt.close();
			if(conn != null)
				conn.close();
		}
		
	%>
</body>
</html>