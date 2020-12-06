<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author"
	content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
<meta name="generator" content="Jekyll v4.1.1">
<link rel="stylesheet" href="/resources/css/bootstrap.min.css">
<script type="text/javascript" src="/resources/js/addItemValidation.js"></script>
<title>Add Flea Item</title>
</head>
<body class="bg-light">
	<%
		String u_id = (String) session.getAttribute("userID");
		if(u_id == null){
			response.sendRedirect("/main/login.jsp");
		}
	%>
	
	<jsp:include page="/main/menu.jsp"/>
	
	<fmt:setLocale value='<%=request.getParameter("language") %>'/>
	<fmt:bundle basename="bundle.item_myBundle">
	<div class="jumbotron" style="margin-top: 3rem">
		<div class="container">
			<h1 class="display-3"><fmt:message key="title"/></h1>
		</div>
	</div>
	
	<div class="container">
		<div class="text-right">
			<a href="?language=ko">Korean</a>|<a href="?language=en">English</a>
		</div>
		<form name="newItem" action="/fleaMarket/processAddFleaItem.jsp" class="form-horizontal" method="post" enctype="multipart/form-data">
			
			<div class="form-group row">
				<label class="col-sm-2"><fmt:message key="name"/></label>
				<div class="col-sm-3">
					<input type="text" id="name" name="name" class="form-control" maxlength="30">
				</div>
			</div>
			
			<div class="form-group row">
				<label class="col-sm-2"><fmt:message key="unitPrice"/></label>
				<div class="col-sm-3">
					<input type="text" id="unitPrice" name="unitPrice" class="form-control" maxlength="10">
				</div>
			</div>
						
			<div class="form-group row">
				<label class="col-sm-2"><fmt:message key="description"/></label>
				<div class="col-sm-5">
					<textarea id="description" name="description" cols="50" rows="2" class="form-control"></textarea>
				</div>
			</div>
			
			<div class="form-group row">
				<label class="col-sm-2"><fmt:message key="category"/></label>
				<div class="col-sm-3">
					<input type="text" id="category" name="category" class="form-control" maxlength="20">
				</div>
			</div>
			
			<div class="form-group row">
				<label class="col-sm-2"><fmt:message key="unitsInStock"/></label>
				<div class="col-sm-3">
					<input type="text" id="unitsInStock" name="unitsInStock" class="form-control" maxlength="11">
				</div>
			</div>
			
			<div class="form-group row">
				<label class="col-sm-2"><fmt:message key="condition"/></label>
				<div class="col-sm-5">
					<input type="radio" name="condition" value="N" checked><fmt:message key="condition_New"/> 
					<input type="radio" name="condition" value="O"><fmt:message key="condition_Old"/> 
				</div>
			</div>
			
			<div class="form-group row">
				<label class="col-sm-2"><fmt:message key="image"/></label>
				<div class="col-sm-3">
					<input type="file" id="filename" name="filename" accept="image/*" required>
				</div>
			</div>
			
			<div class="form-group row">
				<div class="col-sm-offset-2 col-sm-10">
					<button type="button" class="btn btn-primary" onclick="CheckFormData()"><fmt:message key="button"/></button>
				</div>
			</div>
		</form>
	</div>
	<hr>
	</fmt:bundle>
	
	<jsp:include page="/main/footer.jsp"/>
</body>
</html>
