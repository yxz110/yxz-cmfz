package com.baizhi.service;


import com.baizhi.dao.AlbumDao;
import com.baizhi.entity.Album;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Transactional
@Service
public class AlbumServiceImpl implements AlbumService {
    @Autowired
    AlbumDao albumDao;

    @Override
    public void udateCover(String id, String imgpic) {

        albumDao.updateCover(id, imgpic);
    }

    @Override
    public void update(Album album) {

        albumDao.update(album);
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public Map<String, Object> getAll(Integer page, Integer rows) {
        Map<String, Object> map = new HashMap<>();

        //计算其实下标
        Integer begin = (page - 1) * rows;
        List<Album> list = albumDao.getAll(begin, rows);
        Integer records = albumDao.getCount();
        Integer total = records % rows == 0 ? records / rows : records / rows + 1;
        map.put("rows", list);
        map.put("records", records);
        map.put("total", total);
        map.put("page", page);
        return map;
    }

    @Override
    public Map<String, Object> add(Album album) {
        HashMap<String, Object> map = new HashMap<>();
        album.setId(UUID.randomUUID().toString());
        album.setScore(90);
        album.setAcount(55);
        album.setCreatedate(new Date());
        albumDao.add(album);

        String id = album.getId();
        map.put("id", id);
        return map;
    }

}
