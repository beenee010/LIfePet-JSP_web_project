<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dto.Pet"%>
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
function deletePet(p_oid, u_oid){
	var res = confirm("정말 삭제 하시겠습니까?");
	
	if(res)
		location.href = "/main/deletePet.jsp?id=" + p_oid + "&u_oid=" + u_oid;
	else
		return;
}
</script>
<title>Pet List</title>
</head>
<body>
	<%
		String sess = (String)session.getAttribute("userOid");
		if(sess == null)
			response.sendRedirect("/main/login.jsp");

		String u_oid = request.getParameter("oid");
	%>
	
	<jsp:include page="/main/processPetList.jsp">
		<jsp:param value="<%=u_oid %>" name="oid"/>
	</jsp:include>
	
	<jsp:include page="/main/menu.jsp" />

	
	<div class="container" style="margin-top: 3rem">
		<div class="py-5 text-center">
			<img class="d-block mx-auto mb-4" src="/resources/logo/logo.png"
				alt="" width="72" height="72">
			<h2>반려동물</h2>
			<p class="lead">
				반갑습니다.<br>반려동물 목록입니다.
			</p>
		</div>
		<div class="text-right">
			<button class="btn btn-secondary" type="button"
				onclick="location.href='/main/myPage.jsp?id=<%=u_oid%>'">뒤로가기</button>
			<button class="btn btn-info" type="button"
				onclick="location.href='/main/petRegister.jsp?oid=<%=u_oid%>'">반려동물
				추가</button>
		</div>
	</div>
	<div class="container" style="margin-top: 3rem">
		<table class="table table-striped text-center">
			<thead>
				<tr>
					<th scope="col">Pet</th>
					<th scope="col">이름</th>
					<th scope="col">품종</th>
					<th scope="col">나이</th>
					<th scope="col">성별</th>
					<th scope="col">삭제</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="pet" items="${petList }" varStatus="vs" begin="0" end="${fn:length(petList)}" step="1">
					<tr>
						<th scope="row"></th>
						<td><c:out value="${pet.name}" /></td>
						<td><c:out value="${pet.breed}" /></td>
						<td><c:out value="${pet.age}" /></td>
						<td><c:out value="${pet.gender}" /></td>
						<td><a href="#" class="badge badge-danger" onclick="deletePet(${pet.oid}, <%=sess %>)">X</a></td>
					</tr>
				</c:forEach>

			</tbody>
		</table>
		<hr>
	</div>
	
	<jsp:include page="/main/footer.jsp"/>
</body>
</html>