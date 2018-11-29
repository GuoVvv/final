package com.baizhi.cmfz.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;

@Data
public class Chapter {

    private String id;
    private String title;
    private String size;
    private String duration;
    private String downpath;
    @JsonFormat(pattern = "yyyy-MM-dd hh:ss:mm")
    private Date uploadDate;
    private int pid;
}
