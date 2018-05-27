package com.iozhaq.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.iozhaq.beans.User;
import com.iozhaq.service.UserService;

@Controller
public class LoginController {
    @Resource
    UserService userService;

    @RequestMapping("loginIn")
    public String login(Model model, HttpServletRequest request, HttpSession session) {
        String userName = request.getParameter("userName");
        String password = request.getParameter("Password");
        String type = request.getParameter("RadioList");

        if (userName != null && password != null) {

            User user = userService.login(userName, password, type);
            if (user != null) {
                session.setAttribute("user", user);
                if (user.getType().equals("0")) {
                    return "admin";
                } else if (user.getType().equals("11")) {
                    return "user";
                } else {
                    model.addAttribute("message", "black");
                    return "login";
                }

            } else {
                System.out.println("nosuccess");
                model.addAttribute("message", "no");
                return "login";
            }
        } else {
            model.addAttribute("message", "erro");
            return "login";
        }
    }

}
