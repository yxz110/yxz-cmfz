package com.baizhi.controller;

import com.baizhi.entity.User;
import com.baizhi.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("user")
public class UserController {
    @Autowired
    UserService userService;

    @RequestMapping("getAll")
    public Map<String, Object> getAll(Integer page, Integer rows) {
        Map<String, Object> map = userService.getAll(page, rows);

        return map;
    }

    @RequestMapping("all")
    public void all(HttpServletRequest request, HttpServletResponse response) {
        List<User> list = userService.all(request, response);

        System.out.println("导出完毕");

    }

    public List<User> findcity(Integer day) {

        List<User> citys = userService.fingCity(day);

        return citys;

        /*Gson gson = new Gson();

        String s = gson.toJson(citys);

        GoEasy goEasy = new GoEasy( "http://rest-hangzhou.goeasy.io", "BC-8feb2cd912474440a4994831c59fd3f3");

        goEasy.publish("my_channel", "s");*/

    }

    @RequestMapping("getDayCount")
    public Map<String, Integer> getDayCount() {
        Map<String, Integer> map = userService.getDayCount();

        return map;

    }


}
