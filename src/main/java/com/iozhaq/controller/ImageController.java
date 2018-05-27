/**
 *
 */
package com.iozhaq.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.iozhaq.beans.User;

/**
 * @author Zhaoqi
 */
@Controller
public class ImageController {

    @RequestMapping("/img")
    public void showPicture(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws IOException {

        String imgName = request.getParameter("imgName");

        String filepath = "D:\\app\\graduation\\img\\";
        InputStream in = new FileInputStream(new File(filepath, imgName));

        OutputStream ou = response.getOutputStream();

        IOUtils.copy(in, ou);

        in.close();
        ou.flush();
        ou.close();
    }

}
