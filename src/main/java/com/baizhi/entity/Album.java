package com.baizhi.entity;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Album {
    private String id;
    private String title;//名称
    private Integer score;//分数
    private String author;//作者
    private String broadcast;//播音员
    private Integer acount;//集数
    private String brief;//简介
    private String status;//状态
    private Date createdate;//创建日期
    private String imgpic;//封面


}
