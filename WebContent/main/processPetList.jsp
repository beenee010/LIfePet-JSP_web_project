<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dto.Pet"%>
<%@ page import="java.util.*"%>
<html>
<head>
<title>Insert title here</title>
</head>
<body class="bg-light">
	<%
		String sess = (String)session.getAttribute("userOid");
		if(sess == null)
			response.sendRedirect("/main/login.jsp");
	%>
	<%@ include file="/dbconn.jsp"%>
	<%		
		request.setCharacterEncoding("utf-8");
		String u_oid = request.getParameter("oid");
		
		ArrayList<Pet> petList = new ArrayList<>();
	
		PreparedStatement pstmt = null;
		Statement stmt = null;
		ResultSet rs = null;
		try{
			String sql = "SELECT * FROM PET WHERE p_guardian=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, u_oid);

			rs = pstmt.executeQuery();
			
			while(rs.next()){
				int oid = rs.getInt("p_oid");
				String name = rs.getString("p_name");
				String breed = rs.getString("p_breed");
				int age = rs.getInt("p_age");
				String gender = rs.getString("p_gender");
				
				Pet pet = new Pet();
				
				pet.setOid(oid);
				pet.setName(name);
				pet.setBreed(breed);
				pet.setAge(age);
				pet.setGender(gender);
				
				petList.add(pet);
				
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
		request.setAttribute("petList", petList);
	%>
</body>
</html>