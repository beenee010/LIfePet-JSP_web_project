<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="dto.Flea" %>
<%@ page import="dao.FleaRepository" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%@ page import="java.util.*" %>
<%
	request.setCharacterEncoding("utf-8");
	
	String path = request.getRealPath("resources/images");
	MultipartRequest multi = new MultipartRequest(request, path, 5*1024*1024, "utf-8", new DefaultFileRenamePolicy());
	
	Flea flea = new Flea();
	
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
	
	flea.setId(id);
	flea.setName(name);
	flea.setDescription(description);
	flea.setCategory(category);
	flea.setUnitPrice(price);
	flea.setUnitsOfStock(stocks);
	flea.setFileName(fileName);
	flea.setUserOid(userOid);
	flea.setUserId(userId);
	flea.setCondition(condition);
	flea.setDate(new Date());
	
	FleaRepository dao = FleaRepository.getInstance();
	dao.addItem(flea);
	
	response.sendRedirect("/fleaMarket/fleaMarket.jsp");
	
%>