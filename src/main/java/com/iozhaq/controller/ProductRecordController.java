package com.iozhaq.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.iozhaq.beans.Address;
import com.iozhaq.beans.Product;
import com.iozhaq.beans.ProductRecord;
import com.iozhaq.beans.ShopCard;
import com.iozhaq.beans.User;
import com.iozhaq.service.ProductRecordService;
import com.iozhaq.service.ProductService;
import com.iozhaq.service.ShopCardService;
import com.iozhaq.service.UserService;

@Controller
public class ProductRecordController {

	// Logger log=LoggerFactory.getLogger(getClass());

	@Resource
	ProductRecordService productRecordService;
	@Resource
	UserService userService;
	@Resource
	ProductService productService;

	@Resource
	ShopCardService shopCardService;

	@RequestMapping("productRecord")
	public ModelAndView product() {
		ModelAndView model = new ModelAndView("productRecord/productRecord");
		return model;
	}

	@RequestMapping("ProductRecordController/productRecordList")
	@ResponseBody
	public List<ProductRecord> ShopProductRecord(HttpServletRequest request) {

		User user = (User) request.getSession().getAttribute("user");

		String orderTime = request.getParameter("orderTime");
		int userId = Integer.parseInt(user.getUserId());
		String productName = request.getParameter("productName");
		String state = request.getParameter("state");
		System.out.println("state=======》" + state);
		String userName = request.getParameter("userName");
		List<ProductRecord> recordList = new ArrayList<ProductRecord>();
		recordList = productRecordService.RecordList(productName, userName, userId, orderTime, state);
		return recordList;
	}

	@RequestMapping("ProductRecordController/delProductRecord")
	@ResponseBody
	int delProductRecord(HttpServletRequest request) {

		User user = (User) request.getSession().getAttribute("user");
		String userId = user.getUserId();
		String orderIdMore = request.getParameter("orderId");
		int num;
		if (userId == "1" || userId.equals("1")) {
			num = productRecordService.DelProduct(orderIdMore);
		} else {
			num = productRecordService.UserDelProduct(orderIdMore);
		}
		return num;
	}

	@RequestMapping("ProductRecordController/addProductRecord1")
	@ResponseBody
	int addProductRecord1(HttpServletRequest request) {

		User user = (User) request.getSession().getAttribute("user");
		String userId = user.getUserId();
		String shopCardIdMore = request.getParameter("shopCardId");
		String addressId = request.getParameter("addressId");

		// 根据addressId获取地址信息
		Address address = userService.AddressById(addressId);

		List<ShopCard> shopCardList = new ArrayList<ShopCard>();
		// 根据shopCardIdMore获取产品价格，名称 产品购买数量
		String[] shopCardId = shopCardIdMore.split(",");
		for (int i = 0; i < shopCardId.length; i++) {
			shopCardList.add(shopCardService.shopcardById(Integer.parseInt(shopCardId[i])));
		}

		// 购买 总价=数量*价格
		// 购买成功则--》1：删除对应的购物车 2：添加对应的订单

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date date = new Date();
		ProductRecord productRecord = new ProductRecord();
		productRecord.setUserId(userId);
		productRecord.setAddress(address.getAddress() + address.getAddressDetail());
		productRecord.setAddressName(address.getAddressName());
		productRecord.setAddressPhone(address.getAddressPhone());
		productRecord.setOrderTime(sdf.format(date));

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("productRecord", productRecord);
		params.put("shopCardList", shopCardList);
		int addId = productRecordService.addProductRecord1(params);

		// 购买成功则--》1：删除对应的购物车 2：减少对应的产品数量
		if (addId > 0) {
			shopCardService.DelShopCard(shopCardIdMore);
			productService.UpdateProductCount(shopCardList);
			productService.productIsOver(shopCardList);
		}
		return addId;
	}

	@RequestMapping("ProductRecordController/addProductRecord") // 下订单
	@ResponseBody
	int addProductRecord(HttpServletRequest request) {

		User user = (User) request.getSession().getAttribute("user");
		String userId = user.getUserId();
		String shopCardIdMore = request.getParameter("shopCardId");
		String addressId = request.getParameter("addressId");
		String allMoney = request.getParameter("allMoney");

		System.out.println("allMoney==" + allMoney);
		// 根据addressId获取地址信息
		Address address = userService.AddressById(addressId);

		List<ShopCard> shopCardList = new ArrayList<ShopCard>();
		// 根据shopCardIdMore获取产品价格，名称 产品购买数量
		String[] shopCardId = shopCardIdMore.split(",");
		StringBuffer produceId = null;
		StringBuffer productName = null;
		StringBuffer producePrice = null;
		StringBuffer produceCount = null;
		for (int i = 0; i < shopCardId.length; i++) {
			ShopCard shopCard = shopCardService.shopcardById(Integer.parseInt(shopCardId[i]));
			if (i == 0) {
				produceId = new StringBuffer(shopCard.getProductId());
				productName = new StringBuffer(shopCard.getProductName());
				producePrice = new StringBuffer(shopCard.getPrice());
				produceCount = new StringBuffer(shopCard.getCount());
			} else if (produceId != null) {
				produceId.append("," + shopCard.getProductId());
				productName.append("," + shopCard.getProductName());
				producePrice.append("," + shopCard.getPrice());
				produceCount.append("," + shopCard.getCount());
			}
			shopCardList.add(shopCard);
		}

		// 购买 总价=数量*价格
		// 购买成功则--》1：删除对应的购物车 2：添加对应的订单

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date date = new Date();
		ProductRecord productRecord = new ProductRecord();
		productRecord.setUserId(userId);
		productRecord.setAddress(address.getAddress() + address.getAddressDetail());
		productRecord.setAddressName(address.getAddressName());
		productRecord.setAddressPhone(address.getAddressPhone());
		productRecord.setOrderTime(sdf.format(date));
		productRecord.setProductId(produceId.toString());
		productRecord.setProductName(productName.toString());
		productRecord.setPrice(producePrice.toString());
		productRecord.setCount(produceCount.toString());
		productRecord.setTotalMoney(allMoney);

		int addId = productRecordService.addProductRecord(productRecord);

		// 购买成功则--》1：删除对应的购物车 2：减少对应的产品数量
		if (addId > 0) {
			shopCardService.DelShopCard(shopCardIdMore);
			productService.UpdateProductCount(shopCardList);
			productService.productIsOver(shopCardList);
		}
		return addId;
	}

	@RequestMapping("ProductRecordController/cancelDel")
	@ResponseBody
	int cancelDel(HttpServletRequest request) {

		String orderId = request.getParameter("orderId");
		int updateId = productRecordService.cancelDel(orderId);
		return updateId;
	}

	@RequestMapping("ProductRecordController/cancelOrDownRecord") // 取消订单or安排配送
	@ResponseBody
	int cancelRecord(HttpServletRequest request) {

		String orderId = request.getParameter("orderId");
		String state = request.getParameter("state");

		if (("2").equals(state)) {// 用户取消订单==》若产品还在即恢复库存
			String productIdMore = request.getParameter("productId");
			String countMore = request.getParameter("count");
			String[] productId = productIdMore.split(",");
			String[] count = countMore.split(",");

			for (int i = 0; i < productId.length; i++) {
				System.out.println("lllllllllproductId:" + productId[i] + "=====" + count[i]);
				productService.cancelRecordCount(productId[i], count[i]);
			}
		}
		int updateId = productRecordService.cancelOrDownRecord(orderId, state);
		return updateId;
	}

}