package com.baizhi.dao;

import com.baizhi.entity.Album;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AlbumDao {
    public List<Album> getAll(@Param("begin") Integer begin, @Param("rows") Integer rows);

    public Integer getCount();

    public void add(Album album);

    public void updateCover(@Param("id") String id, @Param("imgpic") String imgpic);

    public void update(Album album);


}
