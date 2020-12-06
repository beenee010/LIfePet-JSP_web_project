<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.sql.*" %>
<%@ page import="dto.Item" %>
<%@ page import="dao.ItemRepository" %>
<html>
<head>
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author"
	content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
<meta name="generator" content="Jekyll v4.1.1">
<link rel="stylesheet" href="/resources/css/bootstrap.min.css">
<script type="text/javascript" src="/resources/js/editItemValidation.js"></script>
<title>Edit Item</title>
</head>
<body class="bg-light">
	<%
		String u_id = (String) session.getAttribute("userID");
		String u_oid = (String) session.getAttribute("userOid");
		if(u_id == null){
			response.sendRedirect("/main/login.jsp");
		}
	%>
	
	<%
		String id = request.getParameter("id");
			
		String param_ko = "?id=" + id + "&u_oid=" + u_oid + "&language=ko";
		String param_en = "?id=" + id + "&u_oid=" + u_oid + "&language=en";
	
		ItemRepository dao = ItemRepository.getInstance();
		Item item = dao.getItemById(id);
	%>
	
	<jsp:include page="/main/menu.jsp"/>
	
	<fmt:setLocale value='<%=request.getParameter("language") %>'/>
	<fmt:bundle basename="bundle.item_myBundle">
	<div class="jumbotron" style="margin-top: 3rem">
		<div class="container">
			<h1 class="display-3"><fmt:message key="editItem"/></h1>
		</div>
	</div>
	
	<div class="container">
		<div class="text-right">
			<a href="<%=param_ko %>">Korean</a>|<a href="<%=param_en %>">English</a>
		</div>
		<form name="editItem" action="/shop/processEditItem.jsp?id=<%=id %>" class="form-horizontal" method="post" enctype="multipart/form-data">
			
			<div class="form-group row">
				<label class="col-sm-2"><fmt:message key="name"/></label>
				<div class="col-sm-3">
					<input type="text" id="name" name="name" value="<%=item.getName() %>" class="form-control" maxlength="30">
				</div>
			</div>
			
			<div class="form-group row">
				<label class="col-sm-2"><fmt:message key="unitPrice"/></label>
				<div class="col-sm-3">
					<input type="text" id="unitPrice" name="unitPrice" value="<%=item.getUnitPrice() %>" class="form-control" maxlength="10">
				</div>
			</div>
						
			<div class="form-group row">
				<label class="col-sm-2"><fmt:message key="description"/></label>
				<div class="col-sm-5">
					<textarea id="description" name="description" cols="50" rows="2" class="form-control"><%=item.getDescription() %></textarea>
				</div>
			</div>
			
			<div class="form-group row">
				<label class="col-sm-2"><fmt:message key="category"/></label>
				<div class="col-sm-3">
					<input type="text" id="category" name="category" value="<%=item.getCategory() %>" class="form-control" maxlength="20">
				</div>
			</div>
			
			<div class="form-group row">
				<label class="col-sm-2"><fmt:message key="unitsInStock"/></label>
				<div class="col-sm-3">
					<input type="text" id="unitsInStock" name="unitsInStock" value="<%=item.getUnitsOfStock() %>" class="form-control" maxlength="11">
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
				<div class="col-sm-4">
					<input type="file" id="filename" name="filename" accept="image/*" required>
					<p class="lead text-muted"><br>파일을 수정하시려면 새로 업로드 해주세요.</p>
				</div>
				<div class="col-sm-3">
					<img src="/resources/images/<%=item.getFileName()%>" style="width: 100%" class="img-thumbnail">
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
