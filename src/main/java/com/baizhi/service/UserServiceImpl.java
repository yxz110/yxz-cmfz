package com.baizhi.service;

import cn.afterturn.easypoi.excel.ExcelExportUtil;
import cn.afterturn.easypoi.excel.entity.ExportParams;
import com.baizhi.dao.UserDao;
import com.baizhi.entity.User;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.*;

@Service
@Transactional
public class UserServiceImpl implements UserService {

    @Autowired
    UserDao userDao;


    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public Map<String, Object> getAll(Integer page, Integer rows) {
        Map<String, Object> map = new HashMap<>();


        Integer begin = (page - 1) * rows;
        List<User> all = userDao.getAll(begin, rows);
        Integer count = userDao.getCount();
        Integer total = count % rows == 0 ? count / rows : count / rows + 1;

        map.put("rows", all);
        map.put("total", total);
        map.put("count", count);
        map.put("page", page);

        return map;
    }

    @Override
    public List<User> fingCity(Integer day) {
        List<User> citys = userDao.fingCity(day);

        return citys;
    }

    @Override
    public List<User> all(HttpServletRequest request, HttpServletResponse response) {

        String realPath = request.getServletContext().getRealPath("/img/");

        List<User> all = userDao.all();

        for (User user : all) {
            String imgpic = user.getImgpic();
            user.setImgpic(imgpic);
        }
        Workbook workbook = ExcelExportUtil.exportExcel(new ExportParams("轮播图列表", "图片"), User.class, all);

        try {
            String encode = URLEncoder.encode("轮播图.xls", "UTF-8");
            response.setHeader("content-disposition", "attachment;filename=" + encode);
            ServletOutputStream outputStream = response.getOutputStream();
            workbook.write(outputStream);
        } catch (IOException e) {
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public Map<String, Object> add(User user) {
        Map<String, Object> map = new HashMap<>();
        user.setId(UUID.randomUUID().toString());
        user.setCreatedate(new Date());
        userDao.add(user);
        String id = user.getId();
        map.put("id", id);

        return map;

    }

    @Override
    public void update(User user) {

    }


    @Override
    public Map<String, Integer> getDayCount() {
        Map<String, Integer> map = new HashMap<>();

        map.put("one", userDao.getDayCount(5));
        map.put("two", userDao.getDayCount(10));
        map.put("three", userDao.getDayCount(20));
        map.put("foue", userDao.getDayCount(21));
        map.put("five", userDao.getDayCount(22));
        map.put("six", userDao.getDayCount(25));
        map.put("seven", userDao.getDayCount(30));


        return map;
    }
}
