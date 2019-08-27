package com.baizhi.service;

import com.baizhi.entity.User;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

public interface UserService {
    public Map<String, Object> getAll(Integer page, Integer rows);

    public List<User> all(HttpServletRequest request, HttpServletResponse response);

    public Map<String, Object> add(User user);

    public void update(User user);

    public List<User> fingCity(Integer day);

    public Map<String, Integer> getDayCount();


}
