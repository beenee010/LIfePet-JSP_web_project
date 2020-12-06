<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="dto.Post" %>
<%@ page import="dao.PostRepository" %>
<%@ page import="java.util.*" %>
<%@ page import="utils.Util" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

	<%
		request.setCharacterEncoding("utf-8");
	
		PostRepository postRepo = PostRepository.getInstance();
		HashMap<String, Post> postMap = postRepo.getPostes();
		Util util = new Util();
		
		String pageNum = request.getParameter("page");
		
		int currentPage = 1;
		
		if(pageNum != null)
			currentPage = Integer.parseInt(pageNum);
		
		String searchKey = request.getParameter("searchKey");
		String searchValue = request.getParameter("searchValue");
		
		int dataCount = postMap.size();
		
		int numPerPage = 5;
		
		int totalPage = util.getPageCount(numPerPage, dataCount); ///////
		
		
		if(currentPage > totalPage)
			currentPage = totalPage;
		
		int start = (currentPage - 1) * numPerPage;
		int end = numPerPage;
		
		ArrayList<Post> postList = postRepo.getList(start, end);
		
		String postUrl = "/board/board.jsp";
		String pageIndexList = util.pageIndexList(currentPage, totalPage, postUrl);
	%>

<html>
<head>
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author"
	content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
<meta name="generator" content="Jekyll v4.1.1">
<link rel="stylesheet" href="/resources/css/bootstrap.min.css">
<title>Board</title>
</head>
<body class="bg-light">
	<%@ include file="/main/menu.jsp" %>
	
	<section class="jumbotron text-center" style="margin-top: 3rem">
		<div class="container">
			<h1>게시판</h1>
			<p class="lead text-muted">
				반려동물과 함께라면 항상 행복합니다.<br>여러분의 추억을 기억해 주세요 !<br>
			</p>
			<%
				String u_id = (String) session.getAttribute("userID");
				if (u_id != null) {
			%>
			<p>
				<a href="/board/addPost.jsp" class="btn btn-primary my-2"
					role="button">게시글 작성&raquo;</a>
			</p>
			<%}%>
		</div>
	</section>


	
	<main role="main">
		<div class="container">
			<c:choose>
				<c:when test="${empty '<%=postMap %>' }">
					<div class="alert alert-primary" role="alert">상품이 없습니다.</div>
				</c:when>
				<c:otherwise>
					<div class="text-left" style="margin-left: 20px; margin-right: 20px;">
						<h3>최신글</h3>
						<div class="row"><hr style="width: 100%; height: 2px; margin-bottom: 2rem" ></div>
						<div class="row">
						<%
							for (Post post : postList) {
								String desc = post.getText();
								if(desc.length() > 100){
									desc = post.getText().substring(0, 100) + "...";
								}
						%>
						<div class="row">
						<p class="col-md-2"><img src="/resources/images/<%=post.getImageName()%>" 
						class="bd-placeholder-img bd-placeholder-img-lg featurette-image img-fluid mx-auto img-thumbnail"
						style="margin-bottom: 10px;">
							<div class="col-md-9">
								<h3>[<%=post.getCategory() %>] <%=post.getTitle() %></h3>
								<br>
								<div class="row">
									<p class="col-md-9"><%=desc %>
									<p class="col-md-3">
										<a href="/board/post.jsp?id=<%=post.getPostId() %>" class="btn btn-secondary" 
																			role="button">상세 정보 &raquo;</a>
								</div>
								<%=post.getPostId() + " | " + post.getUserId() + " | " + post.getPostDate() %>
							</div>
							<hr style="width: 100%; margin-bottom: 2rem">
						</div>
						<%
							}
						%>
						<hr>
					</div>
				</div>
				
			</c:otherwise>
		</c:choose>
		<nav aria-label="Page navigation example">
		<ul class="pagination justify-content-center" style="margin-top: 2rem;">
			<%=pageIndexList %>
		</ul>
		</nav>
		</div>
	
	</main>
	
	
	<%@ include file="/main/footer.jsp" %>
</body>
</html>