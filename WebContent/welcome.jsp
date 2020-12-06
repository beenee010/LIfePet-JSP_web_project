<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="dto.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author"
	content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
<meta name="generator" content="Jekyll v4.1.1">
<link rel="canonical" href="https://getbootstrap.com/docs/4.5/examples/carousel/">
<link rel="stylesheet" href="/resources/css/bootstrap.min.css">
<style>
.bd-placeholder-img {
	font-size: 1.125rem;
	text-anchor: middle;
	-webkit-user-select: none;
	-moz-user-select: none;
	-ms-user-select: none;
	user-select: none;
}

@media ( min-width : 768px) {
	.bd-placeholder-img-lg {
		font-size: 3.5rem;
	}
img.opac{
	filter: brightness(60%); 
	opacity: 0.4; 
	width:100%; 
	height:100%;
}
img.curved{
	width: 150px;
    height: 150px; 
    border-radius: 70%;
    overflow: hidden;
    margin-bottom: 1rem;
}
</style>
<link rel="stylesheet" href="/resources/css/carousel.css">
<title>Welcome</title>
</head>
<body>
	<%@ include file="/main/menu.jsp" %>

	<main role="main">

		<div id="myCarousel" class="carousel slide" data-ride="carousel">
			<ol class="carousel-indicators">
				<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
				<li data-target="#myCarousel" data-slide-to="1"></li>
				<li data-target="#myCarousel" data-slide-to="2"></li>
			</ol>
			<div class="carousel-inner">
				<div class="carousel-item active">
					<svg class="bd-placeholder-img" width="100%" height="100%"
						xmlns="http://www.w3.org/2000/svg"
						preserveAspectRatio="xMidYMid slice" focusable="false" role="img">
						<img src="/resources/images/haru.jpg" class="opac"></svg>
					
					<div class="container">
						<div class="carousel-caption text-left">
							<h1>여러분의 추억을 공유해주세요.</h1>
							<p>행복한 추억만 가득한 공간을 만들고 싶습니다. 지금 바로 게시판에 가서 추억을 남겨보세요 !</p>
							<p>
								<a class="btn btn-lg btn-primary" href="/board/board.jsp" role="button">Board</a>
							</p>
						</div>
					</div>
				</div>
				<div class="carousel-item">
					<svg class="bd-placeholder-img" width="100%" height="100%"
						xmlns="http://www.w3.org/2000/svg"
						preserveAspectRatio="xMidYMid slice" focusable="false" role="img">
						<img src="/resources/images/cat.jpg" class="opac"></svg>
					<div class="container">
						<div class="carousel-caption">
							<h1>여러분을 위해 준비했어요.</h1>
							<p>여러분의 소중한 반려동물이 사용하는 것이기에 엄선한 상품입니다. 믿고 사용해 주세요 !</p>
							<p>
								<a class="btn btn-lg btn-primary" href="/shop/shop.jsp" role="button">Shop</a>
							</p>
						</div>
					</div>
				</div>
				<div class="carousel-item">
					<svg class="bd-placeholder-img" width="100%" height="100%"
						xmlns="http://www.w3.org/2000/svg"
						preserveAspectRatio="xMidYMid slice" focusable="false" role="img">
						<img src="/resources/images/dog.jpg" class="opac">
					<div class="container">
						<div class="carousel-caption text-right">
							<h1>중고 거래를 일상화 합시다 !</h1>
							<p>버리기 아까운 물건이 있으신가요?<br>당신의 반려동물이 성장해서 더 이상 맞지 않으신가요?<br>
							중고 거래를 해보세요 !</p>
							<p>
								<a class="btn btn-lg btn-primary" href="/fleaMarket/fleaMarket.jsp" role="button">Flea Market</a>
							</p>
						</div>
					</div>
				</div>
			</div>
			<a class="carousel-control-prev" href="#myCarousel" role="button"
				data-slide="prev"> <span class="carousel-control-prev-icon"
				aria-hidden="true"></span> <span class="sr-only">Previous</span>
			</a> <a class="carousel-control-next" href="#myCarousel" role="button"
				data-slide="next"> <span class="carousel-control-next-icon"
				aria-hidden="true"></span> <span class="sr-only">Next</span>
			</a>
		</div>


		<!-- Marketing messaging and featurettes
  ================================================== -->
		<!-- Wrap the rest of the page in another container to center all the content. -->

		<%
			ItemRepository itemRepo = ItemRepository.getInstance();
			HashMap<String, Item> itemMap = itemRepo.getItems();
		%>
		<%@ include file="/processWelcome.jsp"%>
		<div class="container marketing">
			<c:choose>
					<c:when test="${empty '<%=itemMap %>' }">
						<div class="alert alert-primary" role="alert">상품이 없습니다.</div>
					</c:when>
					<c:otherwise>
			<!-- Three columns of text below the carousel -->
			<div class="row">
				<%	
					for (int i = 0; i < itemList.size(); i++) {
						int _i_oid = itemList.get(i);
						String i_oid = "ITEM" + _i_oid;
						Item item = itemMap.get(i_oid);
						
						String desc = item.getDescription();
						if (desc.length() > 60)
							desc = item.getDescription().substring(0, 60) + "...";
						String name = item.getName();
						if (name.length() > 12)
							name = name.substring(0, 12);
				%>
				<div class="col-lg-4">
					<img src="/resources/images/<%=item.getFileName()%>" 
					class="curved bd-placeholder-img bd-placeholder-img-lg featurette-image img-fluid mx-auto"
					style="border-radius: 70%; overflow: hidden; margin-bottom: 1rem;">
					<h2>[<%=name %>]</h2>
					<p><%=desc %></p>
					<p>
						<a class="btn btn-secondary" href="/shop/item.jsp?id=<%=i_oid %>" role="button">
							확인하기 &raquo;</a>
					</p>
				</div>
				<%
					}
				%>
			</div>
			
			</c:otherwise>
		</c:choose>
			<!-- /.row -->


			<!-- START THE FEATURETTES -->
			
			<%
				PostRepository postRepo = PostRepository.getInstance();
				HashMap<String, Post> postMap = postRepo.getPostes();
			%>

			<hr class="featurette-divider">
			<c:choose>
				<c:when test="${empty '<%=postMap %>' }">
					<div class="alert alert-primary" role="alert">상품이 없습니다.</div>
				</c:when>
				<c:otherwise>
				<%	
					for (int i = 0; i < postList.size(); i++) {
						int _p_oid = postList.get(i);
						String p_oid = "POST" + _p_oid;
						Post post = postMap.get(p_oid);
						
						String text = post.getText();
						if (text.length() > 200)
							text = post.getText().substring(0, 200) + "...";
						String title = post.getTitle();
						if (title.length() > 12)
							title = title.substring(0, 12);
				%>
					<div class="row featurette">
						<div class="col-md-7">
							<h2><br>
								[<%=post.getCategory() %>]<br>
								<span class="text-muted"><%=title %></span>
							</h2>
							<p class="lead"><%=text %></p>
						</div>
						<div class="col-md-5">
								<img width="500" height="500" aria-label="Placeholder: 500x500" src="/resources/images/<%=post.getImageName()%>" 
								class="bd-placeholder-img bd-placeholder-img-lg featurette-image img-fluid mx-auto img-thumbnail">
							<p><br><br>
							<div class="text-center">
								<a class="btn btn-secondary" href="/board/post.jsp?id=<%=p_oid %>" role="button">
									확인하기 &raquo;</a>
							</div>
							
						</div>
					</div>

				<hr class="featurette-divider">
				<%
					}
				%>
			</c:otherwise>
		</c:choose>
			<!-- /END THE FEATURETTES -->

		</div>
		<!-- /.container -->


		<!-- FOOTER -->
		<%@ include file="/main/footer.jsp" %>
	</main>
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
		integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
		crossorigin="anonymous"></script>
	<script>window.jQuery || document.write('<script src="/assets/js/vendor/jquery.slim.min.js"><\/script>')</script>
	<script src="/assets/dist/js/bootstrap.bundle.min.js"></script>
</html>
