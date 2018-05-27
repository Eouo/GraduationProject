package com.iozhaq.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.iozhaq.beans.ShopCard;
import com.iozhaq.dao.ShopCardDao;
import com.iozhaq.utils.ListHelper;

@Service("shopCardService")
public class ShopCardService {// 定义一个名为shopCardService的bean

	@Resource
	private ShopCardDao shopCardDao;// 注入名为shopCardDao的bean

	public void setShopCardDao(ShopCardDao shopCardDao) {
		this.shopCardDao = shopCardDao;
	}

	/**
	 * @author iozhaq
	 * @return
	 */

	public List<ShopCard> ShopCardList(String userId) {

		return shopCardDao.ShopCardList(userId);
	}

	public int addShopCard(int productId, String userId, int count) {

		return shopCardDao.addShopCard(productId, userId, count);
	}

	public int saveShopCard(int productId, String userId, int count) {

		return shopCardDao.saveShopCard(productId, userId, count);
	}

	public int updateShopCard(int shopCardId, int count) {

		return shopCardDao.updateShopCard(shopCardId, count);
	}

	public int productCount(int productId) {

		return shopCardDao.productCount(productId);
	}

	public int isShopCard(String userId, int productId) {
		return shopCardDao.isShopCard(userId, productId);
	}

	public ShopCard shopcardById(int shopCardId) {
		return shopCardDao.shopcardById(shopCardId);
	}

	public int DelShopCard(String shopCardId) {
		List<String> shopCardIdList = ListHelper.getList(shopCardId);
		return shopCardDao.DelShopCard(shopCardIdList);
	}

}
