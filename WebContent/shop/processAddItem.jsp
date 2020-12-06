<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="dto.Item" %>
<%@ page import="dao.ItemRepository" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%@ page import="java.util.*" %>
<%
	request.setCharacterEncoding("utf-8");
	
	String path = request.getRealPath("resources/images");
	MultipartRequest multi = new MultipartRequest(request, path, 5*1024*1024, "utf-8", new DefaultFileRenamePolicy());
	
	Item item = new Item();
	
	String id = multi.getParameter("id");
	String name = multi.getParameter("name");
	String description = multi.getParameter("description");
	String category = multi.getParameter("category");
	String unitPrice = multi.getParameter("unitPrice");
	String unitsInStock = multi.getParameter("unitsInStock");
	String condition = multi.getParameter("condition");
	
	String userOid = (String)session.getAttribute("userOid");
	String userId = (String)session.getAttribute("userID");
	
	int price;
	if(unitPrice.isEmpty())
		price = 0;
	else
		price = Integer.valueOf(unitPrice);
	
	int stocks;
	if(unitsInStock.isEmpty())
		stocks = 0;
	else
		stocks = Integer.valueOf(unitsInStock);
	
	Enumeration enums = multi.getFileNames();
	String fName = (String)enums.nextElement();
	String fileName = multi.getFilesystemName(fName);
	
	item.setId(id);
	item.setName(name);
	item.setDescription(description);
	item.setCategory(category);
	item.setUnitPrice(price);
	item.setUnitsOfStock(stocks);
	item.setFileName(fileName);
	item.setUserOid(userOid);
	item.setUserId(userId);
	item.setCondition(condition);
	item.setDate(new Date());
	
	ItemRepository dao = ItemRepository.getInstance();
	dao.addItem(item);
	
	response.sendRedirect("/shop/shop.jsp");
	
%>