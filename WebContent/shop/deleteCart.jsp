<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="dto.Item" %>
<%@ page import="dao.ItemRepository" %>
<%
	String id = request.getParameter("cartId");
	if(id == null || id.trim().equals("")){
		response.sendRedirect("/shop/cart.jsp");
		return;
	}
	
	session.invalidate();
	
	response.sendRedirect("/shop/cart.jsp");
%>
