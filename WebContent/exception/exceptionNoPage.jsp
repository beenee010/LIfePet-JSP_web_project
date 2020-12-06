<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<html>
<head>
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author"
	content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
<meta name="generator" content="Jekyll v4.1.1">
<link rel="stylesheet" href="./resources/css/bootstrap.min.css">
<title>페이지 오류</title>
</head>
<body>
	<jsp:include page="/main/menu.jsp"/>
	
	<div class="jumbotron" style="margin-top: 3rem">
		<div class="container" style="margin-top: 3rem">
			<h2 class="alert alert-danger">요청하신 페이지를 찾을 수 없습니다.</h2>
		</div>
	</div>
	
	<div class="container">
		<p><%=request.getRequestURI() %></p>
		<p class="text-right"> <a href="/welcome.jsp" class="btn btn-primary">메인 화면&raquo;</a>
	</div>
	<hr>
	<jsp:include page="/main/footer.jsp"/>
</body>
</html>
