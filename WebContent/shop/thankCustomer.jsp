<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
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
<title>Order Complete</title>
</head>
<body class="bg-light">
	<%@ include file="/dbconn.jsp"%>
	<%
		String u_id = (String) session.getAttribute("userID");
		if(u_id == null){
			response.sendRedirect("/main/login.jsp");
		}
	
		SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String to = fm.format(new java.util.Date());
	
		String shipping_cartId = "";
		String shipping_name = "";
		String shipping_memo = "";
		String shipping_country = "";
		String shipping_zipCode = "";
		String shipping_addressName = "";
		
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
		
		int sum = 0;
		ArrayList<Item> cartList = (ArrayList<Item>) session.getAttribute("cartlist");
		if(cartList == null)
			cartList = new ArrayList<Item>();
		
		for(int i = 0; i < cartList.size(); i++){
			Item item = cartList.get(i);
			int total = item.getUnitPrice() * item.getQuantity();
			sum += total;
			
			String userOid = (String)session.getAttribute("userOid");
			String userId = (String)session.getAttribute("userID");
			
			
			PreparedStatement pstmt = null;
			PreparedStatement _pstmt = null;
			try{
				String sql = "INSERT INTO ORDERING (o_uid, o_iid, o_count, o_total, o_zip, "
							+ "o_address, o_date, o_memo, o_state) "
							+ "VALUES(?, ?, ?, ?, ?, ?, now(), ?, 'READY')";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, userOid);
				pstmt.setString(2, item.getId().substring(4));
				pstmt.setInt(3, item.getQuantity());
				pstmt.setInt(4, sum);
				pstmt.setString(5, shipping_zipCode);
				pstmt.setString(6, shipping_addressName);
				pstmt.setString(7, shipping_memo);
				
				pstmt.executeUpdate();
				
				sql = "UPDATE ITEM SET i_unitsInStock=? WHERE i_oid=?";
				_pstmt = conn.prepareStatement(sql);
				_pstmt.setInt(1, item.getUnitsOfStock() - item.getQuantity());
				_pstmt.setString(2, item.getId().substring(4));
				item.setUnitsOfStock(item.getUnitsOfStock()-item.getQuantity());
				
				_pstmt.executeUpdate();
			} catch(SQLException ex){
				System.out.println("Update 실패");
				System.out.println("Error: " + ex.getMessage());
				ex.printStackTrace();
			} finally{
				if(_pstmt != null)
					_pstmt.close();
				if(pstmt != null)
					pstmt.close();
			}
			
		}
		if(conn != null)
			conn.close();
	%>
	
	<jsp:include page="/main/menu.jsp"/>
	<div class="jumbotron">
		<div class="container" style="margin-top: 3rem">
			<h1 class="display-3">주문 완료</h1>
		</div>
	</div>
	
	<div class="container">
		<h2 class="alert alert-danger">주문해주셔서 감사합니다.</h2>
		<p> 주문하신 날짜는 <%=to %>입니다.
		<p> 빠르게 배송될 예정입니다!
		<p> 주문번호: <%=shipping_cartId %>
	</div>
	
	<div class="container">
		<p> <a href="/shop/shop.jsp" class="btn btn-secondary">&laquo; 상품 목록</a>
	</div>
	<hr width="80%">
	<jsp:include page="/main/footer.jsp"/>
</body>
</html>
<%
	session.removeAttribute("cartlist");	

	for(int i = 0; i < cookies.length; i++){
		Cookie thisCookie = cookies[i];
		String n = thisCookie.getName();
		
		if(n.equals("Shipping_cartId"))
			thisCookie.setMaxAge(0);
		if(n.equals("Shipping_name"))
			thisCookie.setMaxAge(0);
		if(n.equals("Shipping_country"))
			thisCookie.setMaxAge(0);
		if(n.equals("Shipping_zipCode"))
			thisCookie.setMaxAge(0);
		if(n.equals("Shipping_addressName"))
			thisCookie.setMaxAge(0);
		
		response.addCookie(thisCookie);
	}
%>
