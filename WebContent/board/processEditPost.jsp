<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%@ page import="dto.Post" %>
<%@ page import="dao.PostRepository" %>

<%@ include file="/dbconn.jsp"%>
<%
	String userOid = (String)session.getAttribute("userOid");
	if(userOid == null)
		response.sendRedirect("/main/login.jsp");
	
	request.setCharacterEncoding("utf-8");
	
	String path = request.getRealPath("resources/images");
	MultipartRequest multi = new MultipartRequest(request, path, 5*1024*1024, "utf-8", new DefaultFileRenamePolicy());
	
	String p_oid = request.getParameter("id");
	
	PostRepository dao = PostRepository.getInstance();
	Post post = dao.getPostById(p_oid);
	
	String id = multi.getParameter("id");
	String title = multi.getParameter("postName");
	String text = multi.getParameter("postText");
	String category = multi.getParameter("postCategory");
	
	String fName = null;
	String filename = null;
	Enumeration enums = multi.getFileNames();
	if(enums.hasMoreElements()){
		fName = (String)enums.nextElement();
		filename = multi.getFilesystemName(fName);
	}
	
	if(filename == null){
		filename = post.getImageName();
	}
	
	PreparedStatement pstmt = null;
	try{
		String sql = "UPDATE POST SET p_title=?, p_text=?, p_category=?, "
			+ "p_postDate=now(), p_filename=? WHERE p_oid=?";
		pstmt = conn.prepareStatement(sql);

		pstmt.setString(1, title);
		pstmt.setString(2, text);
		pstmt.setString(3, category);
		pstmt.setString(4, filename);
		pstmt.setInt(5, Integer.valueOf(p_oid.substring(4)));
		
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
	
	post.setTitle(title);
	post.setText(text);
	post.setCategory(category);
	post.setPostDate(new Date());
	post.setImageName(filename);
	
	response.sendRedirect("/board/post.jsp?id="+p_oid);
%>