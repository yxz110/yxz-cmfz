package com.baizhi.dao;


import com.baizhi.entity.Banner;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface BannerDao {
    //查询所有 begin开始查 rows查多少行
    public List<Banner> findAll(@Param("begin") Integer begin, @Param("rows") Integer rows);

    //获取总条数
    public Integer getCount();

    //添加
    public void add(Banner banner);

    //修改属性
    public void update(Banner banner);

    //修改状态
    public void updateStatus(Banner banner);

    //删除
    public void delete(String[] id);


}
