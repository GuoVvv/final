package com.baizhi.cmfz.service.impl;

import com.baizhi.cmfz.dao.ChapterDao;
import com.baizhi.cmfz.entity.Chapter;
import com.baizhi.cmfz.service.ChapterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.UUID;

@Service("chapterservice")
public class ChapterServcieImpl implements ChapterService {

    @Autowired
    private ChapterDao chapterDao;

    @Override
    public boolean insert(Chapter chapter) {
        try{

            chapter.setUploadDate(new Date());
            chapter.setId(UUID.randomUUID().toString());
            //System.out.println("---------"+chapter);
            chapterDao.insert(chapter);
            return true;
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
    }
}
