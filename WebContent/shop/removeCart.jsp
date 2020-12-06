<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dto.Item" %>
<%@ page import="dao.ItemRepository" %>

<%
	String id = request.getParameter("id");
	if(id == null || id.trim().equals("")){
		response.sendRedirect("/shop/shop.jsp");
		return;
	}
	
	ItemRepository dao = ItemRepository.getInstance();
	
	Item item = dao.getItemById(id);
	
	if(item == null)
		response.sendRedirect("/exception/exceptionNoItemId.jsp");
	
	ArrayList<Item> cartList = (ArrayList<Item>) session.getAttribute("cartlist");
	Item goodsQnt = new Item();
	
	for(int i = 0; i < cartList.size(); i++){
		goodsQnt = cartList.get(i);
		if(goodsQnt.getId().equals(id))
			cartList.remove(goodsQnt);
	}
	
	response.sendRedirect("/shop/cart.jsp");
%>
