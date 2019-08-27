package com.baizhi.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Banner {
    private String id;
    //图片
    private String imgpic;
    //标题
    private String title;
    //描述
    private String describe;
    //状态
    private String status;
    //日期
    private Date createdate;
}
