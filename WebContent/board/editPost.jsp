<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.sql.*" %>
<%@ page import="dto.Post" %>
<%@ page import="dao.PostRepository" %>
<html>
<head>
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author"
	content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
<meta name="generator" content="Jekyll v4.1.1">
<link rel="stylesheet" href="/resources/css/bootstrap.min.css">
<script type="text/javascript" src="/resources/js/editPostValidation.js"></script>
<title>Edit Post</title>
</head>
<body class="bg-light">
	<%
		String u_id = (String) session.getAttribute("userID");
		String u_oid = (String) session.getAttribute("userOid");
		if(u_id == null){
			response.sendRedirect("/main/login.jsp");
		}
		 
		String id = request.getParameter("id");
		
		String param_ko = "?id=" + id + "&u_oid=" + u_oid + "&language=ko";
		String param_en = "?id=" + id + "&u_oid=" + u_oid + "&language=en";
		
		PostRepository dao = PostRepository.getInstance();
		Post post = dao.getPostById(id);
	%>

	<jsp:include page="/main/menu.jsp"/>
	
	<fmt:setLocale value='<%=request.getParameter("language") %>'/>
	<fmt:bundle basename="bundle.post_myBundle">
	<div class="jumbotron" style="margin-top: 3rem">
		<div class="container">
			<h1 class="display-3"><fmt:message key="editPost"/></h1>
		</div>
	</div>
	
	<div class="container">
		<div class="text-right">
			<a href="<%=param_ko %>">Korean</a>|<a href="<%=param_en %>">English</a>
		</div>
		<form name="newPost" action="/board/processEditPost.jsp?id=<%=id %>" class="form-horizontal" method="post" enctype="multipart/form-data">
			
			<div class="form-group row">
				<label class="col-sm-2"><fmt:message key="postName"/></label>
				<div class="col-sm-3">
					<input type="text" id="postName" name="postName" value="<%=post.getTitle() %>" class="form-control" maxlength="100">
				</div>
			</div>
						
			<div class="form-group row">
				<label class="col-sm-2"><fmt:message key="postText"/></label>
				<div class="col-sm-9">
					<textarea id="postText" name="postText" cols="300" rows="10" class="form-control"><%=post.getText() %></textarea>
				</div>
			</div>
			
			<div class="form-group row">
				<label class="col-sm-2"><fmt:message key="postCategory"/></label>
				<div class="col-sm-3">
					<input type="text" id="postCategory" name="postCategory" value="<%=post.getCategory() %>" class="form-control" maxlength="30">
				</div>
			</div>
			
			<div class="form-group row">
				<label class="col-sm-2"><fmt:message key="postImage"/></label>
				<div class="col-sm-3">
					<input type="file" id="filename" name="filename" accept="image/*">
					<p class="lead text-muted"><br>파일을 수정하시려면 새로 업로드 해주세요.</p>
				</div>
				<div class="col-sm-3">
					<img src="/resources/images/<%=post.getImageName()%>" style="width: 100%" class="img-thumbnail">
				</div>
			</div>
			
			<div class="form-group row">
				<div class="col-sm-offset-2 col-sm-10">
					<input type="button" class="btn btn-primary" value='<fmt:message key="button"/>' onclick="CheckFormData()">
				</div>
			</div>
		</form>
	</div>
	<hr>
	</fmt:bundle>
	
	<jsp:include page="/main/footer.jsp"/>
</body>
</html>
