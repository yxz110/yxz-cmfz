package com.baizhi.service;

import com.baizhi.entity.Banner;

import java.util.HashMap;
import java.util.Map;

public interface BannerService {
    //查所有
    public Map<String, Object> findAll(Integer page, Integer rows);

    //添加
    public HashMap<Object, Object> add(Banner banner);

    //修改属性
    public void update(Banner banner);

    //修改状态
    public void updateStatus(Banner banner);

    //删除
    public void delete(String[] id);

}
