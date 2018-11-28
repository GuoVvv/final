package com.baizhi.cmfz.controller;

import com.baizhi.cmfz.entity.Viewpager;
import com.baizhi.cmfz.service.ViewpagerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.Map;

@Controller
@RequestMapping("/pages")
public class ViewpagerController {

    @Autowired
    private ViewpagerService viewpagerservice;


    //分页查询
    @RequestMapping("/selectAll")
    public @ResponseBody Map getUserAll(int page, int rows){

        return viewpagerservice.selectView(page,rows);

    }

    //修改
    @RequestMapping("/update")
    public @ResponseBody boolean update(Viewpager viewpager){
        //System.out.println("修改:  "+viewpager);
          return  viewpagerservice.update(viewpager);
    }

    //插入
    @RequestMapping("/insert")
    public @ResponseBody boolean insert(Viewpager viewpager, MultipartFile uploadFile, HttpServletRequest req) throws IOException {

       // System.out.println("添加  1   ："+viewpager);
        //获取到上传上来的文件名
        String fileName=uploadFile.getOriginalFilename();

        //对文件进行重命名
        String newName=new Date().getTime()+"_"+fileName;

        //1.获取文件夹的相对路径
        String realPath =req.getSession().getServletContext().getRealPath("/img");
        //2.file对象
        File file = new File(realPath+"\\"+newName);
        //3.写入
        uploadFile.transferTo(file);
        viewpager.setImgpath(newName);
        //System.out.println("添加  2   ："+viewpager);
        return  viewpagerservice.insert(viewpager);
    }

    //删除
    @RequestMapping("/delete")
    public @ResponseBody boolean getDelete(String id){

        return viewpagerservice.delete(id);
    }



}
