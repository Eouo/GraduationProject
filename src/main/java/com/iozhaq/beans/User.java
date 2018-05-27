package com.iozhaq.beans;


import java.io.Serializable;
import java.util.List;
/**
 * @author iozhaq
 * @since 20180404
 */
public class User implements Serializable {
	
    private String userId;
    private String password;
    private String userName;
    private String userCode;
    private String imgUrl;
    private String sex;
    private String phone;
    private String age;
    private String address;
    private String eMail;
    private String type;//0:admin; 11:user;  12:blackUser
    private String praiseRate;//好评率
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserCode() {
		return userCode;
	}
	public void setUserCode(String userCode) {
		this.userCode = userCode;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getImgUrl() {
		return imgUrl;
	}
	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getAge() {
		return age;
	}
	public void setAge(String age) {
		this.age = age;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String geteMail() {
		return eMail;
	}
	public void seteMail(String eMail) {
		this.eMail = eMail;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getPraiseRate() {
		return praiseRate;
	}
	public void setPraiseRate(String praiseRate) {
		this.praiseRate = praiseRate;
	}
    
	 
	
}
