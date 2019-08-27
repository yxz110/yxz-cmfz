package com.baizhi.service;


import com.baizhi.entity.Article;

import java.util.Map;

public interface ArticleService {
    public Map<String, Object> getAll(Integer page, Integer rows);

    public Map<String, Object> add(Article article);

    public void update(Article article);

}
