package com.baizhi.entity;

import cn.afterturn.easypoi.excel.annotation.Excel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class User {
    @Excel(name = "编号")
    private String id;
    @Excel(name = "名字")
    private String name;
    @Excel(name = "密码")
    private String password;
    @Excel(name = "性别", replace = {"男_m", "女_g"}, suffix = "生")
    private String sex;
    @Excel(name = "法名")
    private String dharma;
    @Excel(name = "城市")
    private String provice;
    @Excel(name = "创建日期", format = "yyyy-MM-dd", width = 30)
    private Date createdate;
    @Excel(name = "签名")
    private String sign;
    @Excel(name = "图片")
    private String imgpic;
    @Excel(name = "状态")
    private String status;

}
