package controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;

import model.*;

@WebServlet(name = "UploadController", urlPatterns = {"/UploadController"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 1, maxFileSize = 1024 * 1024 * 100, maxRequestSize = 1024 * 1024 * 100)
public class UploadController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        video video = new video();
        DB db = new DB();
        HttpSession session = req.getSession();

        video.setName(req.getParameter("name"));
        video.setDescription(req.getParameter("description"));
        video.setUser_id((Integer) session.getAttribute("ID"));
        video.setDate(new Timestamp(System.currentTimeMillis()));
        video.setUser_name((String) session.getAttribute("USERNAME"));
        int value = db.UploadVideo(video);

        int i = 0;
        boolean isornot = false;
        while (!isornot) {
            DB topic_db = new DB();
            if (req.getParameter("tags-" + i) != null) {
                String topic = req.getParameter("tags-" + i);
                topic t = new topic();
                t.setVideo_id(value);
                t.setTopic(topic);
                topic_db.add_topic(t);
                i++;
            } else {
                isornot = true;
            }
            if (i == 6) {
                isornot = true;
            }
        }

        ArrayList<notification> n = db.generate_notifications(video, value);
        for (int o = 0;o < n.size();o++) {
            DB notification_db = new DB();
            notification_db.add_notifications(n.get(o));
        }

        if(value!=0){
            String fileName = "" + value;
            String s = System.getenv("UwUtube_Library");
            Part filepart = req.getPart("file");
            filepart.write( s + "\\" + fileName + ".mp4");
        }
        String redirectURL = "http://localhost:8080/";
        resp.sendRedirect(redirectURL);
    }
}
