package com.baizhi.cmfz.controller;

import com.baizhi.cmfz.Utils.FileUtil;
import com.baizhi.cmfz.entity.Chapter;
import com.baizhi.cmfz.service.ChapterService;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.UUID;

@Controller
@RequestMapping("/pages")
public class ChapterController {

    @Autowired
    private ChapterService chapterservice;

    @RequestMapping("insertChapter")
    public  @ResponseBody boolean insert(Chapter chapter, MultipartFile music, HttpServletRequest req) throws IOException {

        //文件大小


        String extension = FilenameUtils.getExtension(music.getOriginalFilename());
        //对文件进行重命名
        String uuid=UUID.randomUUID().toString();
        String newName=uuid+"."+extension;


        //1.获取文件夹的相对路径
        String realPath =req.getSession().getServletContext().getRealPath("/music");
        //2.file对象
        File file = new File(realPath+"\\"+newName);
        //3.写入


        try {
            music.transferTo(new File(file.getAbsolutePath()));
        } catch (IOException e) {
            e.printStackTrace();
        }

        String ff= FileUtil.getDuration(new File(file.getAbsolutePath()));
        //System.out.println("sssssss "+ff);
        long size = music.getSize();
        double l = size / 1024.0 / 1024.0;

        chapter.setSize(l);
        chapter.setDuration(ff);
        chapter.setDownpath("\\music\\"+newName);
        return  chapterservice.insert(chapter);
    }

    //下载
    @RequestMapping("/download")
    public void download(String url, String title, HttpServletRequest request, HttpServletResponse response) {

        //当前项目的路径
        String uploadPath = request.getSession().getServletContext().getRealPath("music");
        String path = uploadPath + "/" + url;
        File file = new File(path);

        //下载
        String s = title + "." + "mp3";


        //响应出去数据编码集
        try {
            response.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(s, "utf-8"));
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        response.setContentType("audio/mpeg");

        //出去吧
        try {
            ServletOutputStream outputStream = response.getOutputStream();
            outputStream.write(FileUtils.readFileToByteArray(file));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
