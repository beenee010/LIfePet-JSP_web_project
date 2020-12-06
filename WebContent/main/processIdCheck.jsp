<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.SignupDAO" %>
<html>
<head>
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author"
	content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
<meta name="generator" content="Jekyll v4.1.1">
<link rel="stylesheet" href="/resources/css/bootstrap.min.css">
<script type="text/javascript">
function idConfirm(id){
	opener.document.registerForm.id.value=id; 
	opener.document.registerForm.id.readOnly = true;
	opener.document.registerForm.checkId.checked = true;
	window.close();
}
</script>
<title>ID Check</title>
</head>
<body class="bg-light">

	<div class="container col" style="text-align: center; margin-top: 3rem;">
		<h3>&laquo;아이디 중복확인 결과&raquo;</h3>
	<%
		request.setCharacterEncoding("utf-8");
		String id = request.getParameter("id");
		SignupDAO dao = SignupDAO.getInstance();
		boolean res = dao.confirmId(id);
	%>
		<label>입력 ID: <strong><%=id %></strong></label>
	<%
		if(!res){ 
	%>
		<p>사용 가능한 아이디 입니다.</p>
		<a href='#' onclick="idConfirm('<%=id %>')" class="btn btn-success">적용</a>
		<% }
			else{
		%>
			<p style='color: red'>해당 아이디는 사용하실 수 없습니다.</p>
		<%} %>
		<hr>
		<a href="javascript:history.back()" class="btn btn-secondary">다시시도</a> &nbsp; &nbsp; &nbsp; &nbsp;
		<a href="javascript:window.close()" class="btn btn-danger">창닫기</a>
	</div>
</body>
</html>