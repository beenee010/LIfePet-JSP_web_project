<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<html>
<%!
	public String findPassword(String id, String name) {
		Connection conn = null;
	
		String passwd = null;
		
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
%>

<head>
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author"
	content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
<meta name="generator" content="Jekyll v4.1.1">
<link rel="stylesheet" href="/resources/css/bootstrap.min.css">
<title>ID Check</title>
</head>
<body class="bg-light">

	<div class="container col" style="text-align: center; margin-top: 3rem;">
		<h3>&laquo;비밀번호 찾기 결과&raquo;</h3>
	<%
		request.setCharacterEncoding("utf-8");
	
		String id = request.getParameter("id");
		String name = request.getParameter("name");

		String passwd = findPassword(id, name);
	%>
		<label>입력 ID: <strong><%=id %></strong></label>
	<%
		if(passwd != null && passwd.length() > 1){ 
	%>
		<p><label>Password: <strong><%=passwd %></strong></label>
		<p><a href='javascript:window.close()' class="btn btn-success">확인</a>
		<% }
			else{
		%>
			<p style='color: red'>회원 정보가 존재하지 않거나 일치하지 않습니다.</p>
		
		<hr>
		<a href="javascript:history.back()" class="btn btn-secondary">다시시도</a> &nbsp; &nbsp; &nbsp; &nbsp;
		<a href="javascript:window.close()" class="btn btn-danger">창닫기</a>
		<%} %>
	</div>
</body>
</html>