<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author"
	content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
<meta name="generator" content="Jekyll v4.1.1">
<link rel="stylesheet" href="/resources/css/bootstrap.min.css">
<link rel="stylesheet" href="/resources/css/bootstrap.min.css">
<script type="text/javascript" src="/resources/js/registerValidation.js">

</script>
<title>Register</title>
</head>
<body class="bg-light">

	<%@ include file="/main/menu.jsp"%>

	<div class="container" style="margin-top: 3rem">
		<div class="py-5 text-center">
			<img class="d-block mx-auto mb-4" src="/resources/logo/logo.png"
				alt="" width="72" height="72">
			<h2>Register Form</h2>
			<p class="lead">
				회원가입을 위해 아래의 사항을 입력해 주세요.<br>감사합니다.
			</p>
		</div>


		<div>
			<h4 class="mb-3">Register</h4>
			
			<form class="registerForm" id="registerForm" name="registerForm" method="post" action="/main/register_process.jsp">
				<div class="mb-3">
					<label for="userId">Name</label>
					<div class="input-group">
						<input type="text" class="form-control" id="name" name="name" placeholder="Name" maxlength="20">
					</div>
				</div>

				<div class="mb-3">
					<label for="email">Phone</label>
					<div class="input-group flex-nowrap">
						<select class="custom-select d-block col-md-2" id="phone1" name="phone1">
							<option value="010">010</option>
							<option value="011">011</option>
							<option value="016">016</option>
							<option value="017">017</option>
							<option value="018">018</option>
						</select>
						<div class="input-group-prepend">
							<span class="input-group-text" id="addon-wrapping">-</span>
						</div>
						<input type="text" class="form-control col-md-2" id="phone2"
							name="phone2" placeholder="0000" aria-label="phone2"
							aria-describedby="addon-wrapping" maxlength="4">
						<div class="input-group-prepend">
							<span class="input-group-text" id="addon-wrapping">-</span>
						</div>
						<input type="text" class="form-control col-md-2" id="phone3"
							name="phone3" placeholder="0000" aria-label="phone3"
							aria-describedby="addon-wrapping" maxlength="4">
					</div>
				</div>

				<div class="mb-3">
					<label for="userId">UserID</label>
					<div class="input-group">
						<input type="text" class="form-control col-md-11" id="id" name="id"
							placeholder="UserID" maxlength="30">
						<button class="btn btn-primary" type="button" name="dupBtn" onclick="idCheck()" style="margin-left: 10px">중복확인</button>
						<input type="checkbox" id="checkId" name="checkId" style="display: none">
					</div>
				</div>

				<div class="mb-3">
					<label for="password">Password</label>
					<div class="input-group">
						<input type="password" class="form-control" id="password"
							name="password" placeholder="Password" maxlength="30">
					</div>
				</div>

				<div class="mb-3">
					<label for="password">Password Confirm</label>
					<div class="input-group">
						<input type="password" class="form-control" id="passwordc"
							name="passwordc" placeholder="Password Confirm" maxlength="30" >
					</div>
				</div>

				<div class="mb-3">
					<label for="email">Email</label>
					<div class="input-group flex-nowrap">
						<input type="text" class="form-control col-md-3" id="email1"
							name="email1" placeholder="abc123" aria-label="abc123"
							aria-describedby="addon-wrapping" maxlength="15">
						<div class="input-group-prepend">
							<span class="input-group-text" id="addon-wrapping">@</span>
						</div>
						<input type="text" class="form-control col-md-3" id="email2"
							name="email2" placeholder="domain.com" aria-label="domain.com"
							aria-describedby="addon-wrapping" maxlength="15">
					</div>
				</div>

				<div class="mb-3">
					<label for="address">Address</label> <input type="text"
						class="form-control" id="address" name="address"
						placeholder="1234 Main St" maxlength="50">
				</div>

				<hr class="mb-4">

				<div class="form-group">
					<div class="form-check">
						<input type="checkbox" class="form-check-input" id="privacyAgree">
						<label class="form-check-label">개인정보 수집에 동의합니다.</label>
					</div>
				</div>

				<div class="form-group">
					<div class="form-check">
						<input type="checkbox" class="form-check-input" id="mailAgree"
							name="mailAgree"> <label class="form-check-label">광고성
							메일을 받는것에 동의합니다.</label>
					</div>
				</div>

				<hr class="mb-4">
				<button class="btn btn btn-lg btn-success btn-block" type="button"
					onclick="CheckRegister()">Register</button>
			</form>
		</div>
	</div>

	<jsp:include page="/main/footer.jsp"/>
</body>
</html>

