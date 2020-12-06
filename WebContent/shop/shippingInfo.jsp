<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<html>
<head>
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author"
	content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
<meta name="generator" content="Jekyll v4.1.1">
<link rel="stylesheet" href="/resources/css/bootstrap.min.css"/>
<script type="text/javascript" src="/resources/js/orderValidation.js"></script>
<title>Shipping Info</title>
</head>
<body class="bg-light">

	<%
		String u_id = (String) session.getAttribute("userID");
		if(u_id == null){
			response.sendRedirect("/main/login.jsp");
		}
		
		SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String to = fm.format(new Date());
	%>
	<jsp:include page="/main/menu.jsp"/>
	
	<div class="jumbotron" style="margin-top: 3rem">
		<div class="container">
			<h1 class="display-3">배송 정보</h1>
		</div>
	</div>
	
	<div class="container">
		<form name="orderForm" action="/shop/processShippingInfo.jsp" class="form-horizontal" method="post">
			<input type="hidden" name="cartId" value="<%=request.getParameter("cartId") %>">
			<div class="form-group row">
				<label class="col-sm-2">아이디</label>
				<div class="col-sm-3">
					<input name="id" type="text" value="<%=u_id %>" class="form-control" disabled>
				</div>
			</div>
			
			<div class="form-group row">
				<label class="col-sm-2">성명</label>
				<div class="col-sm-3">
					<input name="name" type="text" class="form-control">
				</div>
			</div>
			
			<div class="form-group row">
				<label class="col-sm-2">국가명</label>
				<div class="col-sm-3">
					<input type="text" name="country" class="form-control">
				</div>
			</div>
			
			<div class="form-group row">
				<label class="col-sm-2">우편번호</label>
				<div class="col-sm-3">
					<input type="text" name="zip" class="form-control">
				</div>
			</div>
			
			<div class="form-group row">
				<label class="col-sm-2">주소</label>
				<div class="col-sm-5">
					<input type="text" name="address" class="form-control">
				</div>
			</div>
			
			<div class="form-group row">
				<label class="col-sm-2">메모</label>
				<div class="col-sm-5">
					<textarea class="form-control" name="memo" placeholder="메모를 남겨주세요."></textarea>
				</div>
			</div>
			
			<div class="form-group row">
				<label class="col-sm-2">주문일</label>
				<div class="col-sm-5">
					<input type="text" name="date" value="<%=to%>" class="form-control" disabled>
				</div>
			</div>
			
			<div class="form-group row">
				<div class="col-sm-offset-2 col-sm-10">
					<a href="/shop/cart.jsp?cartId=<%=request.getParameter("cartId") %>" class="btn btn-secondary" role="button">이전</a>
					<input type="button" class="btn btn-primary" onclick="OrderCheck()" value="등록">
					<a href="/shop/checkOutCancelled.jsp" class="btn btn-secondary" role="button">취소</a>
				</div>
			</div>
		</form>
		<hr>
	</div>
	<jsp:include page="/main/footer.jsp"/>
</body>
</html>
