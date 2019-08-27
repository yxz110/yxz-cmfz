package com.baizhi.controller;

import com.baizhi.service.AdminService;
import com.baizhi.util.ValidateImageCodeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Map;

@RequestMapping("admin")
@RestController
public class AdminController {
    @Autowired
    AdminService adminService;


    @RequestMapping("login")
    public Map<String, Object> login(String username, String password, String enCode, HttpSession session) {
        Map<String, Object> map = adminService.login(username, password, enCode, session);
        return map;
    }


    @RequestMapping("getImage")
    public void getImage(HttpSession session, HttpServletResponse response) {
        //生成验证码
        String securityCode = ValidateImageCodeUtils.getSecurityCode();
        System.out.println(securityCode);
        //将验证码存入作用域
        session.setAttribute("securityCode", securityCode);

        BufferedImage image = ValidateImageCodeUtils.createImage(securityCode);
        ServletOutputStream outputStream = null;
        try {
            outputStream = response.getOutputStream();
            ImageIO.write(image, "png", outputStream);
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                outputStream.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}







