<%@ page import="java.sql.*" %>
<%
	Connection conn = null;

	String url = "jdbc:mysql://localhost:3306/PetWebDB?useSSL=false&serverTimezone=Asia/Seoul";
	String user = "root";
	String pass = "password";
	
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection(url, user, pass);
%>