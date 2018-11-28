package com.baizhi.cmfz.dao;

import com.baizhi.cmfz.entity.Viewpager;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ViewpagerDao {

    //轮播图全部
    List<Viewpager> selectView(@Param("start")int start, @Param("rows") int rows);

    //总数
    int getcount();

    //修改
    void update(Viewpager viewpager);

    //添加
    void insert(Viewpager viewpager);

    //删除
    void delete(@Param("id")String  id);
}
