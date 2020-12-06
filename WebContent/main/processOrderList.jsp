<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dto.Order"%>
<%@ page import="java.util.*"%>
<html>
<head>
<title>Insert title here</title>
</head>
<body class="bg-light">
	<%@ include file="/dbconn.jsp"%>
	<%
		request.setCharacterEncoding("utf-8");
	
		String sess = (String)session.getAttribute("userOid");
		if(sess == null)
			response.sendRedirect("/main/login.jsp");
		
		String u_oid = request.getParameter("oid");
		
		boolean admin = (Boolean) session.getAttribute("admin");
		
		ArrayList<Order> orderList = new ArrayList<>();
	
		PreparedStatement pstmt = null;
		Statement stmt = null;
		ResultSet rs = null;
		try{
			String sql = "SELECT * FROM ORDERING WHERE o_uid=?";
			if(admin){
				sql = "SELECT * FROM ORDERING";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
			}
			else{
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, Integer.parseInt(u_oid));
	
				rs = pstmt.executeQuery();
			}
			while(rs.next()){
				int o_oid = rs.getInt("o_oid");
				int o_uid = rs.getInt("o_uid");
				int o_iid = rs.getInt("o_iid");
				int o_count = rs.getInt("o_count");
				int o_total = rs.getInt("o_total");
				String o_zip = rs.getString("o_zip");
				String o_address = rs.getString("o_address");
				String o_date = rs.getString("o_date");
				String o_memo = rs.getString("o_memo");
				String o_state = rs.getString("o_state");
				
				Order order = new Order();
				
				order.setO_oid(o_oid);
				order.setO_uid(o_uid);
				order.setO_iid(o_iid);
				order.setQuantity(o_count);
				order.setTotal(o_total);
				order.setZip(o_zip);
				order.setAddress(o_address);
				order.setDate(o_date);
				order.setMemo(o_memo);
				order.setState(o_state);
				
				sql = "SELECT i_name,i_unitPrice FROM ITEM WHERE i_oid=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, o_iid);
				
				ResultSet _rs = pstmt.executeQuery();
				String o_name = "";
				int o_unitPrice = 0;
				if(_rs.next()){
					o_name = _rs.getString(1);
					o_unitPrice = _rs.getInt("i_unitPrice");
					order.setName(o_name);
					order.setUnitPrice(o_unitPrice);
				}
				_rs.close();
				
				orderList.add(order);
			}				
		} catch(SQLException ex){
			System.out.println("Update 실패<br>");
			System.out.println("Error: " + ex.getMessage());
		} finally{
			if(rs != null)
				pstmt.close();
			if(pstmt != null)
				pstmt.close();
			if(conn != null)
				conn.close();
		}
		request.setAttribute("orderList", orderList);
	%>
</body>
</html>