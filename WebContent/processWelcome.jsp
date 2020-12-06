<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ include file="/dbconn.jsp"%>
<%
	
	request.setCharacterEncoding("utf-8");

	ArrayList<Integer> itemList = new ArrayList<>();
	ArrayList<Integer> postList = new ArrayList<>();

	PreparedStatement pstmt = null;
	ResultSet rs = null;
	try{
		String sql = "SELECT i_oid FROM ITEM ORDER BY i_hit DESC LIMIT 3";
		pstmt = conn.prepareStatement(sql);
		
		rs = pstmt.executeQuery();
		
		while(rs.next()){
			int i_oid = rs.getInt("i_oid");
			
			itemList.add(i_oid);
		}
		
		sql = "SELECT p_oid FROM POST ORDER BY p_hit DESC LIMIT 3";
		pstmt = conn.prepareStatement(sql);
		
		rs = pstmt.executeQuery();
		
		while(rs.next()){
			int p_oid = rs.getInt("p_oid");
			
			postList.add(p_oid);
		}
	} catch(SQLException ex){
		System.out.println("Update 실패<br>");
		System.out.println("Error: " + ex.getMessage());
	} finally{
		if(rs != null)
			rs.close();
		if(pstmt != null)
			pstmt.close();
		if(conn != null)
			conn.close();
	}
%>