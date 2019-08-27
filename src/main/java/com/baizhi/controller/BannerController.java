package com.baizhi.controller;

import com.baizhi.entity.Banner;
import com.baizhi.service.BannerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("banner")
public class BannerController {

    @Autowired
    private BannerService bannerService;

    //查询所有
    @RequestMapping("findAll")
    public Map<String, Object> findAll(Integer page, Integer rows) {
        Map<String, Object> map = bannerService.findAll(page, rows);
        return map;
    }

    //增删改
    @RequestMapping("edit")
    public HashMap<Object, Object> edit(String oper, Banner banner, String[] id) {
        if ("add".equals(oper)) {
            HashMap<Object, Object> map = bannerService.add(banner);
            return map;
        }
        if ("edit".equals(oper)) {
            bannerService.updateStatus(banner);
        }
        if ("del".equals(oper)) {
            bannerService.delete(id);
        }
        return null;
    }

    //文件上传
    @RequestMapping("upload")
    public void upload(String bannerId, MultipartFile imgpic, HttpSession session) {
        System.out.println("--------------------");
        //获取图片路径
        String realPath = session.getServletContext().getRealPath("/img");
        System.out.println(realPath);
        File file = new File(realPath);
        if (!file.exists()) {
            file.mkdirs();
        }
        String filename = imgpic.getOriginalFilename();

        String newFileName = new Date().getTime() + "_" + filename;
        try {
            imgpic.transferTo(new File(realPath, newFileName));
        } catch (IOException e) {
            e.printStackTrace();
        }
        Banner banner = new Banner();
        banner.setId(bannerId);
        banner.setImgpic(newFileName);
        System.out.println(banner);
        bannerService.update(banner);
    }
}