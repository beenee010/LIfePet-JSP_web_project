<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="dto.Flea" %>
<%@ page import="dao.FleaRepository" %>
<html>
<head>
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author"
	content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
<meta name="generator" content="Jekyll v4.1.1">
<link rel="stylesheet" href="/resources/css/bootstrap.min.css">
<title>Flea Item</title>
<script type="text/javascript">
function deleteBoard(){
    if(confirm("글을 삭제하시겠습니까?"))
        document.deleteForm.submit();
    else
    	return;
}
function deleteFlea(){
    if(confirm("상품을 삭제하시겠습니까?"))
    	location.href = "/fleaMarket/deleteFlea.jsp?id=" + id + "&u_oid=" + u_oid;
    else
    	return;
}
function editFlea(id, u_oid){
    if(confirm("상품을 수정하시겠습니까?"))
        location.href = "/fleaMarket/editFlea.jsp?id=" + id + "&u_oid=" + u_oid;
    else
    	return;
}
</script>
</head>
<body class="bg-light">
	<%
		String id = request.getParameter("id");
		FleaRepository dao = FleaRepository.getInstance();
		Flea flea = dao.getFleaById(id);
		request.setAttribute("flea", flea);
	%>
	<jsp:include page="/fleaMarket/addFleaItemHit.jsp">
		<jsp:param name="f_uid" value="<%=flea.getUserOid() %>"/>
		<jsp:param name="f_oid" value="<%=flea.getId() %>"/>
	</jsp:include>

	<jsp:include page="/main/menu.jsp"/>
	
	<div class="jumbotron">
		<div class="container"  style="margin-top: 3rem">
			<h1 class="display-3">상품 정보</h1>
			<p class="lead text-muted">
				개인의 물품입니다.<br>자유롭게 연락하고 구매하세요 !<br>
			</p>
		</div>
	</div>

	<div class="container">
		<div class="row">
			<p class="col-md-6"><img src="/resources/images/<%=flea.getFileName()%>" style="width: 100%" class="img-thumbnail">
			<div class="col-md-6">
				<h3>[<%=flea.getCategory() %>] <%=flea.getName() %></h3><br>
				<p><b>상품 코드 : </b><span class="badge badge-danger"><%=flea.getId() %></span>
				<p><b>판매자 : </b><%=flea.getUserId() %>
				<p><b>재고수 : </b><%=flea.getUnitsOfStock() %>
				<p><b>상태 : </b><%=flea.getCondition() %>
				<p><b>등록일 : </b><%=flea.getDate() %>
				<p><b>연락처 : </b><%=flea.getPhone() %>
				<p><b>조회수 : </b><%=flea.getHit() %>
				<h4><b>가격 : </b><%=flea.getUnitPrice() %>원</h4>
				<p><a href="/fleaMarket/fleaMarket.jsp" class="btn btn-secondary">상품 목록 &raquo;</a>
				<%
					String u_Oid = (String)session.getAttribute("userOid");
					if(u_Oid != null && u_Oid.equals(flea.getUserOid())){ %>
					<p>
					<form name="deleteForm" action="/fleaMarket/deleteFlea.jsp?id=<%=flea.getId().substring(4) %>&userId=<%=flea.getUserOid() %>" method="post">
						<a href='javascript:deleteFlea("<%=flea.getId() %>", "<%=flea.getUserOid() %>");' class='btn btn-danger'>삭제 &raquo;</a>
						<a href='javascript:editFlea("<%=flea.getId() %>", "<%=flea.getUserOid() %>");' style='margin-left: 10px' class='btn btn-secondary'>수정 &raquo;</a>
					</form>
					<%}%>
			</div>
			<div class="container" style="margin-top: 2rem; background-color: light-gray">
				<hr>
				<p class="card-text"><%=flea.getDescription() %>
			</div>
		</div>
		<hr>
	</div>
	
	<jsp:include page="/main/footer.jsp"/>
</body>
</html>
