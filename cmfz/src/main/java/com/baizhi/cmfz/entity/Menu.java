package com.baizhi.cmfz.entity;

import lombok.Data;

import java.util.List;

/**
 * @author GuoVvv
 */
@Data
public class Menu {
    private String id;
    private String title;
    private String iconcls;
    private String parent_id;
    private String url;
    private List<Menu> menus;
}
