<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dto.Item" %>
<%@ page import="dao.ItemRepository" %>

<%
	if((String)session.getAttribute("userOid") == null){
		response.sendRedirect("/main/login.jsp");
		return;
	}

	String id = request.getParameter("id");
	
	if(id == null || id.trim().equals("")){
		response.sendRedirect("/shop/shop.jsp");
		return;
	}
	
	ItemRepository dao = ItemRepository.getInstance();
	
	Item item = dao.getItemById(id);
	if(item == null){
		response.sendRedirect("/exception/exceptionNoBookId.jsp");
		return;
	}
	
	HashMap<String, Item> itemMap = dao.getItems();
	Item goods = new Item();
	
	goods = itemMap.get(id);
	
	ArrayList<Item> list = (ArrayList<Item>) session.getAttribute("cartlist");
	if(list == null){
		list = new ArrayList<Item>();
		session.setAttribute("cartlist", list);
	}
	
	int cnt = 0;
	Item goodsQnt = new Item();
	
	for(int i = 0; i < list.size(); i++){
		goodsQnt = list.get(i);
		if(goodsQnt.getId().equals(id)){
			cnt++;
			int orderQuantiry = goodsQnt.getQuantity() + 1;
			goodsQnt.setQuantity(orderQuantiry);
		}
	}
	
	if(cnt == 0){
		goods.setQuantity(1);
		list.add(goods);
	}
	
	
	response.sendRedirect("/shop/item.jsp?id=" + id);
%>
