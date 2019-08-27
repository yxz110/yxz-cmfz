package com.baizhi.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.text.SimpleDateFormat;
import java.util.*;

@RequestMapping("kindeditor")
@RestController
public class KindeditorController {
    @RequestMapping("upload")
    public Map<String, Object> upload(MultipartFile img, HttpServletRequest request) throws IOException {
        String realPath = request.getSession().getServletContext().getRealPath("/img");
        File file = new File(realPath);
        if (!file.exists()) {
            file.mkdirs();
        }
        //获取文件原始名
        String originalFilename = img.getOriginalFilename();
        //为了防止覆盖   拼接新名称
        String imgName = new Date().getTime() + "_" + originalFilename;
        //上传
        img.transferTo(new File(realPath, imgName));
        Map<String, Object> map = new HashMap<>();
        //获取协议
        String scheme = request.getScheme();
        //获取本机 网络IP地址
        InetAddress localHost = InetAddress.getLocalHost();
        String localHosh = localHost.toString().split("/")[1];
        //获取端口号
        int port = request.getServerPort();
        //获取项目名
        String contextPath = request.getContextPath();
        String url = scheme + "://" + localHosh + ":" + port + contextPath + "/img/" + imgName;

        map.put("erro", 0);
        map.put("url", url);
        return map;
    }

    @RequestMapping("allImages")
    public Map<String, Object> allImages(HttpServletRequest request) throws UnknownHostException {
        Map<String, Object> map = new HashMap<>();
        List<Map<String, Object>> list = new ArrayList<>();
        String realPath = request.getSession().getServletContext().getRealPath("/img");
        File file = new File(realPath);
        String[] files = file.list();
        for (String s : files) {
            Map<String, Object> map1 = new HashMap<>();
            map1.put("is_dir", false);
            map1.put("has_file", false);
            File file1 = new File(realPath, s);
            long length = file1.length();
            map1.put("filesize", length);
            map1.put("dir_path", "");
            map1.put("is_photo", true);
            String s1 = s.substring(s.lastIndexOf(".") + 1);
            map1.put("filetype", s1);
            map1.put("filename", s);
            boolean flag = s.contains("_");
            if (flag == true) {
                String s2 = s.split("_")[0];
                Long aLong = Long.valueOf(s2);
                SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                String s3 = format.format(aLong);
                map1.put("datetime", s3);
            }
            if (flag == false) {
                map1.put("datetime", new Date());
            }
            list.add(map1);
        }

        //获取协议
        String scheme = request.getScheme();
        //获取本机网络的id地址
        InetAddress localHost = InetAddress.getLocalHost();
        String localhost = localHost.toString().split("/")[1];
        //获取端口号
        int port = request.getServerPort();
        //获取项目名
        String contextPath = request.getContextPath();

        String url = scheme + "://" + localhost + ":" + port + contextPath + "/img/";
        map.put("moveup_dir_path", "");
        map.put("current_dir_path", "");
        map.put("current_url", url);
        map.put("total_count", list.size());
        map.put("file_list", list);
        return map;
    }
}

