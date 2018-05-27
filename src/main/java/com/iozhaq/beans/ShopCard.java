package com.iozhaq.beans;


import java.io.Serializable;
/**
 * @author iozhaq
 * @since 201804015
 */
public class ShopCard implements Serializable {
    
    private String shopCardId;
    private String userId;
    private String userName;
    private String imgUrl;
    private String productId;
    private String productName;
    private String price;
    private String count;
    private String allCount;
    private String type;
    
    private String totalMoney;
	 
	public String getShopCardId() {
		return shopCardId;
	}
	public void setShopCardId(String shopCardId) {
		this.shopCardId = shopCardId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getProductId() {
		return productId;
	}
	public void setProductId(String productId) {
		this.productId = productId;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getPrice() {
		return price;
	}
	public String getImgUrl() {
		return imgUrl;
	}
	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getCount() {
		return count;
	}
	public void setCount(String count) {
		this.count = count;
	}
	 
	 
	public String getAllCount() {
		return allCount;
	}
	public void setAllCount(String allCount) {
		this.allCount = allCount;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getTotalMoney() {
		return totalMoney;
	}
	public void setTotalMoney(String totalMoney) {
		this.totalMoney = totalMoney;
	}
 
	 
	
}
