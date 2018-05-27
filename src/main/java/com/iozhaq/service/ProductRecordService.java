package com.iozhaq.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.iozhaq.beans.ProductRecord;
import com.iozhaq.dao.ProductRecordDao;
import com.iozhaq.utils.ListHelper;

@Service("productRecordService")
public class ProductRecordService {

	@Resource
	private ProductRecordDao productRecordDao;

	public void setProductRecordDao(ProductRecordDao productRecordDao) {
		this.productRecordDao = productRecordDao;
	}

	/**
	 * @author iozhaq
	 * @return
	 */

	public List<ProductRecord> RecordList(String productName, String userName, int userId, String orderTime,
			String state) {

		return productRecordDao.RecordList(productName, userName, userId, orderTime, state);
	}

	public int DelProduct(String orderId) {
		List<String> orderIdList = ListHelper.getList(orderId);
		return productRecordDao.DelProduct(orderIdList);
	}

	public int UserDelProduct(String orderId) {
		List<String> orderIdList = ListHelper.getList(orderId);
		return productRecordDao.UserDelProduct(orderIdList);
	}

	public int addProductRecord1(Map<String, Object> params) {
		return productRecordDao.addProductRecord1(params);
	}

	public int addProductRecord(ProductRecord productRecord) {
		return productRecordDao.addProductRecord(productRecord);
	}

	public int cancelDel(String orderId) {
		return productRecordDao.cancelDel(orderId);
	}

	public int cancelOrDownRecord(String orderId, String state) {
		return productRecordDao.cancelOrDownRecord(orderId, state);
	}

}
