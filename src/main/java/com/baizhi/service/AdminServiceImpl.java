package com.baizhi.service;

import com.baizhi.dao.AdminDao;
import com.baizhi.entity.Admin;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;


@Service
@Transactional
public class AdminServiceImpl implements AdminService {

    @Autowired
    AdminDao adminDao;


    //登陆 表单验证
    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public Map<String, Object> login(String username, String password, String enCode, HttpSession session) {
        Map<String, Object> map = new HashMap<>();

        //获取session中的验证码
        String securityCode = (String) session.getAttribute("securityCode");
        //若验证码不一致显示提示信息若一致跳转到首页
        if (enCode.equals(securityCode)) {
            Admin admin = adminDao.login(username);
            if (admin != null) {
                if (password.equals(admin.getPassword())) {
                    map.put("msg", "ok");
                    map.put("admin", admin);
                    session.setAttribute("admin", admin);
                    return map;
                } else {
                    map.put("msg", "密码错误");
                    return map;
                }
            } else {
                map.put("msg", "用户不存在");
                return map;
            }
        } else {
            map.put("msg", "验证码错误");
            return map;
        }

    }


}
