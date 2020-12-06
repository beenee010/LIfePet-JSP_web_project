<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.util.*" %>


<%
	String u_id = (String) session.getAttribute("userID");
	if(u_id == null){
		response.sendRedirect("/main/login.jsp");
	}

	request.setCharacterEncoding("UTF-8");
	
	Cookie cartId = new Cookie("Shipping_cartId", URLEncoder.encode(request.getParameter("cartId"), "utf-8"));
	Cookie name = new Cookie("Shipping_name", URLEncoder.encode(request.getParameter("name"), "utf-8"));
	Cookie country = new Cookie("Shipping_country", URLEncoder.encode(request.getParameter("country"), "utf-8"));
	Cookie zipCode = new Cookie("Shipping_zipCode", URLEncoder.encode(request.getParameter("zip"), "utf-8"));
	Cookie addressName = new Cookie("Shipping_addressName", URLEncoder.encode(request.getParameter("address"), "utf-8"));
	Cookie memo = new Cookie("Shipping_memo", URLEncoder.encode(request.getParameter("memo"), "utf-8"));
	
	
	cartId.setMaxAge(24 * 60 * 60);
	name.setMaxAge(24 * 60 * 60);
	zipCode.setMaxAge(24 * 60 * 60);
	country.setMaxAge(24 * 60 * 60);
	addressName.setMaxAge(24 * 60 * 60);
	memo.setMaxAge(24 * 60 * 60);
	
	response.addCookie(cartId);
	response.addCookie(name);
	response.addCookie(country);
	response.addCookie(zipCode);
	response.addCookie(addressName);
	response.addCookie(memo);
	
	response.sendRedirect("/shop/orderConfirmation.jsp");
	
%>
