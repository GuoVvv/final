package com.baizhi.cmfz.controller;

import com.baizhi.cmfz.entity.Admin;
import com.baizhi.cmfz.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

@Controller
public class AdminController {

    @Autowired
    private AdminService adminservice;

    @RequestMapping("/login")
    public String login(Admin admin, HttpSession session,String code){

        String yzm = (String) session.getAttribute("kaptcha");
        if (yzm.equalsIgnoreCase(code)) {
            if (adminservice.login(admin)!=null) {

                session.setAttribute("admin",adminservice.login(admin));
                return "redirect:/main/main.jsp";
            } else {
                return "redirect:/login.jsp";
            }
        }else{
            return "redirect:/login.jsp";
        }
    }
}
