<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.ArrayList" %>
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
<link rel="stylesheet" href="/resources/css/bootstrap.min.css"/>
<%
	String cartId = session.getId();
%>
<title>Cart</title>
</head>
<body class="bg-light">
	<%
		if((String)session.getAttribute("userOid") == null){
			response.sendRedirect("/main/login.jsp");
			return;
		}
	%>

	<jsp:include page="/main/menu.jsp"/>
	
	<div class="jumbotron">
		<div class="container" style="margin-top: 3rem">
			<h1 class="display-3">장바구니</h1>
		</div>
	</div>
	
	<div class="container">
		<div class="row">
			<table width="100%">
				<tr>
					<td align="left"><a href="/shop/deleteCart.jsp?cartId=<%=cartId%>" class="btn btn-danger">삭제하기</a></td>
					<td align="right"><a href="/shop/shippingInfo.jsp?cartId=<%=cartId %>" class="btn btn-success">주문하기</a></td>
				</tr>
			</table>
		</div>
		
		<div style="padding-top: 50px">
			<table class="table table-hover">
				<tr>
					<th>상품</th>
					<th>가격</th>
					<th>수량</th>
					<th>소계</th>
					<th>비고</th>
				</tr>
				<%
					int sum = 0;
					ArrayList<Item> cartList = (ArrayList<Item>)session.getAttribute("cartlist");
					
					if(cartList == null)
						cartList = new ArrayList<Item>();
					
					for(int i = 0; i < cartList.size(); i++){
						Item item = cartList.get(i);
						int total = item.getQuantity()* item.getUnitPrice();
						sum += total;
				%>
				<tr>
					<td><%=item.getId() %> - <%=item.getName() %></td>
					<td><%=item.getUnitPrice() %></td>
					<td><%=item.getQuantity() %></td>
					<td><%=total %></td>
					<td><a href="/shop/removeCart.jsp?id=<%=item.getId() %>" class="badge badge-danger">삭제</a></td>
				</tr>
				<%
					}
				%>
				<tr>
					<th></th>
					<th></th>
					<th>총액</th>
					<th><%=sum %></th>
					<th></th>
				</tr>
			</table>
			<a href="/shop/shop.jsp" class="btn btn-secondary"> &laquo; 쇼핑 계속하기</a>
		</div>
		<hr>
	</div>
	
	<jsp:include page="/main/footer.jsp"/>
</body>
</html>
