package dao;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.sql.*;

import dto.Post;

public class PostRepository implements Serializable{

	private HashMap<String, Post> postMap = new HashMap<>();
	private static PostRepository instance = new PostRepository();
	
	
	public static PostRepository getInstance() {
		return instance;
	}
	
	public PostRepository() {
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
			String sql = "SELECT * FROM POST";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				String postId = "POST" + rs.getString("p_oid");
				String title = rs.getString("p_title");
				String text = rs.getString("p_text");
				String category = rs.getString("p_category");
				String userOid = rs.getString("p_uid");
				int hit = rs.getInt("p_hit");
				Date postDate = rs.getTimestamp("p_postDate");
				String filename = rs.getString("p_filename");
				
				sql = "SELECT u_id FROM USER WHERE u_oid=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, userOid);
				_rs = pstmt.executeQuery();
				
				String userId = "";
				if(_rs.next()) {
					userId  = _rs.getString(1);
				}
				_rs.close();
				
				Post post = new Post();
				
				post.setPostId(postId);
				post.setTitle(title);
				post.setText(text);
				post.setCategory(category);
				post.setUserId(userId);
				post.setUserOid(userOid);
				post.setHit(hit);
				post.setPostDate(postDate);
				post.setImageName(filename);
				
				postMap.put(postId, post);
			}
			
		} catch(SQLException ex){
			System.out.println("Update 실패<br>");
			System.out.println("Error: " + ex.getMessage());
		} finally{
			if(stmt != null)
				try {
					stmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			if(conn != null)
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
		}
	}
	
	public HashMap<String, Post> getPostes(){
		return postMap;
	}
	
	public Post getPostById(String id) {
		Post postById = null;
		
		if(postMap.containsKey(id)) {
			postById = postMap.get(id);
		}
		
		return postById;
	}
	
	public void addPost(Post post) throws SQLException, ClassNotFoundException {
		Connection conn = null;
		
		String url = "jdbc:mysql://localhost:3306/PetWebDB?useSSL=false&serverTimezone=Asia/Seoul";
		String user = "root";
		String pass = "password";
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url, user, pass);
		
		PreparedStatement pstmt = null;
		try{
			String sql = "INSERT INTO POST (p_uid, p_title, p_text, p_category, p_hit, p_postDate, p_filename) "
						+ "VALUES(?, ?, ?, ?, ?, now(), ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, post.getUserOid());
			pstmt.setString(2, post.getTitle());
			pstmt.setString(3, post.getText());
			pstmt.setString(4, post.getCategory());
			pstmt.setInt(5, post.getHit());
			pstmt.setString(6, post.getImageName());
			
			pstmt.executeUpdate();
		} catch(SQLException ex){
			System.out.println("Update 실패<br>");
			System.out.println("Error: " + ex.getMessage());
		} finally{
			if(pstmt != null)
				pstmt.close();
			if(conn != null)
				conn.close();
		}
		
		idSet(post);
		
		postMap.put(post.getPostId(),post);
	}
	
	public void idSet(Post post) throws ClassNotFoundException, SQLException {
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
					"WHERE table_name='POST' " + 
					"AND table_schema=DATABASE()";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				p_oid = rs.getInt(1);
				post.setPostId("POST" + (p_oid-1));
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
	
	public int getDataCount() throws SQLException {
		Connection conn = null;
		
		int dataCount = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try{
			String sql = "SELECT COUNT(*) as cnt FROM POST";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dataCount = rs.getInt(1);
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
		return dataCount;
	}
	
	public ArrayList<Post> getList(int start, int end) throws SQLException, ClassNotFoundException{
		Connection conn = null;
		
		ArrayList<Post> postList = new ArrayList<>();
		
		String url = "jdbc:mysql://localhost:3306/PetWebDB?useSSL=false&serverTimezone=Asia/Seoul";
		String user = "root";
		String pass = "password";
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url, user, pass);
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ResultSet _rs = null;
		try{
			String sql = "SELECT p_oid, p_title, p_category, p_text, p_postDate, p_uid, p_filename FROM POST ORDER BY p_oid DESC LIMIT ?, ?;";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Post post = new Post();
				
				post.setPostId("POST" + Integer.toString(rs.getInt(1)));
				post.setTitle(rs.getString(2));
				post.setCategory(rs.getString(3));
				post.setText(rs.getString(4));
				post.setPostDate((Date)rs.getTimestamp(5));
				String u_oid = Integer.toString(rs.getInt(6));
				post.setImageName(rs.getString(7));
				post.setUserOid(u_oid);
				
				sql = "SELECT u_id FROM USER WHERE u_oid=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, u_oid);
				_rs = pstmt.executeQuery();
				
				String userId = "";
				if(_rs.next()) {
					userId  = _rs.getString(1);
					post.setUserId(userId);
				}
				_rs.close();
				
				postList.add(post);
				
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
		
		return postList;
	}
	
}






