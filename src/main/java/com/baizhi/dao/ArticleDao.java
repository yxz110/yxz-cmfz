package com.baizhi.dao;

import com.baizhi.entity.Article;

import java.util.List;

public interface ArticleDao {
    public List<Article> getAll(Integer begin, Integer rows);

    public Integer getCount();

    public void add(Article article);

    public void update(Article article);
}
