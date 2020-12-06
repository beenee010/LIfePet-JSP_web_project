<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dto.Order" %>
<html>
<head>
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author"
	content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
<meta name="generator" content="Jekyll v4.1.1">
<link rel="stylesheet" href="/resources/css/bootstrap.min.css"/>
<title>주문 정보</title>
</head>
<body class="bg-light">
	<%
		String sess = (String) session.getAttribute("userID");
		if(sess == null){
			response.sendRedirect("/main/login.jsp");
		}
		
		String u_oid = request.getParameter("u_oid");
		
		ArrayList<Order> orderList = (ArrayList<Order>)session.getAttribute("oList");
		Order order = null;
		for(int i = 0; i < orderList.size(); i++){
			order = orderList.get(i);
			String o_oid = Integer.toString(order.getO_oid());
			if(o_oid.equals(request.getParameter("id"))){
				break;
			}
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
				<p> <em>주문일: <%=order.getDate() %></em>
			</div>
		</div>
		
		<div class="row justify-content-between">
			<div class="col-12" align="left">
				<strong>배송 주소</strong> <br> 아이디: <%=sess %><br>
				우편번호: <%=order.getZip() %><br>
				주소: <%=order.getAddress() %><br>
				메모: <%=order.getMemo() %><br>
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
				
				<tr>
					<td class="text-center"><em><%=order.getName() %></em></td>
					<td class="text-center"><%=order.getQuantity() %></td>
					<td class="text-center"><%=order.getUnitPrice() %>원</td>
					<td class="text-center"><%=order.getTotal() %>원</td>
				</tr>
			</table>
		</div>
		<br>
		<div class="text-center">
			<a href="/main/orderList.jsp?oid=<%=u_oid %>" class="btn btn-secondary" role="button">이전</a>
		</div>
	</div>
	<hr width="80%">
	<jsp:include page="/main/footer.jsp"/>
</body>
</html>