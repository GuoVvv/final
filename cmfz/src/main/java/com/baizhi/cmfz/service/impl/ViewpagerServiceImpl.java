package com.baizhi.cmfz.service.impl;

import com.baizhi.cmfz.dao.ViewpagerDao;
import com.baizhi.cmfz.entity.Viewpager;
import com.baizhi.cmfz.service.ViewpagerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service("viewpagerservice")
public class ViewpagerServiceImpl implements ViewpagerService {

    @Autowired
    private ViewpagerDao viewpagerDao;

    @Override
    public Map selectView(int page,int rows) {

        //当前开始数据  不包含
        int start=(page-1)*rows;

        //加载总条数
        int count=viewpagerDao.getcount();
        List<Viewpager> list=viewpagerDao.selectView(start,rows);

        Map map=new HashMap();
        map.put("total", count);
        map.put("rows", list);
        return map;
    }

    @Override
    public boolean update(Viewpager viewpager) {
        try{
           /* if(viewpager.getStatus().equals("y")){
                viewpager.setStatus("n");
            }else if(viewpager.getStatus().equals("n")){
                viewpager.setStatus("y");
            }*/
            viewpagerDao.update(viewpager);
            return true;
        }catch (Exception e){
            e.printStackTrace();
            return  false;
        }
    }

    @Override
    public boolean insert(Viewpager viewpager) {
        try{
            String uuid = UUID.randomUUID().toString();
            viewpager.setId(uuid);
            viewpager.setDate(new Date());
            System.out.println("添加  3   ："+viewpager);
            viewpagerDao.insert(viewpager);
            return true;
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean delete(String id) {
        try{
            viewpagerDao.delete(id);
            return  true;
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
    }
}
