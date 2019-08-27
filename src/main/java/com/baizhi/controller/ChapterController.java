package com.baizhi.controller;

import com.baizhi.entity.Chapter;
import com.baizhi.service.ChapterService;
import org.apache.commons.io.FileUtils;
import org.jaudiotagger.audio.AudioFile;
import org.jaudiotagger.audio.AudioFileIO;
import org.jaudiotagger.audio.AudioHeader;
import org.jaudiotagger.audio.exceptions.CannotReadException;
import org.jaudiotagger.audio.exceptions.InvalidAudioFrameException;
import org.jaudiotagger.audio.exceptions.ReadOnlyFileException;
import org.jaudiotagger.tag.TagException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Date;
import java.util.Map;

@RestController
@RequestMapping("chapter")
public class ChapterController {
    @Autowired
    ChapterService chapterService;

    @RequestMapping("getAll")
    public Map<String, Object> getAll(Integer page, Integer rows, String albumId) {
        Map<String, Object> all = chapterService.getAll(page, rows, albumId);
        return all;
    }

    @RequestMapping("edit")
    public String edit(String oper, Chapter chapter) {
        if ("add".equals(oper)) {
            String add = chapterService.add(chapter);
            return add;
        }

        return null;
    }

    @RequestMapping("upload")
    public void upload(String chapterId, MultipartFile url, HttpSession session) throws IOException, TagException, ReadOnlyFileException, CannotReadException, InvalidAudioFrameException {
        String realPath = session.getServletContext().getRealPath("/music");
        File file = new File(realPath);
        if (!file.exists()) {
            file.mkdirs();
        }
        //防止重名
        String filename = url.getOriginalFilename();
        String newName = new Date().getTime() + "_" + filename;
        url.transferTo(new File(realPath, newName));

        //计算音频大小
        long l = url.getSize();
        String size = l / 1024 / 1024 + "MB";

        //计算音频时长
        AudioFile read = AudioFileIO.read(new File(realPath, newName));
        AudioHeader audioHeader = read.getAudioHeader();
        int trackLength = audioHeader.getTrackLength();
        String m = trackLength / 60 + "分";
        String s = trackLength % 60 + "秒";
        Chapter chapter = new Chapter();
        chapter.setId(chapterId);
        chapter.setUrl(newName);
        chapter.setAsize(size);
        chapter.setDuration(m + s);
        chapterService.update(chapter);
    }

    @RequestMapping("down")
    public void down(String audioName, HttpServletResponse response, HttpSession session) throws UnsupportedEncodingException {
        String realPath = session.getServletContext().getRealPath("music");
        File file = new File(realPath, audioName);
        String s = audioName.toString().split("_")[1];
        String encode = URLEncoder.encode(s, "UTF-8");
        String s1 = encode.replace("+", "%20");

        response.setHeader("content-disposition", "attachment;filename=" + s1);

        ServletOutputStream outputStream = null;
        try {
            outputStream = response.getOutputStream();
            FileUtils.copyFile(file, outputStream);
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                outputStream.close();
            } catch (IOException e) {
                e.printStackTrace();
            }

        }

    }


}
