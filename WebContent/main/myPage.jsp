<%@page import="java.util.StringTokenizer"%>
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
<script type="text/javascript" src="/resources/js/updateValidation.js"></script>
<title>My Page</title>
</head>
<body class="bg-light">
	<%
		String sess = (String)session.getAttribute("userID");
		if(sess == null)
			response.sendRedirect("/main/login.jsp");
	%>
	<%@ include file="/main/menu.jsp" %>

    <div class="container" style="margin-top: 3rem">
  		<div class="py-5 text-center">
    		<img class="d-block mx-auto mb-4" src="/resources/logo/logo.png" alt="" width="72" height="72">
    		<h2>Update Form</h2>
    		<p class="lead">당신의 정보입니다.<br>수정하실 정보를 입력하고 버튼을 눌러주세요.</p>
  		</div>
	
	<%@ include file="/dbconn.jsp" %>
	<%
		request.setCharacterEncoding("utf-8");
	
		String u_oid = request.getParameter("id");
		String name = "";
		String uid = "";
		String _phone = "";
		String passwd = "";
		String _email = "";
		String address = "";
		boolean agree = false;
		
		Statement st = null;
		ResultSet rs = null;
		
		try{
			String sql = "SELECT * FROM USER WHERE u_oid='" + u_oid + "'";
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			if(rs.next()){
				uid = rs.getString(2);
				name = rs.getString(4);
				_phone = rs.getString(5);
				_email = rs.getString(6);
				address = rs.getString(7);
				agree = rs.getBoolean(8);
			}
		} catch (SQLException ex){
			System.out.println("Update 실패<br>");
			System.out.println("Error: " + ex.getMessage());
		} finally{
			if(st != null)
				st.close();
			if(conn != null)
				conn.close();
		}
		
		String[] phone = new String[3];
		int i = 0;
		
		StringTokenizer stoken = new StringTokenizer(_phone, "-");
		
		while(stoken.hasMoreTokens()){
			phone[i] = stoken.nextToken();
			i++;
		}
		
		String[] email = new String[2];
		i = 0;
		
		stoken = new StringTokenizer(_email, "@");
		
		while(stoken.hasMoreTokens()){
			email[i] = stoken.nextToken();
			i++;
		}
	%>
    
    <div>
      <h4 class="mb-3">Update</h4>
      <div class="text-right">
        <button class="btn btn-secondary" type="button" onclick="location.href='/shop/cart.jsp'">장바구니</button>
        <button class="btn btn-success" type="button" onclick="location.href='/main/orderList.jsp?oid=<%=u_oid %>'">주문 목록</button>
      	<button class="btn btn-info" type="button" onclick="location.href='/main/petList.jsp?oid=<%=u_oid %>'">반려동물 목록</button>
      	<button class="btn btn-primary" type="button" onclick="location.href='/main/petRegister.jsp?oid=<%=u_oid %>'">반려동물 추가</button>
      </div>
      <form class="registerForm" id="updateForm" name="updateForm" method="post" action="/main/processUpdateMyPage.jsp?oid=<%=u_oid %>">
      
        <div class="mb-3">
          	<label for="firstName">Name</label>
            <input type="text" class="form-control" id="name" name="name" value="<%=name %>">
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
        		<input type="text" class="form-control col-md-2" id="phone2" name="phone2" placeholder="0000" value="<%=phone[1] %>" aria-label="phone2" aria-describedby="addon-wrapping">
  				<div class="input-group-prepend">
    				<span class="input-group-text" id="addon-wrapping">-</span>
  				</div>
  				<input type="text" class="form-control col-md-2" id="phone3" name="phone3" placeholder="0000" value="<%=phone[2] %>" aria-label="phone3" aria-describedby="addon-wrapping">
			</div>
		</div>

        <div class="mb-3">
          <label for="userId">UserID</label>
          <div class="input-group">
            <input type="text" class="form-control" id="id" name="id" value="<%=uid %>" placeholder="UserID" readonly>
          </div>
        </div>

        <div class="mb-3">
          <label for="password">Password</label>
          <div class="input-group">
            <input type="password" class="form-control" id="password" name="password" placeholder="Password">

          </div>
        </div>

        <div class="mb-3">
          <label for="password">Password Confirm</label>
          <div class="input-group">
            <input type="password" class="form-control" id="passwordc" name="passwordc" placeholder="Password Confirm">
          </div>
        </div>
        
        <div class="mb-3">
        	<label for="email">Email</label>
        	<div class="input-group flex-nowrap">
        		<input type="text" class="form-control col-md-3" id="email1" name="email1" value="<%=email[0] %>" placeholder="abc123" aria-label="abc123" aria-describedby="addon-wrapping">
  				<div class="input-group-prepend">
    				<span class="input-group-text" id="addon-wrapping">@</span>
  				</div>
  				<input type="text" class="form-control col-md-3" id="email2" name="email2" value="<%=email[1] %>" placeholder="domain.com" aria-label="domain.com" aria-describedby="addon-wrapping">
			</div>
		</div>

        <div class="mb-3">
          <label for="address">Address</label>
          <input type="text" class="form-control" id="address" name="address" value="<%=address %>" placeholder="1234 Main St">
        </div>

        <hr class="mb-4">
    	
        <div class="form-group">
      		<div class="form-check">
        		<input type="checkbox" class="form-check-input" id="mailAgree" name="mailAgree" checked>
        		<label class="form-check-label">광고성 메일을 받는것에 동의합니다.</label>
      		</div>
    	</div>
        
        <hr class="mb-4">
        <button class="btn btn btn-lg btn-success btn-block" type="button" onclick="CheckRegister()">Update</button>
      </form>
    </div>
  </div>

	<jsp:include page="/main/footer.jsp"/>
</body>
</html>

