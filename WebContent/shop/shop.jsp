<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="dto.Item"%>
<%@ page import="dao.ItemRepository"%>
<%@ page import="java.util.*"%>
<%@ page import="utils.Util" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	request.setCharacterEncoding("utf-8");

	ItemRepository itemRepo = ItemRepository.getInstance();
	HashMap<String, Item> itemMap = itemRepo.getItems();
	Util util = new Util();
	
	String pageNum = request.getParameter("page");
	
	int currentPage = 1;
	
	if(pageNum != null)
		currentPage = Integer.parseInt(pageNum);
	
	String searchKey = request.getParameter("searchKey");
	String searchValue = request.getParameter("searchValue");
	
	int dataCount = itemMap.size();
	
	int numPerPage = 6;
	
	int totalPage = util.getPageCount(numPerPage, dataCount); ///////
	
	if(currentPage > totalPage)
		currentPage = totalPage;
	
	int start = (currentPage - 1) * numPerPage;
	int end = numPerPage;
	
	ArrayList<Item> i_List = itemRepo.getList(start, end);
	
	String postUrl = "/shop/shop.jsp";
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
<title>Shop</title>
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
				<h1>반려동물 용품</h1>
				<p class="lead text-muted">
					저희가 엄선한 반려동물 용품입니다.<br>둘러보세요 !<br>고르고 골라 좋은 것들만 제공합니다 ^^
				</p>
				<p>
				<%
				String sess = (String)session.getAttribute("userID");
				if(sess != null){
					boolean admin = (Boolean) session.getAttribute("admin");
					if(admin){ %>
						<a href="/shop/addItem.jsp" class="btn btn-primary my-2"
						role="button">상품 등록&raquo;</a>
				<%	}
				}%>
	
				</p>
			</div>
		</section>

		<div class="album py-5">
			<div class="container">
				<c:choose>
					<c:when test="${empty '<%=itemMap %>' }">
						<div class="alert alert-primary" role="alert">상품이 없습니다.</div>
					</c:when>
					<c:otherwise>
						<div class="row">
							<%
								for (Item item : i_List) {
								String desc = item.getDescription();
								if (desc.length() > 60)
									desc = item.getDescription().substring(0, 60) + "...";
								String name = item.getName();
								if (name.length() > 12)
									name = name.substring(0, 12);
							%>
							<div class="col-md-4">
								<div class="card mb-4 shadow-sm ">
									<div style="background: gray;" width="100%" height="225">
										<img src="/resources/images/<%=item.getFileName()%>"
											class="bd-placeholder-img card-img-top">
									</div>
									<div class="card-body" style="min-height: 200px;">
										<hr>
										<h5 class="card-title">
											[<%=item.getCategory()%>]<br><%=name%></h5>
										<p class="card-text"><%=desc%></p>
									</div>
									<div
										class="card-footer d-flex justify-content-between align-items-end">
										<div class="btn-group ">
											<a href="/shop/item.jsp?id=<%=item.getId()%>"
												class="btn btn-sm btn-outline-secondary" role="button">상세
												정보 &raquo;</a>
										</div>
										<small class="text-muted"><%=item.getUserId() + "<br>" + item.getDate().substring(0, 10)%></small>
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

