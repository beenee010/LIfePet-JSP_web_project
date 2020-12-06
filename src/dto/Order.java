package dto;

public class Order {
	private int o_oid;
	private int o_uid;
	private int o_iid;
	private String name;
	private int quantity;
	private int unitPrice;
	private int total;
	private String zip;
	private String address;
	private String memo;
	private String state;
	private String date;
	
	public Order() {}

	public int getO_oid() {
		return o_oid;
	}

	public void setO_oid(int o_oid) {
		this.o_oid = o_oid;
	}

	public int getO_uid() {
		return o_uid;
	}

	public void setO_uid(int o_uid) {
		this.o_uid = o_uid;
	}

	public String getZip() {
		return zip;
	}

	public void setZip(String zip) {
		this.zip = zip;
	}

	public int getO_iid() {
		return o_iid;
	}

	public void setO_iid(int o_iid) {
		this.o_iid = o_iid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public int getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(int unitPrice) {
		this.unitPrice = unitPrice;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}
	
	
	
}
