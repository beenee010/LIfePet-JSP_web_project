<%@ page language="java" contentType="text/html; charset=UTF-8" %>
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
<script type="text/javascript">
function deletePost(){
    if(confirm("게시글을 삭제하시겠습니까?"))
    	location.href = "/board/deletePost.jsp?id=" + id + "&u_oid=" + u_oid;
    else
    	return;
}
function editPost(id, u_oid){
    if(confirm("게시글을 수정하시겠습니까?"))
        location.href = "/board/editPost.jsp?id=" + id + "&u_oid=" + u_oid;
    else
    	return;
}
</script>
<title>Post</title>
</head>
<body class="bg-light">
	<%
		String id = request.getParameter("id");
		PostRepository dao = PostRepository.getInstance();
		Post post = dao.getPostById(id);
		
		request.setAttribute("post", post);
	%>
	<jsp:include page="/board/addPostHit.jsp">
		<jsp:param name="p_uid" value="<%=post.getUserOid() %>"/>
		<jsp:param name="p_oid" value="<%=post.getPostId() %>"/>
	</jsp:include>
	<jsp:include page="/main/menu.jsp"/>
	
	<div class="jumbotron">
		<div class="container"  style="margin-top: 3rem">
			<h1 class="display-3">게시글</h1>
			<p class="lead text-muted">
				한 사람 한 사람의 소중한 추억입니다.<br>재밌게 읽어 주세요 !<br>
			</p>
		</div>
	</div>

	<div class="container">
		<div class="row">
			<p class="col-md-6"><img src="/resources/images/<%=post.getImageName()%>" style="width: 100%" class="img-thumbnail">
			<div class="col-md-6">
				<h3>[<%=post.getCategory() %>] <%=post.getTitle() %></h3><br>
				<p><b>글 번호 : </b><span class="badge badge-danger"><%=post.getPostId() %></span>
				<p><b>작성자 : </b><%=post.getUserId() %>
				<p><b>게시일 : </b><%=post.getPostDate() %>
				<p><b>조회수 : </b><%=post.getHit() %>
				<%
					String u_Oid = (String)session.getAttribute("userOid");
					if(u_Oid != null && u_Oid.equals(post.getUserOid())){ %>
						<p>
						<form name="deleteForm" action="/shop/deleteItem.jsp?id=<%=post.getPostId().substring(4) %>&userId=<%=post.getUserOid() %>" method="post">
							<a href='javascript:deletePost("<%=post.getPostId() %>", "<%=post.getUserOid() %>");' class='btn btn-danger'>삭제 &raquo;</a>
							<a href='javascript:editPost("<%=post.getPostId() %>", "<%=post.getUserOid() %>");' style='margin-left: 10px' class='btn btn-secondary'>수정 &raquo;</a>
					</form>
					<%}%>
			</div>
			

			
			<div class="container" style="margin-top: 2rem; background-color: light-gray">
				<hr>
				<p class="card-text"><%=post.getText() %>
			</div>
		</div>
		<hr>
	</div>
	
	<jsp:include page="/main/footer.jsp"/>
</body>
</html>
