package com.baizhi.cmfz.Utils;

import org.jaudiotagger.audio.AudioFileIO;
import org.jaudiotagger.audio.mp3.MP3AudioHeader;
import org.jaudiotagger.audio.mp3.MP3File;

import java.io.File;

public class FileUtil {

    public static String getDuration(File file) {
        try {
            MP3File f = (MP3File) AudioFileIO.read(file);
            MP3AudioHeader audioHeader = (MP3AudioHeader) f.getAudioHeader();
            int length = audioHeader.getTrackLength();
            //System.out.println("aaaaaaa  "+length);
             String m=String.valueOf(length/60);
             String s= String.valueOf(length%60);
             String ssss=m+"分"+s+"秒";
             return  ssss;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

}
