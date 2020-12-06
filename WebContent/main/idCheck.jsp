<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.SignupDAO"%>
<html>
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
		<h3>&laquo;아이디 중복확인&raquo;</h3>
		<form class="registerForm" method="post" action="processIdCheck.jsp"
			onsubmit="return blankCheck(this)" style="margin-top: 2rem;">
			<p>*아이디*<input type="text" name="id" maxlength="20" size="10"
			 class="form-control col-md-2" placeholder="ID" style="margin-top: 1rem;" autofocus>
			<input type="submit" value="중복확인" class="btn btn-primary" style="margin-top: 2rem;">
		</form>
	</div>
	<script>
		function blankCheck(f) {
			var id = f.id.value;
			id = id.trim();
			if (id.length < 5) {
				alert("아이디는 5자 이상 입력해주십시오.");
				return false;
			}//if end 
			return true;
		}//blankCheck() end
	</script>
</body>
</html>