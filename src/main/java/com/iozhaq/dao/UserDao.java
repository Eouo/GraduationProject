package com.iozhaq.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.iozhaq.beans.Address;
import  com.iozhaq.beans.User;

/**
 * @author iozhaq
 * @since 20180404
 */
public interface UserDao {
	
	User login(@Param("userName")String userName,@Param("password")String password,@Param("type")String type);
	User findByUserId(String userId);//获取某个用户
	User findByUserName(String userName);//获取某个用户
    List<User> UserListByQuery(@Param("userName")String userName, @Param("sex")String sex);
    public int createUser(User user);//添加用户
    
    public int updateUser(User user);//修改用户
    public int editPassword(@Param("userId")String userId,@Param("password")String password);//修改用户密码
    User findByUserIdAndPassword(@Param("userId")String userId,@Param("oldPassword")String oldPassword);
    
    public int editType(@Param("userId")int userId,@Param("type")String type);//修改用户状态
   
	List<Address> AddressList(String userId);//获取某个用户所有地址
    public int addAddress(Address address);//添加地址
    public int updateAddress(Address address);//修改地址
    public int delAddress(List<String> addressId);//删除地址
    public int CancelDefaultAddress(List<Address> addressId);
    public int defaultAddress(String addressId);
    public Address AddressById(String addressId);//获取某个地址
}

