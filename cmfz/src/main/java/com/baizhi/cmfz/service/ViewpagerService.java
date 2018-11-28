package com.baizhi.cmfz.service;

import com.baizhi.cmfz.entity.Viewpager;

import java.util.Map;

public interface ViewpagerService {

    Map selectView(int page, int rows);

    //修改
    boolean update(Viewpager viewpager);

    //添加
    boolean insert(Viewpager viewpager);

    //删除
    boolean delete(String id);

}
