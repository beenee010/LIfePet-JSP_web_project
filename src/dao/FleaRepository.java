package dao;

import java.io.Serializable;
import java.sql.*;
import java.util.*;
import java.util.Date;

import dto.Flea;
import dto.Item;
import dto.Post;

public class FleaRepository implements Serializable{
	private HashMap<String, Flea> fleaMap = new HashMap<>();
	private static FleaRepository instance = new FleaRepository();
	
	public static FleaRepository getInstance() {
		return instance;
	}
	
	public FleaRepository() {
		
		Connection conn = null;

		String url = "jdbc:mysql://localhost:3306/PetWebDB?useSSL=false&serverTimezone=Asia/Seoul";
		String user = "root";
		String pass = "password";
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e1) {
			e1.printStackTrace();
		}
		try {
			conn = DriverManager.getConnection(url, user, pass);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		Statement stmt = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ResultSet _rs = null;
		try{
			String sql = "SELECT * FROM FLEA";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				String itemId = "FLEA" + rs.getString("f_oid");
				String name = rs.getString("f_name");
				int unitPrice = rs.getInt("f_unitPrice");
				String description = rs.getString("f_description");
				String category = rs.getString("f_category");
				String userOid = rs.getString("f_uid");
				int unitsInStock = rs.getInt("f_unitsInStock");
				String condition = rs.getString("f_condition");
				Date date = rs.getTimestamp("f_date");
				String filename = rs.getString("f_filename");
				int hit = rs.getInt("f_hit");
				
				sql = "SELECT u_id, u_phone FROM USER WHERE u_oid=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, userOid);
				_rs = pstmt.executeQuery();
				
				String userId = "";
				String userPhone = "";
				if(_rs.next()) {
					userId  = _rs.getString(1);
					userPhone = _rs.getString(2);
				}
				
				Flea flea = new Flea();
				
				flea.setId(itemId);
				flea.setName(name);
				flea.setUnitPrice(unitPrice);
				flea.setDescription(description);
				flea.setCategory(category);
				flea.setUserOid(userOid);
				flea.setUserId(userId);
				flea.setUnitsOfStock(unitsInStock);
				flea.setCondition(condition);
				flea.setDate(date);
				flea.setFileName(filename);
				flea.setHit(hit);
				flea.setPhone(userPhone);
				
				fleaMap.put(itemId, flea);
			}
			
		} catch(SQLException ex){
			System.out.println("Update 실패");
			System.out.println("Error: " + ex.getMessage());
		} finally{
			try {_rs.close(); } catch (SQLException e) { e.printStackTrace(); }
			try {rs.close(); } catch (SQLException e) { e.printStackTrace(); }
			if(pstmt != null)
				try {pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
			if(pstmt != null)
				try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
			if(conn != null)
				try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
		}
	}
	
	public HashMap<String, Flea> getFleas(){
		if(fleaMap == null)
			return null;
		return fleaMap;
	}
	
	public Flea getFleaById(String id) {
		
		Flea fleaById = null;
		
		if(fleaMap.containsKey(id)) {
			fleaById = fleaMap.get(id);
		}
		
		return fleaById;
	}
	
	public void addItem(Flea flea) throws ClassNotFoundException, SQLException {
		
		Connection conn = null;

		String url = "jdbc:mysql://localhost:3306/PetWebDB?useSSL=false&serverTimezone=Asia/Seoul";
		String user = "root";
		String pass = "password";
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url, user, pass);
		
		PreparedStatement pstmt = null;
		
		try{
			String sql = "INSERT INTO FLEA (f_uid, f_name, f_unitPrice, f_description, f_category, f_unitsInStock, f_condition, f_filename, f_date, f_hit) "
						+ "VALUES(?, ?, ?, ?, ?, ?, ?, ?, now(), 0)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, flea.getUserOid());
			pstmt.setString(2, flea.getName());
			pstmt.setInt(3, flea.getUnitPrice());
			pstmt.setString(4, flea.getDescription());
			pstmt.setString(5, flea.getCategory());
			pstmt.setInt(6, flea.getUnitsOfStock());
			pstmt.setString(7, flea.getCondition());
			pstmt.setString(8, flea.getFileName());
			
			pstmt.executeUpdate();
		} catch(SQLException ex){
			System.out.println("Update 실패");
			System.out.println("Error: " + ex.getMessage());
			ex.printStackTrace();
		} finally{
			if(pstmt != null)
				pstmt.close();
			if(conn != null)
				conn.close();
		}
		idSet(flea);
		
		fleaMap.put(flea.getId(), flea);
	}
	
	public void idSet(Flea flea) throws ClassNotFoundException, SQLException {
		Connection conn = null;
		
		String url = "jdbc:mysql://localhost:3306/PetWebDB?useSSL=false&serverTimezone=Asia/Seoul";
		String user = "root";
		String pass = "password";
		
		int p_oid = 0;
		String u_phone = "";
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url, user, pass);
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try{
			String sql = "SELECT AUTO_INCREMENT " + 
					"FROM information_schema.tables " + 
					"WHERE table_name='FLEA' " + 
					"AND table_schema=DATABASE()";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				p_oid = rs.getInt(1);
				flea.setId("FLEA" + (p_oid-1));
			}
			
			sql = "SELECT u_phone FROM USER WHERE u_oid=?";;
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, flea.getUserOid());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				u_phone = rs.getString(1);
				flea.setPhone(u_phone);
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
	}
	
	public ArrayList<Flea> getList(int start, int end) throws SQLException, ClassNotFoundException{
		Connection conn = null;
		
		ArrayList<Flea> fleaList = new ArrayList<>();
		
		String url = "jdbc:mysql://localhost:3306/PetWebDB?useSSL=false&serverTimezone=Asia/Seoul";
		String user = "root";
		String pass = "password";
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url, user, pass);
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ResultSet _rs = null;
		try{
			String sql = "SELECT f_oid, f_name, f_category, f_description,f_date, f_uid, f_filename FROM FLEA ORDER BY f_oid DESC LIMIT ?, ?;";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Flea flea = new Flea();
				
				flea.setId("FLEA" + Integer.toString(rs.getInt(1)));
				flea.setName(rs.getString(2));
				flea.setCategory(rs.getString(3));
				flea.setDescription(rs.getString(4));
				flea.setDate((Date)rs.getTimestamp(5));
				String u_oid = Integer.toString(rs.getInt(6));
				flea.setFileName(rs.getString(7));
				flea.setUserOid(u_oid);
				
				sql = "SELECT u_id FROM USER WHERE u_oid=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, u_oid);
				_rs = pstmt.executeQuery();
				
				String userId = "";
				if(_rs.next()) {
					userId  = _rs.getString(1);
					flea.setUserId(userId);
				}
				_rs.close();
				
				fleaList.add(flea);
				
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

		return fleaList;
	}
}
