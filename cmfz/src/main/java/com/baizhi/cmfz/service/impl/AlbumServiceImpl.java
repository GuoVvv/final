package com.baizhi.cmfz.service.impl;

import com.baizhi.cmfz.dao.AlbumDao;
import com.baizhi.cmfz.entity.Album;
import com.baizhi.cmfz.service.AlbumService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("albumservice")
public class AlbumServiceImpl implements AlbumService {

    @Autowired
    private AlbumDao albumDao;

    @Override
    public Map selectAlbum(int page, int rows) {
        //当前开始数据  不包含
        int start=(page-1)*rows;

        //加载总条数
        int count=albumDao.getcount();
        List<Album> list=albumDao.selectAll(start,rows);

        Map map=new HashMap();
        map.put("total", count);
        map.put("rows", list);
        return map;
    }

    @Override
    public boolean insertAlbum(Album album) {
        try{
            album.setCount(20);
            album.setScore(10.0);
            album.setPublishDate(new Date());
            albumDao.insert(album);
            return true;
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
    }
}
