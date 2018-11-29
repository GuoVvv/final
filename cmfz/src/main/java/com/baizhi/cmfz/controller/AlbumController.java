package com.baizhi.cmfz.controller;

import com.baizhi.cmfz.entity.Album;
import com.baizhi.cmfz.service.AlbumService;
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
public class AlbumController {

    @Autowired
    private AlbumService albumservice;

    //分页查询
    @RequestMapping("/selectAblum")
    public @ResponseBody Map getUserAll(int page, int rows){
        //System.out.println("vvvvv  ");
        return albumservice.selectAlbum(page,rows);

    }

    @RequestMapping("/insertAblum")
    public @ResponseBody boolean insert(Album album, MultipartFile img, HttpServletRequest req) throws IOException {
        //获取到上传上来的文件名
        String fileName=img.getOriginalFilename();

        //对文件进行重命名
        String newName=new Date().getTime()+"_"+fileName;

        //1.获取文件夹的相对路径
        String realPath =req.getSession().getServletContext().getRealPath("/img");
        //2.file对象
        File file = new File(realPath+"\\"+newName);
        //3.写入
        img.transferTo(file);
        album.setCoverimg("\\img\\"+newName);
        return albumservice.insertAlbum(album);
    }

}
