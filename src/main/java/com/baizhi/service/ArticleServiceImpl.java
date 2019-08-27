package com.baizhi.service;

import com.baizhi.dao.ArticleDao;
import com.baizhi.entity.Article;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service
@Transactional
public class ArticleServiceImpl implements ArticleService {
    @Autowired
    ArticleDao articleDao;

    @Transactional(propagation = Propagation.SUPPORTS)
    @Override
    public Map<String, Object> getAll(Integer page, Integer rows) {
        Map<String, Object> map = new HashMap<>();
        Integer begin = (page - 1) * rows;
        List<Article> all = articleDao.getAll(begin, rows);
        Integer count = articleDao.getCount();
        Integer total = count % rows == 0 ? count / rows : count / rows + 1;

        map.put("rows", all);
        map.put("total", total);
        map.put("count", count);
        map.put("page", page);

        return map;
    }

    @Override
    public Map<String, Object> add(Article article) {
        Map<String, Object> map = new HashMap<>();

        article.setId(UUID.randomUUID().toString());
        article.setCreatedate(new Date());

        articleDao.add(article);
        String id = article.getId();
        map.put("id", id);

        return map;
    }


    @Override
    public void update(Article article) {
        System.out.println(article + "+++++++++++++++++++++++++++++++++++++");
        articleDao.update(article);
    }
}
