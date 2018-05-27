package com.iozhaq.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.iozhaq.beans.Address;
import com.iozhaq.beans.User;
import com.iozhaq.service.UserService;

@Controller
public class UserController {

    // Logger log=LoggerFactory.getLogger(getClass());

    @Resource
    UserService userService;

    @RequestMapping("admin")
    public ModelAndView admin() {
        ModelAndView model = new ModelAndView("admin");
        return model;
    }

    @RequestMapping("user")
    public ModelAndView user() {
        ModelAndView model = new ModelAndView("user");
        return model;
    }

    @RequestMapping("login")
    public ModelAndView login() {
        ModelAndView model = new ModelAndView("login");
        return model;
    }

    @RequestMapping("userMessage")
    public ModelAndView product() {
        ModelAndView model = new ModelAndView("user/userMessage");
        return model;
    }

    @RequestMapping("oneUserMessage")
    public ModelAndView oneUserMessage() {
        ModelAndView model = new ModelAndView("user/oneUserMessage");
        return model;
    }

    @RequestMapping("address")
    public ModelAndView address() {
        ModelAndView model = new ModelAndView("address/address");
        return model;
    }

    @RequestMapping("UserController/addUser")
    @ResponseBody
    int addProduct(User user) {
        int updateId;
        User u = userService.findByUserName(user.getUserName());
        if (u == null) {
            updateId = userService.createUser(user);
        } else {
            updateId = 0;
        }
        return updateId;
    }

    @RequestMapping("UserController/updateUser")
    @ResponseBody
    int updateProduct(HttpServletRequest request, User user) {
        int updateId = userService.updateUser(user);
        return updateId;
    }

    @RequestMapping("UserController/userlist")
    @ResponseBody
    public List<User> userlist(HttpServletRequest request) {

        String userName = request.getParameter("userName");
        String sex = request.getParameter("sex");
        List<User> userList = new ArrayList<User>();
        userList = userService.UserListByQuery(userName, sex);
        return userList;
    }

    @RequestMapping("UserController/oneUserMessage")
    @ResponseBody
    public User findByUserId(HttpSession session) {

        User user = (User) session.getAttribute("user");
        System.out.println("userId:" + user.getUserId());
        User oneUserMessage = new User();
        oneUserMessage = userService.findByUserId(user.getUserId());
        return oneUserMessage;
    }

    @RequestMapping("UserController/updateOneUserMessage")
    @ResponseBody
    int updateUser(User user, HttpSession session) {

        int updateId = userService.updateUser(user);

        User user1 = (User) session.getAttribute("user");
        user1.setUserName(user.getUserName());
        session.setAttribute("user", user1);
        return updateId;
    }

    /**
     *
     * @param request
     * @return
     */
    @RequestMapping("UserController/editPassword")
    @ResponseBody
    int editPassword(HttpServletRequest request) {

        User user = (User) request.getSession().getAttribute("user");
        String userId = user.getUserId();
        String oldPassword = request.getParameter("oldPassword");
        String password = request.getParameter("newPassword");

        int editNum;
        User user2 = userService.findByUserIdAndPassword(userId, oldPassword);
        if (user2 != null) {
            System.out.println(user2.getAddress());
            editNum = userService.editPassword(userId, password);

        } else {
            editNum = -1;
        }
        return editNum;
    }

    @RequestMapping("UserController/editType")
    @ResponseBody
    int editType(HttpServletRequest request) {

        int userId = Integer.parseInt(request.getParameter("userId"));
        String type = request.getParameter("type");

        int editType = userService.editType(userId, type);
        return editType;
    }

    @RequestMapping("UserController/addresslist")
    @ResponseBody
    public List<Address> addresslist(HttpSession session, HttpServletRequest request) {

        List<Address> addressList = new ArrayList<Address>();

        String userId = request.getParameter("userId");
        if (userId == null || userId == "") {
            System.out.println("\n\nuserId" + userId);
            User user = (User) session.getAttribute("user");
            addressList = userService.AddressList(user.getUserId());
        } else {
            System.out.println("\n\n" + userId);
            addressList = userService.AddressList(userId);
        }

        return addressList;
    }

    @RequestMapping("UserController/addAddress")
    @ResponseBody
    public int addAddresslist(HttpServletRequest request, Address addressBean) throws UnsupportedEncodingException {

        User user = (User) request.getSession().getAttribute("user");
        String userId = user.getUserId();

        addressBean.setUserId(userId);
        String province = request.getParameter("province");
        String city = request.getParameter("city");
        String district = request.getParameter("district");
        String address = province + city + district;
        addressBean.setAddress(address);
        int addId;
        System.out.println("\n\n" + addressBean.getAddressId() + "\n");
        if (addressBean.getAddressId() != null) {
            addId = userService.updateAddress(addressBean);
        } else {
            addId = userService.addAddress(addressBean);
        }
        System.out.println(addressBean.getAddressDetail() + "\n" + addressBean.getAddress());

        return addId;
    }

    @RequestMapping("UserController/delAddress")
    @ResponseBody
    int delProduct(HttpServletRequest request) {

        String addressId = request.getParameter("addressId");
        return userService.delAddress(addressId);

    }

    @RequestMapping("UserController/defaultAddress")
    @ResponseBody
    int defaultAddress(HttpServletRequest request) {

        String addressId = request.getParameter("addressId");
        User user = (User) request.getSession().getAttribute("user");
        List<Address> addressList = new ArrayList<Address>();
        addressList = userService.AddressList(user.getUserId());
        userService.CancelDefaultAddress(addressList);
        int defaultAddressCount = userService.defaultAddress(addressId);
        return defaultAddressCount;
    }

    @RequestMapping("changeUserPicture")
    public String changeUserPicture(@RequestParam(value = "file", required = false) MultipartFile file,
                                    HttpServletRequest request, HttpSession session) {

        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            return "login";
        }

        String filepath = "D:\\app\\graduation\\img\\";

        String path = filepath;

        String oldFileName = UUID.randomUUID() + "--" + file.getOriginalFilename();
        int dex = oldFileName.indexOf(".");
        String fileName = new Date().getTime() + oldFileName.substring(dex, oldFileName.length());
        System.out.println("path" + path);
        System.out.println("fileName" + fileName);
        user.setImgUrl(fileName);
        File targetFile = new File(path, fileName);
        if (!targetFile.exists()) {
            System.out.print(!targetFile.exists());
            targetFile.mkdirs();
        }

        // 保存
        try {
            file.transferTo(targetFile);
            userService.updateUser(user);
        } catch (Exception e) {
            e.printStackTrace();
        }

        session.setAttribute("user", user);
        if (("0").equals(user.getType())) {
            return "admin";
        } else {
            return "user";
        }
    }
}