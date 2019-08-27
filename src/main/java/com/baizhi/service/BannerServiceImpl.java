package com.baizhi.service;

import com.baizhi.dao.BannerDao;
import com.baizhi.entity.Banner;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service
@Transactional
public class BannerServiceImpl implements BannerService {
    @Autowired
    private BannerDao bannerDao;


    @Override
    public Map<String, Object> findAll(Integer page, Integer rows) {
        Map<String, Object> map = new HashMap<>();
        Integer begin = (page - 1) * rows;
        List<Banner> list = bannerDao.findAll(begin, rows);
        Integer count = bannerDao.getCount();//总条数
        Integer total = count % rows == 0 ? count / rows : count / rows + 1;//总页数
        map.put("rows", list);
        map.put("total", total);
        map.put("records", count);
        map.put("page", page);

        return map;
    }

    @Override
    public HashMap<Object, Object> add(Banner banner) {
        HashMap<Object, Object> map = new HashMap<>();
        banner.setId(UUID.randomUUID().toString().replace("-", ""));
        banner.setCreatedate(new Date());
        bannerDao.add(banner);
        String id = banner.getId();
        map.put("id", id);
        return map;
    }

    @Override
    public void update(Banner banner) {
        bannerDao.update(banner);
    }

    @Override
    public void updateStatus(Banner banner) {
        bannerDao.updateStatus(banner);
    }

    @Override
    public void delete(String[] id) {
        bannerDao.delete(id);
    }
}
