<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author"
	content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
<meta name="generator" content="Jekyll v4.1.1">
<link rel="stylesheet" href="/resources/css/bootstrap.min.css">
<script type="text/javascript" src="/resources/js/petRegisterValidation.js">
</script>
<title>Register</title>
</head>
<body class="bg-light">

	<%@ include file="/main/menu.jsp" %>

    <div class="container" style="margin-top: 3rem">
	  	<div class="py-5 text-center">
	    	<img class="d-block mx-auto mb-4" src="/resources/logo/logo.png" alt="" width="72" height="72">
	    	<h2>Pet Register</h2>
	    	<p class="lead">반려동물이 있으신가요?<br>있으시면 작성해 주세요.</p>
	  	</div>
	
	<%
		String u_oid = request.getParameter("oid");
	%>
	<div>
	  	<h4 class="mb-3">Pet Register</h4>
      	<form class="registerForm" name="petRegisterForm" method="post" action="/main/petRegister_process.jsp?oid=<%=u_oid %>">
			<div class="mb-3">
	          	<label>Pet Name</label>
	          		<div class="input-group">
	            		<input type="text" class="form-control" id="petName" name="petName" maxlength="30" placeholder="Pet Name">
	            	<div class="invalid-feedback" style="width: 100%;">Pet Name is required.</div>
	          </div>
	        </div>
	
			<div class="mb-3">
	          	<label>Breed</label>
	          	<div class="input-group">	
	            	<input type="text" class="form-control" id="petBreed" name="petBreed" maxlength="30" placeholder="Pet Breed">
	            	<div class="invalid-feedback" style="width: 100%;">Pet Breed is required.</div>
	          	</div>
	        </div>
	
	        <div class="mb-3">
	        	<label>Age</label>
	        	<div class="input-group flex-nowrap">
	        		<select class="custom-select d-block col-md-2" id="petAge" name="petAge">
					<c:forEach var="k" begin="1" end="50" step="1">
						<option value="${k}">${k}</option>
					</c:forEach>
	           		</select>
				</div>
			</div>
	
	        <div class="mb-3">
	        	<label>Gender</label>
	        	<div class="input-group flex-nowrap">
	        		<select class="custom-select d-block col-md-2" id="petGender" name="petGender">
	              		<option value="M">수컷</option>
	            		<option value="F">암컷</option>
	            		<option value="N">중성화</option>
	           		</select>
				</div>
			</div>
	        
	        <hr class="mb-4">
	        <button class="btn btn btn-lg btn-success btn-block" type="button" onclick="CheckRegister()">Pet Register</button>
	        <button class="btn btn btn-lg btn-success btn-block" type="button" onClick="skip()">Skip</button>
      </form>
    </div>
  </div>

	<jsp:include page="/main/footer.jsp"/>
</body>
</html>

