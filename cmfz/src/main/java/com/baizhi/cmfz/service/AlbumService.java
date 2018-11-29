package com.baizhi.cmfz.service;

import com.baizhi.cmfz.entity.Album;

import java.util.Map;

public interface AlbumService {

    Map selectAlbum(int page, int rows);

    boolean insertAlbum(Album album);
}
