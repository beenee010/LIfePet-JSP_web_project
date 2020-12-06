<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dto.Order"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
function descOrder(o_oid, u_oid){
	var res = confirm("주문 상세 정보를 확인하시겠습니까?");
	
	if(res)
		location.href = "/main/descriptionOrder.jsp?id=" + o_oid + "&u_oid=" + u_oid;
	else
		return;
}
function UpdateOrder(o_oid, state){

	var res = confirm("배송 상태를 업데이트 하시겠습니까?");
	
	if(res){
		location.href = "/main/updateOrder.jsp?oid=" + o_oid + "&state=" + state;
	}
	else
		return;
}
function deleteOrder(o_oid, o_uid, u_pass){
	
	var res = prompt("해당 주문을 삭제하시려면 관리자 비밀번호를 입력하세요.");
	
	if(res === u_pass){
		var con = confirm("정말 해당 주문을 삭제하시겠습니까?");
		
		if(res)
			location.href = "/main/deleteOrder.jsp?id=" + o_oid + "&u_oid=" + o_uid;
		else
			return;
	}
	else
		alert("비밀번호가 일치하지 않습니다.");
}
</script>
<title>Order List</title>
</head>
<body>
	<%
		String sess = (String)session.getAttribute("userID");
		if(sess == null)
			response.sendRedirect("/main/login.jsp");
		
		boolean admin = (Boolean) session.getAttribute("admin");
		String u_pass = (String)session.getAttribute("userPW");
		String u_oid = request.getParameter("oid");
	 	if(session.getAttribute("oList") != null){
			session.removeAttribute("oList");
	 	}
	%>
	
	<jsp:include page="/main/processOrderList.jsp">
		<jsp:param value="<%=u_oid %>" name="oid"/>
	</jsp:include>
	<%
		ArrayList<Order> oList = (ArrayList<Order>)request.getAttribute("orderList");
		session.setAttribute("oList", oList);
	%>
	<jsp:include page="/main/menu.jsp" />

	
	<div class="container" style="margin-top: 3rem">
		<div class="py-5 text-center">
			<img class="d-block mx-auto mb-4" src="/resources/logo/logo.png"
				alt="" width="72" height="72">
			<h2>주문 정보</h2>
			<p class="lead">
				반갑습니다.<br>주문 목록입니다.
			</p>
		</div>
		<div class="text-right">
			<button class="btn btn-secondary" type="button"
				onclick="location.href='/main/myPage.jsp?id=<%=u_oid%>'">뒤로가기</button>
		</div>
	</div>
	<div class="container" style="margin-top: 3rem">
	
		<table class="table table-striped text-center">
			<thead>
				<tr>
					<th scope="col">주문 번호</th>
					<th scope="col">상품명</th>
					<th scope="col">개수</th>
					<th scope="col">가격</th>
					<th scope="col">배송상태</th>
					<th scope="col">상세정보</th>
					<%
						if(admin){
							out.println("<th scope='col'>상태변경</th>");
							out.println("<th scope='col'>삭제</th>");
						}
					%>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="order" items="${orderList }" varStatus="vs" begin="0" end="${fn:length(orderList)}" step="1">
					<tr>
						<th scope="row"><c:out value="${order.o_oid}" /></th>
						<td><c:out value="${order.name}" /></td>
						<td><c:out value="${order.quantity}" /></td>
						<td><c:out value="${order.total}" /></td>
						<td><c:out value="${order.state}" /></td>
						<td>
						<a href="/main/descriptionOrder.jsp?id=${order.o_oid}&u_oid=${order.o_uid }" class="badge badge-success">상세정보</a>
						</td>
					<% if(admin){ %>
						<td>
							<select class="custom-select d-block" id="state" name="state" onChange="UpdateOrder(${order.o_oid}, this.value)">
								<option value="READY">Ready</option>
			            		<option value="SHIPPING">Shipping</option>
			            		<option value="COMPLETE">Complete</option>
							</select>
						</td>
						<td><a href="#" onclick="deleteOrder(${order.o_oid},${order.o_uid }, '<%=u_pass %>')" class="badge badge-danger">삭제</a></td>			
					<% } %>
					</tr>
				</c:forEach>
			</tbody>
		</table>

		<hr>
	</div>
	
	<jsp:include page="/main/footer.jsp"/>
</body>
</html>