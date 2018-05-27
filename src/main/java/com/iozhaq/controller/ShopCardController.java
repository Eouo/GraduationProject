package com.iozhaq.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.iozhaq.beans.ShopCard;
import com.iozhaq.beans.User;
import com.iozhaq.service.ProductRecordService;
import com.iozhaq.service.ProductService;
import com.iozhaq.service.ShopCardService;

@Controller
public class ShopCardController {

	// Logger log=LoggerFactory.getLogger(getClass());

	@Resource
	ShopCardService shopCardService;// 注入名为shopCardService的bean

	@Resource
	ProductRecordService productRecordService;

	@Resource
	ProductService productService;

	@RequestMapping("shopCardList")
	public ModelAndView product() {
		ModelAndView model = new ModelAndView("shopCard/shopCardList");
		return model;
	}

	@RequestMapping("ShopCardController/shopCardList")
	@ResponseBody
	public List<ShopCard> shopCardList(HttpSession session) {

		User user = (User) session.getAttribute("user");
		String userId = user.getUserId();
		List<ShopCard> shopCardList = new ArrayList<ShopCard>();
		shopCardList = shopCardService.ShopCardList(userId);
		return shopCardList;
	}

	@RequestMapping("ShopCardController/shopCardListSelective")
	@ResponseBody
	public List<ShopCard> shopCardListSelective(HttpServletRequest request) {

		String shopCardIdMore = request.getParameter("shopCardIdMore");

		String[] shopCardId = shopCardIdMore.split(",");

		List<ShopCard> shopCardList = new ArrayList<ShopCard>();
		ShopCard shopCard;
		for (int i = 0; i < shopCardId.length; i++) {
			shopCard = shopCardService.shopcardById(Integer.parseInt(shopCardId[i]));
			shopCardList.add(shopCard);
		}
		return shopCardList;
	}

	@RequestMapping("ShopCardController/addShopCard")
	@ResponseBody
	public int addShopCard(HttpServletRequest request) {

		User user = (User) request.getSession().getAttribute("user");
		String userId = user.getUserId();
		int productId = Integer.parseInt(request.getParameter("productId"));
		int count = Integer.parseInt(request.getParameter("count"));
		int num = shopCardService.isShopCard(userId, productId);
		if (num > 0) {
			return shopCardService.saveShopCard(productId, userId, count);
		} else {
			return shopCardService.addShopCard(productId, userId, count);

		}
	}

	@RequestMapping("ShopCardController/editShopCard")
	@ResponseBody
	public int editShopCard(HttpServletRequest request, HttpSession session) {

		int shopCardId = Integer.parseInt(request.getParameter("shopCardId"));
		int count = Integer.parseInt(request.getParameter("count"));

		System.out.println("\n" + "num: " + shopCardId);
		System.out.println();
		return shopCardService.updateShopCard(shopCardId, count);
	}

	@RequestMapping("ShopCardController/delShopCard")
	@ResponseBody
	int delShopCard(HttpServletRequest request) {

		String shopCardIdMore = request.getParameter("shopCardId");
		return shopCardService.DelShopCard(shopCardIdMore);
	}

}