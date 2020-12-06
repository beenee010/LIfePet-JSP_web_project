<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%@ page import="dto.Flea" %>
<%@ page import="dao.FleaRepository" %>
<html>
<head>
<title>Insert title here</title>
</head>
<body>
	<%@ include file="/dbconn.jsp"%>
	
	<%
		String userOid = (String)session.getAttribute("userOid");
		if(userOid == null)
			response.sendRedirect("/main/login.jsp");
		
		request.setCharacterEncoding("utf-8");
		
		String path = request.getRealPath("resources/images");
		MultipartRequest multi = new MultipartRequest(request, path, 5*1024*1024, "utf-8", new DefaultFileRenamePolicy());
		
		String f_oid = request.getParameter("id");
		
		FleaRepository dao = FleaRepository.getInstance();
		Flea flea = dao.getFleaById(f_oid);
		
		String id = multi.getParameter("id");
		String name = multi.getParameter("name");
		String description = multi.getParameter("description");
		String category = multi.getParameter("category");
		int unitPrice = Integer.parseInt(multi.getParameter("unitPrice"));
		int unitsInStock = Integer.parseInt(multi.getParameter("unitsInStock"));
		String condition = multi.getParameter("condition");
		
		String fName = null;
		String filename = null;
		Enumeration enums = multi.getFileNames();
		if(enums.hasMoreElements()){
			fName = (String)enums.nextElement();
			filename = multi.getFilesystemName(fName);
		}
		
		if(filename == null){
			filename = flea.getFileName();
		}
		
		PreparedStatement pstmt = null;
		try{
			String sql = "UPDATE FLEA SET f_name=?, f_unitPrice=?, f_description=?, f_category=?, "
				+ "f_unitsInStock=?, f_condition=?, f_filename=?, f_date=now() WHERE f_oid=?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, name);
			pstmt.setInt(2, unitPrice);
			pstmt.setString(3, description);
			pstmt.setString(4, category);
			pstmt.setInt(5, unitsInStock);
			pstmt.setString(6, condition);
			pstmt.setString(7, filename);
			pstmt.setInt(8, Integer.valueOf(f_oid.substring(4)));
			
			pstmt.executeUpdate();
		} catch(SQLException ex){
			// 에러 구현
			System.out.println("Update 실패<br>");
			System.out.println("Error: " + ex.getMessage());
		} finally{
			if(pstmt != null)
				pstmt.close();
			if(conn != null)
				conn.close();
		}
		
		flea.setName(name);
		flea.setUnitPrice(unitPrice);
		flea.setDescription(description);
		flea.setCategory(category);
		flea.setUnitsOfStock(unitsInStock);
		flea.setCondition(condition);
		flea.setDate(new Date());
		flea.setFileName(filename);
		
		response.sendRedirect("/fleaMarket/fleaItem.jsp?id="+f_oid);
	%>
	

</body>
</html>