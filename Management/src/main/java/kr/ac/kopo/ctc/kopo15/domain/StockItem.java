package kr.ac.kopo.ctc.kopo15.domain;

import java.util.Date;

public class StockItem {

	
	private String productId;    // 상품번호
	private String productName;		// 상품명
	private int stockCnt;				//재고수량	
	private Date checkdate;			//재고파악일 (오늘날짜고정)
	private Date inputdate;			// 상품등록일
	private String description;		//상품설명
	private String img;    //이미지
	
	
	
	public String getProductId() {
		return productId;
	}
	public void setProductId(String productId) {
		this.productId = productId;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public int getStockCnt() {
		return stockCnt;
	}
	public void setStockCnt(int stockCnt) {
		this.stockCnt = stockCnt;
	}
	public Date getCheckdate() {
		return checkdate;
	}
	public void setCheckdate(Date checkdate) {
		this.checkdate = checkdate;
	}
	public Date getInputdate() {
		return inputdate;
	}
	public void setInputdate(Date inputdate) {
		this.inputdate = inputdate;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	
	
	
		
		
		
		
		
	}


