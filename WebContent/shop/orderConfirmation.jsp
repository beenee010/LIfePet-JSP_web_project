<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="dto.Item" %>
<%@ page import="dao.ItemRepository" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.Date" %>

<%
	request.setCharacterEncoding("UTF-8");

	String cartId = session.getId();
	
	SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String to = fm.format(new Date());
	
	String shipping_cartId = "";
	String shipping_name = "";
	String shipping_shippingDate = to;
	String shipping_country = "";
	String shipping_zipCode = "";
	String shipping_addressName = "";
	String shipping_memo = "";
	
	Cookie[] cookies = request.getCookies();
	
	if(cookies != null){
		for(int i = 0; i < cookies.length; i++){
			Cookie thisCookie = cookies[i];
			String n = thisCookie.getName();
			if(n.equals("Shipping_cartId"))
				shipping_cartId = URLDecoder.decode((thisCookie.getValue()), "utf-8");
			if(n.equals("Shipping_name"))
				shipping_name = URLDecoder.decode((thisCookie.getValue()), "utf-8");
			if(n.equals("Shipping_country"))
				shipping_country = URLDecoder.decode((thisCookie.getValue()), "utf-8");
			if(n.equals("Shipping_zipCode"))
				shipping_zipCode = URLDecoder.decode((thisCookie.getValue()), "utf-8");
			if(n.equals("Shipping_addressName"))
				shipping_addressName = URLDecoder.decode((thisCookie.getValue()), "utf-8");
			if(n.equals("Shipping_memo"))
				shipping_memo = URLDecoder.decode((thisCookie.getValue()), "utf-8");
		}
	}
	
%>

<html>
<head>
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author"
	content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
<meta name="generator" content="Jekyll v4.1.1">
<link rel="stylesheet" href="/resources/css/bootstrap.min.css"/>
<title>Order Information</title>
</head>
<body class="bg-light">
	<%
		String u_id = (String) session.getAttribute("userID");
		if(u_id == null){
			response.sendRedirect("/main/login.jsp");
		}
	%>

	<jsp:include page="/main/menu.jsp"/>
	
	<div class="jumbotron" style="margin-top: 3rem">
		<div class="container">
			<h1 class="display-3">주문 정보</h1>
		</div>
	</div>
	
	<div class="container col-10 alert alert-success">
		<div class="text-align">
			<h1>영수증</h1>
			<div class="col-12" align="right">
				<p> <em>주문일: <%=shipping_shippingDate %></em>
			</div>
		</div>
		
		<div class="row justify-content-between">
			<div class="col-12" align="left">
				<strong>배송 주소</strong> <br> 아이디: <%=u_id %> <br> 성명: <%= shipping_name %><br>
				우편번호: <%=shipping_zipCode %><br>
				주소: <%=shipping_addressName %>(<%=shipping_country %>)<br>
				메모: <%=shipping_memo %><br>
			</div>
			
		</div>
		
		<div>
			<table class="table table-hover">
				<tr>
					<th class="text-center">상품</th>
					<th class="text-center">#</th>
					<th class="text-center">가격</th>
					<th class="text-center">소계</th>
				</tr>
				
				<%
					int sum = 0;
					ArrayList<Item> cartList = (ArrayList<Item>) session.getAttribute("cartlist");
					if(cartList == null)
						cartList = new ArrayList<Item>();
					
					for(int i = 0; i < cartList.size(); i++){
						Item item = cartList.get(i);
						int total = item.getUnitPrice() * item.getQuantity();
						sum += total;
				%>
				
				<tr>
					<td class="text-center"><em><%=item.getName() %></em></td>
					<td class="text-center"><%=item.getQuantity() %></td>
					<td class="text-center"><%=item.getUnitPrice() %>원</td>
					<td class="text-center"><%=total %>원</td>
				</tr>
				<%
					}
				%>
				
				<tr>
					<td></td>
					<td></td>
					<td class="test-right"><strong>총액: </strong></td>
					<td class="text-center text-danger"><strong><%=sum %></strong></td>
				</tr>
			</table>
			
			<a href="/shop/shippingInfo.jsp?cartId=<%=shipping_cartId %>" class="btn btn-secondary" role="button">이전</a>
			<a href="/shop/thankCustomer.jsp" class="btn btn-success" role="button">주문 완료</a>
			<a href="/shop/checkOutCancelled.jsp" class="btn btn-secondary" role="button">취소</a>
		</div>
	</div>
	<hr width="80%">
	<jsp:include page="/main/footer.jsp"/>
</body>
</html>
