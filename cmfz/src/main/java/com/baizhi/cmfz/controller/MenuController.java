package com.baizhi.cmfz.controller;

import com.baizhi.cmfz.entity.Menu;
import com.baizhi.cmfz.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/main")
public class MenuController {

    @Autowired
    private MenuService menuservice;

    @RequestMapping("/getmenu")
    public @ResponseBody List<Menu> getmenu(){
            return menuservice.getmenu();
    }
}
