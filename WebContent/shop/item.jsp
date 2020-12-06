<%@ page language="java" contentType="text/html; charset=UTF-8" %>
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
<title>Item</title>
<script type="text/javascript">
	function addToCart(){
		if(confirm("상품을 장바구니에 추가하시겠습니까 ?"))
			document.addForm.submit();
		else
			document.addForm.reset();
	}
	function deleteItem(id, u_oid){
	    if(confirm("상품을 삭제하시겠습니까?"))
	    	location.href = "/shop/deleteItem.jsp?id=" + id + "&u_oid=" + u_oid;
	    else
	    	return;
	}
	function editItem(id, u_oid){
	    if(confirm("상품을 수정하시겠습니까?"))
	        location.href = "/shop/editItem.jsp?id=" + id + "&u_oid=" + u_oid;
	    else
	    	return;
	}
</script>
</head>
<body class="bg-light">
	<%
		String id = request.getParameter("id");
		ItemRepository dao = ItemRepository.getInstance();
		Item item = dao.getItemById(id);
		request.setAttribute("item", item);
	%>
	<jsp:include page="/shop/addItemHit.jsp">
		<jsp:param name="i_uid" value="<%=item.getUserOid() %>"/>
		<jsp:param name="i_oid" value="<%=item.getId() %>"/>
	</jsp:include>

	<jsp:include page="/main/menu.jsp"/>
	
	<div class="jumbotron">
		<div class="container"  style="margin-top: 3rem">
			<h1 class="display-3">상품 정보</h1>
			<p class="lead text-muted">
				엄선한 상품입니다.<br>재고가 부족할 시 문의 부탁드립니다.<br>
			</p>
		</div>
	</div>

	<div class="container">
		<div class="row">
			<p class="col-md-6"><img src="/resources/images/<%=item.getFileName()%>" style="width: 100%" class="img-thumbnail">
			<div class="col-md-6">
				<h3>[<%=item.getCategory() %>] <%=item.getName() %></h3><br>
				<p><b>상품 코드 : </b><span class="badge badge-danger"><%=item.getId() %></span>
				<p><b>판매자 : </b><%=item.getUserId() %>
				<p><b>재고수 : </b><%=item.getUnitsOfStock() %>
				<p><b>상태 : </b><%=item.getCondition() %>
				<p><b>등록일 : </b><%=item.getDate() %>
				<p><b>조회수 : </b><%=item.getHit() %>
				<h4><%=item.getUnitPrice() %>원</h4>
				<p>
				<form name="addForm" action="/shop/addCart.jsp?id=<%=item.getId() %>" method="post">
					<%
						if(item.getUnitsOfStock() < 1)
							out.println("<button class='btn btn-info' type='button' onclick='addToCart()' disabled>상품 주문 &raquo;</button>");
						else
							out.println("<a href='#' class='btn btn-info' onclick='addToCart()'>상품 주문 &raquo;</a>");
					%>
					<a href="/shop/cart.jsp" class="btn btn-warning">장바구니 &raquo;</a>
					<a href="/shop/shop.jsp" class="btn btn-secondary">상품 목록 &raquo;</a>
				</form>
					<%
					String sess = (String)session.getAttribute("userID");
					if(sess != null){
					boolean admin = (Boolean)session.getAttribute("admin");
					if(sess != null && admin){ %>
					<p>
					<form name="deleteForm" action="/shop/deleteItem.jsp?id=<%=item.getId().substring(4) %>&userId=<%=item.getUserOid() %>" method="post">
						<a href='javascript:deleteItem("<%=item.getId() %>", "<%=item.getUserOid() %>");' class='btn btn-danger'>삭제 &raquo;</a>
						<a href='javascript:editItem("<%=item.getId() %>", "<%=item.getUserOid() %>");' style='margin-left: 10px' class='btn btn-secondary'>수정 &raquo;</a>
					</form>

					<%} }%>
			</div>
			<div class="container" style="margin-top: 2rem; background-color: light-gray">
				<hr>
				<p class="card-text"><%=item.getDescription() %>
			</div>
		</div>
		<hr>
	</div>
	
	<jsp:include page="/main/footer.jsp"/>
</body>
</html>
