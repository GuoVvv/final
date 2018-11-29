package com.baizhi.cmfz.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;
import java.util.List;

@Data
public class Album {

    private int id;
    private String  title;
    private String coverimg;
    private int  count;
    private Double score;
    private String  auctor;
    private String  broadcast;
    private String  brief;
    @JsonFormat(pattern = "yyyy-MM-dd hh:ss:mm")
    private Date publishDate;
    private List<Chapter> children;

}
