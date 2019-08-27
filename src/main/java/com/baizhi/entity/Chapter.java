package com.baizhi.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Chapter {
    private String id;
    private String url;
    private String status;
    private String albumId;
    private String title;
    private String asize;
    private String duration;
    private Date createdate;
}
