package dto;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Flea {
	private String id;
	private String name;
	private String description;
	private String userId;
	private String userOid;
	private String category;
	private String fileName;
	private int unitPrice;
	private int unitsOfStock;
	private String condition;
	private String date;
	private int quantity;
	private int hit;
	private String phone;
	
	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public Flea() {}
	
	public Flea(String id, String name, int unitPrice) {
		
		this.id = id;
		this.name = name;
		this.unitPrice = unitPrice;
		
	}
	
	public int getHit() {
		return hit;
	}

	public void setHit(int hit) {
		this.hit = hit;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public String getCondition() {
		return condition;
	}

	public void setCondition(String condition) {
		this.condition = condition;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public int getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(int unitPrice) {
		this.unitPrice = unitPrice;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public int getUnitsOfStock() {
		return unitsOfStock;
	}

	public void setUnitsOfStock(int unitsOfStock) {
		this.unitsOfStock = unitsOfStock;
	}

	public String getDate() {
		return date;
	}
	public void setDate(Date postdate) {
		SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String to = fm.format(postdate);
		this.date = to;
	}

	public String getUserOid() {
		return userOid;
	}

	public void setUserOid(String userOid) {
		this.userOid = userOid;
	}
}
