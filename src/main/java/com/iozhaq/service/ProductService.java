package com.iozhaq.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.iozhaq.beans.Product;
import com.iozhaq.beans.ShopCard;
import com.iozhaq.dao.ProductDao;
import com.iozhaq.utils.ListHelper;

@Service("productService")
public class ProductService {

	@Resource
	private ProductDao productDao;

	public void setProductDao(ProductDao productDao) {
		this.productDao = productDao;
	}

	/**
	 * @author iozhaq
	 * @return
	 */
	public int updateShopCardType(int productId, int type) {

		return productDao.updateShopCardType(productId, type);
	}

	public List<Product> ShopProduct(String productName, String startMoney, String endMoney, int numStart) {

		return productDao.ShopProduct(productName, startMoney, endMoney, numStart);
	}

	public List<Product> RepertoryList(String productName, String type) {

		return productDao.RepertoryList(productName, type);
	}

	public int AddProduct(Product product) {

		return productDao.AddProduct(product);
	}

	public int UpdateProduct(Product product) {

		return productDao.UpdateProduct(product);
	}

	public int DelProduct(String productId) {
		List<String> productIdList = ListHelper.getList(productId);
		return productDao.DelProduct(productIdList);
	}

	public int upOrDownShopProduct(int productId, int type) {

		return productDao.upOrDownShopProduct(productId, type);
	}

	// 通过这个productId获取productId和购物车数量，类型，价格
	public Product productById(int productId) {
		return productDao.productById(productId);
	}

	public int UpdateProductCount(List<ShopCard> shopCardList) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("shopCardList", shopCardList);
		return productDao.UpdateProductCount(params);
	}

	public int productIsOver(List<ShopCard> shopCardList) {
		return productDao.productIsOver(shopCardList);
	}

	public int cancelRecordCount(String productId, String count) {

		return productDao.cancelRecordCount(productId, count);
	}
}
