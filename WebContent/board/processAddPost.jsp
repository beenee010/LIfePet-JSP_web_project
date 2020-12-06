<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="dto.Post" %>
<%@ page import="dao.PostRepository" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="java.sql.*" %>

<%
	request.setCharacterEncoding("utf-8");
	String path = request.getRealPath("resources/images");
	MultipartRequest multi = new MultipartRequest(request, path, 5*1024*1024, "utf-8", new DefaultFileRenamePolicy());

	Post post = new Post();
	
	String title = multi.getParameter("postName");
	String text = multi.getParameter("postText");
	String category = multi.getParameter("postCategory");
	
	String userOid = (String)session.getAttribute("userOid");
	String userId = (String)session.getAttribute("userID");
	
	Enumeration enums = multi.getFileNames();
	String fname = (String)enums.nextElement();
	String filename = multi.getFilesystemName(fname);
	
	post.setTitle(title);
	post.setText(text);
	post.setCategory(category);
	post.setHit(0);
	post.setUserOid(userOid);
	post.setPostDate(new Date());
	post.setImageName(filename);
	post.setUserId(userId);
	
	PostRepository dao = PostRepository.getInstance();
	dao.addPost(post);

	response.sendRedirect("/board/board.jsp");
%>