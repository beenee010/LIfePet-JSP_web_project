package dao;

import java.io.Serializable;
import java.util.HashMap;
import java.util.ArrayList;
import java.util.Date;
import java.sql.*;
import dto.Item;
import dto.Post;

public class ItemRepository implements Serializable{

	private HashMap<String, Item> itemMap = new HashMap<>();
	private static ItemRepository instance = new ItemRepository();
	
	public static ItemRepository getInstance() {
		return instance;
	}
	
	public ItemRepository() {
		
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
			String sql = "SELECT * FROM ITEM";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				String itemId = "ITEM" + rs.getString("i_oid");
				String name = rs.getString("i_name");
				int unitPrice = rs.getInt("i_unitPrice");
				String description = rs.getString("i_description");
				String category = rs.getString("i_category");
				String userOid = rs.getString("i_uid");
				int unitsInStock = rs.getInt("i_unitsInStock");
				String condition = rs.getString("i_condition");
				Date date = rs.getTimestamp("i_date");
				String filename = rs.getString("i_filename");
				int hit = rs.getInt("i_hit");
				
				sql = "SELECT u_id FROM USER WHERE u_oid=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, userOid);
				_rs = pstmt.executeQuery();
				
				String userId = "";
				if(_rs.next()) {
					userId  = _rs.getString(1);
				}
				
				Item item = new Item();
				
				item.setId(itemId);
				item.setName(name);
				item.setUnitPrice(unitPrice);
				item.setDescription(description);
				item.setCategory(category);
				item.setUserOid(userOid);
				item.setUserId(userId);
				item.setUnitsOfStock(unitsInStock);
				item.setCondition(condition);
				item.setDate(date);
				item.setFileName(filename);
				item.setHit(hit);
				
				itemMap.put(itemId, item);
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
	
	public HashMap<String, Item> getItems(){
		return itemMap;
	}
	
	public Item getItemById(String id) {
		
		Item itemById = null;
		
		if(itemMap.containsKey(id)) {
			itemById = itemMap.get(id);
		}

		return itemById;
	}
	
	public void addItem(Item item) throws ClassNotFoundException, SQLException {
		
		Connection conn = null;

		String url = "jdbc:mysql://localhost:3306/PetWebDB?useSSL=false&serverTimezone=Asia/Seoul";
		String user = "root";
		String pass = "password";
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url, user, pass);
		
		PreparedStatement pstmt = null;
		
		try{
			String sql = "INSERT INTO ITEM (i_uid, i_name, i_unitPrice, i_description, i_category, i_unitsInStock, i_condition, i_filename, i_date, i_hit) "
						+ "VALUES(?, ?, ?, ?, ?, ?, ?, ?, now(), 0)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, item.getUserOid());
			pstmt.setString(2, item.getName());
			pstmt.setInt(3, item.getUnitPrice());
			pstmt.setString(4, item.getDescription());
			pstmt.setString(5, item.getCategory());
			pstmt.setInt(6, item.getUnitsOfStock());
			pstmt.setString(7, item.getCondition());
			pstmt.setString(8, item.getFileName());
			
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
		idSet(item);
		
		itemMap.put(item.getId(), item);
	}
	
	public void idSet(Item item) throws ClassNotFoundException, SQLException {
		Connection conn = null;
		
		String url = "jdbc:mysql://localhost:3306/PetWebDB?useSSL=false&serverTimezone=Asia/Seoul";
		String user = "root";
		String pass = "password";
		
		int p_oid = 0;
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url, user, pass);
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try{
			String sql = "SELECT AUTO_INCREMENT " + 
					"FROM information_schema.tables " + 
					"WHERE table_name='ITEM' " + 
					"AND table_schema=DATABASE()";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				p_oid = rs.getInt(1);
				item.setId("ITEM" + (p_oid-1));
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
	
	public ArrayList<Item> getList(int start, int end) throws SQLException, ClassNotFoundException{
		Connection conn = null;
		
		ArrayList<Item> itemList = new ArrayList<>();
		
		String url = "jdbc:mysql://localhost:3306/PetWebDB?useSSL=false&serverTimezone=Asia/Seoul";
		String user = "root";
		String pass = "password";
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url, user, pass);
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ResultSet _rs = null;
		try{
			String sql = "SELECT i_oid, i_name, i_category, i_description,i_date, i_uid, i_filename FROM ITEM ORDER BY i_oid DESC LIMIT ?, ?;";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Item item = new Item();
				
				item.setId("ITEM" + Integer.toString(rs.getInt(1)));
				item.setName(rs.getString(2));
				item.setCategory(rs.getString(3));
				item.setDescription(rs.getString(4));
				item.setDate((Date)rs.getTimestamp(5));
				String u_oid = Integer.toString(rs.getInt(6));
				item.setFileName(rs.getString(7));
				item.setUserOid(u_oid);
				
				sql = "SELECT u_id FROM USER WHERE u_oid=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, u_oid);
				_rs = pstmt.executeQuery();
				
				String userId = "";
				if(_rs.next()) {
					userId  = _rs.getString(1);
					item.setUserId(userId);
				}
				_rs.close();
				
				itemList.add(item);
				
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
		return itemList;
	}
	
}
