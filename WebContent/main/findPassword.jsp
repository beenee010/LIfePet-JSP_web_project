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
		<h3>&laquo;비밀번호 찾기&raquo;</h3>
		<form class="registerForm" method="post" action="processFindPassword.jsp"
			onsubmit="return blankCheck(this)" style="margin-top: 2rem;">
			<p>*아이디*<input type="text" name="id" maxlength="20" size="10"
			 class="form-control col-md-2" placeholder="ID" style="margin-top: 1rem;" autofocus>
			 <p>*이름*<input type="text" name="name" maxlength="20" size="10"
			 class="form-control col-md-2" placeholder="Name" style="margin-top: 1rem;" >
			<input type="submit" value="비밀번호 찾기" class="btn btn-primary" style="margin-top: 2rem;">
		</form>
	</div>
	<script>
		function blankCheck(f) {
			var id = f.id.value;
			var name = f.name.value;
			name = name.trim();
			id = id.trim();
			
			if (id.length < 5) {
				alert("아이디는 5자 이상 입력해주십시오.");
				return false;
			}
			if (name == "") {
				alert("이름을 입력해주십시오.");
				return false;
			}
			
			return true;
		}
	</script>
</body>
</html>