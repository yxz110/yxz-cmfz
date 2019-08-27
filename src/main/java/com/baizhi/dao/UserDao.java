package com.baizhi.dao;

import com.baizhi.entity.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserDao {
    public List<User> getAll(@Param("begin") Integer begin, @Param("rows") Integer rows);

    public Integer getCount();

    public List<User> all();

    public void add(User user);

    public List<User> fingCity(Integer day);

    public Integer getDayCount(Integer dayCount);

}
