<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<html>
<head>
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author"
	content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
<meta name="generator" content="Jekyll v4.1.1">
<link rel="stylesheet" href="/resources/css/bootstrap.min.css">
<link href="/resources/css/signin.css" rel="stylesheet">
<script type="text/javascript" src="/resources/js/loginValidation.js">
</script>
<title>Login</title>
</head>
<body class="text-center container bg-light">
	<%
		String sess = (String)session.getAttribute("userID");
		if(sess != null)
			response.sendRedirect("/welcome.jsp");
	%>
	<%@ include file="/main/menu.jsp" %>
	
	<form class="form-signin" id="loginForm" name="loginForm" action="/main/login_process.jsp" style="width: 100%; max-width: 330px; padding: 15px; margin: auto">
		<img class="logo" src="/resources/logo/logo.png" alt="">
		<h1 class="h3 mb-3 font-weight-normal">Please Login</h1>
		<%
			String _error = request.getParameter("error");
		
			if(_error != null){
				int error = Integer.parseInt(_error);
				if(error == 1){
					out.println("<div class='alert alert-danger'>");
					out.println("아이디와 비밀번호를 확인해 주세요.");
					out.println("</div>");
				}
				else if(error == 2){
					out.println("<div class='alert alert-danger'>");
					out.println("아이디가 존재하지 않습니다.");
					out.println("</div>");
				}
			}
		%>
		
		<label class="sr-only">ID</label>
		<input type="text" id="id" name="id" class="form-control" placeholder="ID" maxlength="30" style="margin-bottom: 10px" autofocus>
		<label class="sr-only">Password</label>
		<input type="password" id="passwd" name="passwd" class="form-control" placeholder="Password" maxlength="30" >
		<br>
		<button class="btn btn-primary btn-lg btn-block" type="button" onclick="CheckLogin()">Login</button>
		<button class="btn btn-success btn-lg btn-block" type="button" onclick="location.href='/main/register.jsp'" >Register</button>
		<button class="btn btn-success btn-lg btn-block" type="button" onclick="findPassword()" style="margin-bottom: 3rem">Find Password</button>
		<jsp:include page="/main/footer.jsp"/>
	</form>
</body>
</html>