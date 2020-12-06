<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="dto.Flea"%>
<%@ page import="dao.FleaRepository"%>
<%@ page import="java.util.*"%>
<%@ page import="utils.Util" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	request.setCharacterEncoding("utf-8");

	FleaRepository fleaRepo = FleaRepository.getInstance();
	HashMap<String, Flea> fleaMap = fleaRepo.getFleas();
	Util util = new Util();
	
	String pageNum = request.getParameter("page");
	
	int currentPage = 1;
	
	if(pageNum != null)
		currentPage = Integer.parseInt(pageNum);
	
	String searchKey = request.getParameter("searchKey");
	String searchValue = request.getParameter("searchValue");
	
	int dataCount = fleaMap.size();
	
	int numPerPage = 6;
	
	int totalPage = util.getPageCount(numPerPage, dataCount); ///////
	
	if(currentPage > totalPage)
		currentPage = totalPage;
	
	int start = (currentPage - 1) * numPerPage;
	int end = numPerPage;
	
	ArrayList<Flea> f_List = fleaRepo.getList(start, end);
	
	String postUrl = "/fleaMarket/fleaMarket.jsp";
	String pageIndexList = util.pageIndexList(currentPage, totalPage, postUrl);
%>

<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author"
	content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
<meta name="generator" content="Jekyll v4.1.1">
<title>Flea Market</title>

<link rel="canonical"
	href="https://getbootstrap.com/docs/4.5/examples/album/">
<link href="/resources/css/bootstrap.min.css" rel="stylesheet">
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
}
</style>
<link href="/resources/album.css" rel="stylesheet">
</head>
<body class="bg-light">
	<%@ include file="/main/menu.jsp"%>

	<main role="main">

		<section class="jumbotron text-center" style="margin-top: 3rem">
			<div class="container">
				<h1>중고 거래</h1>
				<p class="lead text-muted">
					가지고 있는 물건을 사용하긴 어렵고<br>버리긴 아까우신가요 ?<br>중고 거래를 해보세요 !
				</p>
				<p>
					<a href="/fleaMarket/addFleaItem.jsp" class="btn btn-primary my-2"
						role="button">상품 등록&raquo;</a>
				</p>
			</div>
		</section>

		<div class="album py-5">
			<div class="container">
				<c:choose>
					<c:when test="${empty '<%=fleaMap %>' }">
						<div class="alert alert-primary" role="alert">상품이 없습니다.</div>
					</c:when>
					<c:otherwise>
						<div class="row">
							<%
								for (Flea flea : f_List) {
								String desc = flea.getDescription();
								if (desc.length() > 60)
									desc = flea.getDescription().substring(0, 60) + "...";
								String name = flea.getName();
								if (name.length() > 12)
									name = name.substring(0, 12);
							%>
							<div class="col-md-4">
								<div class="card mb-4 shadow-sm ">
									<div style="background: gray;" width="100%" height="225">
										<img src="/resources/images/<%=flea.getFileName()%>"
											class="bd-placeholder-img card-img-top">
									</div>
									<div class="card-body" style="min-height: 200px;">
										<hr>
										<h5 class="card-title">
											[<%=flea.getCategory()%>]<br><%=name%></h5>
										<p class="card-text"><%=desc%></p>
									</div>
									<div
										class="card-footer d-flex justify-content-between align-items-end">
										<div class="btn-group ">
											<a href="/fleaMarket/fleaItem.jsp?id=<%=flea.getId()%>"
												class="btn btn-sm btn-outline-secondary" role="button">상세
												정보 &raquo;</a>
										</div>
										<small class="text-muted"><%=flea.getUserId() + "<br>" + flea.getDate().substring(0, 10)%></small>
									</div>
								</div>
							</div>
							<%
								}
							%>

						</div>
						<hr>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<nav aria-label="Page navigation example">
		<ul class="pagination justify-content-center" style="margin-top: 2rem;">
			<%=pageIndexList %>
		</ul>
		</nav>
	</main>

	<%@ include file="/main/footer.jsp"%>

	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
		integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
		crossorigin="anonymous"></script>
	<script>
		window.jQuery
				|| document
						.write('<script src="/assets/js/vendor/jquery.slim.min.js"><\/script>')
	</script>
	<script src="/assets/dist/js/bootstrap.bundle.min.js"></script>
</html>

