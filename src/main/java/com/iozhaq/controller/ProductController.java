package com.iozhaq.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.iozhaq.beans.Product;
import com.iozhaq.service.ProductService;

@Controller
public class ProductController {

    // Logger log=LoggerFactory.getLogger(getClass());

    @Resource
    ProductService productService;

    @RequestMapping("product")
    public ModelAndView product() {
        ModelAndView model = new ModelAndView("product/product");
        return model;
    }

    @RequestMapping("repertory")
    public ModelAndView repertory() {
        ModelAndView model = new ModelAndView("product/repertory");
        return model;
    }

    @RequestMapping("ProductController/productlist")
    @ResponseBody
    public List<Product> ShopProduct(HttpServletRequest request) {
        String numString = request.getParameter("num");
        System.out.println(numString + "====numString:\n\n/n/n");

        int num;
        if (numString != null) {
            num = Integer.parseInt(request.getParameter("num"));
        } else {
            num = 1000;
        }
        String productName = request.getParameter("productName");
        String startMoney = request.getParameter("startMoney");
        String endMoney = request.getParameter("endMoney");
        List<Product> productList = new ArrayList<Product>();
        productList = productService.ShopProduct(productName, startMoney, endMoney, num * 10);
        System.out.println("\n\n/n/n+==" + productList.get(1).getProductName());
        return productList;
    }

    @RequestMapping("ProductController/repertoryList")
    @ResponseBody
    public List<Product> RepertoryList(HttpServletRequest request) {
        String productName = request.getParameter("productName");
        String type = request.getParameter("type");
        List<Product> repertoryList = new ArrayList<Product>();
        repertoryList = productService.RepertoryList(productName, type);

        return repertoryList;
    }

    @RequestMapping("ProductController/addProduct")
    @ResponseBody
    int addProduct(Product product) {
        int addId = productService.AddProduct(product);
        return addId;
    }

    @RequestMapping("ProductController/updateProduct")
    @ResponseBody
    int updateProduct(Product product) {
        int updateId = productService.UpdateProduct(product);
        System.out.println(updateId + "\n" + "/n");
        return updateId;
    }

    @RequestMapping("ProductController/delProduct")
    @ResponseBody
    int delProduct(HttpServletRequest request) {

        String productIdMore = request.getParameter("productId");
        return productService.DelProduct(productIdMore);

    }

    @RequestMapping("ProductController/upOrDownShopProduct")
    @ResponseBody
    int upOrDownShopProduct(HttpServletRequest request) {

        int productId = Integer.parseInt(request.getParameter("productId"));
        int type = Integer.parseInt(request.getParameter("type"));
        // 1:在售商品--》修改shop_card表的type为1
        int upShopId = productService.upOrDownShopProduct(productId, type);
        return upShopId;
    }

    @RequestMapping("changeProductPicture")
    public String changeProductPicture(@RequestParam(value = "file", required = false) MultipartFile file,
                                       HttpServletRequest request, HttpSession session) {

        System.out.println("开始");
        String productId = request.getParameter("productId");

        Product product = new Product();
        product.setProductId(productId);
        String path = "D:\\app\\graduation\\img\\";

        String oldFileName = UUID.randomUUID() + "--" + file.getOriginalFilename();
        int dex = oldFileName.indexOf(".");
        String fileName = new Date().getTime() + oldFileName.substring(dex, oldFileName.length());

        product.setImgUrl(fileName);
        System.out.println("path" + path);
        System.out.println("fileName" + fileName + "\n\n\nproductId" + productId);
        File targetFile = new File(path, fileName);
        if (!targetFile.exists()) {
            System.out.print(!targetFile.exists());
            targetFile.mkdirs();
        }

        // 保存
        try {
            // 向新名字的文件传输照片过去
            file.transferTo(targetFile);
            productService.UpdateProduct(product);
        } catch (Exception e) {
            e.printStackTrace();
        }

        // session.setAttribute("user", user);
        return "admin";
    }

}