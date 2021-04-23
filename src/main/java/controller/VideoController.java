package controller;
import model.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;

public class VideoController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        DB db = new DB();
        HttpSession session = req.getSession();

        PrintWriter out = resp.getWriter();
        String function_name = req.getParameter("function_name");

        if (function_name.equals("set dislike")) {
            int user_id = Integer.parseInt(req.getParameter("user_id"));
            int video_id = Integer.parseInt(req.getParameter("video_id"));
            db.set_reaction(user_id, video_id, "dislike");
        } else if (function_name.equals("set like")) {
            int user_id = Integer.parseInt(req.getParameter("user_id"));
            int video_id = Integer.parseInt(req.getParameter("video_id"));
            db.set_reaction(user_id, video_id, "like");
        } else if (function_name.equals("remove reaction")) {
            int user_id = Integer.parseInt(req.getParameter("user_id"));
            int video_id = Integer.parseInt(req.getParameter("video_id"));
            db.set_reaction(user_id, video_id, "none");
        } else if (function_name.equals("remove subscriber")) {
            int user_id = Integer.parseInt(req.getParameter("user_id"));
            int channel_id = Integer.parseInt(req.getParameter("channel_id"));
            db.delete_subscriber(user_id, channel_id);
        } else if (function_name.equals("add subscriber")) {
            int user_id = Integer.parseInt(req.getParameter("user_id"));
            int channel_id = Integer.parseInt(req.getParameter("channel_id"));
            db.add_subscriber(user_id, channel_id);
            user u = db.user_by_id(channel_id);
            out.print("<div class='row user-page-open' id='sub-list-" + u.getId() + "' data-channel-id='" + u.getId() + "'>" +
                            "<div class='icon-div'>" +
                                u.getUsername().substring(0,1).toUpperCase() +
                            "</div>" +
                            "<p>" + u.getUsername() + "</p>" +
                        "</div>");
        } else if (function_name.equals("add video to list")) {
            int video_id = Integer.parseInt(req.getParameter("video_id"));
            int playlist_id = Integer.parseInt(req.getParameter("playlist_id"));
            db.add_list_video(video_id, playlist_id);
        } else if (function_name.equals("remove video form list")) {
            int video_id = Integer.parseInt(req.getParameter("video_id"));
            int playlist_id = Integer.parseInt(req.getParameter("playlist_id"));
            db.remove_video_from_list(video_id, playlist_id);
        } else if(function_name.equals("add reply comment")) {
            Comments comments = new Comments();
            comments.setUser_id((Integer) session.getAttribute("ID"));
            comments.setVideo_id(Integer.parseInt(req.getParameter("video_id")));
            comments.setComment_id(Integer.parseInt(req.getParameter("comment_id")));
            comments.setUser_name((String) session.getAttribute("USERNAME"));
            comments.setDate(new Timestamp(System.currentTimeMillis()));
            comments.setText(req.getParameter("text"));
            comments.setType(req.getParameter("type"));
            db.newComment(comments);
            out.print("<div class='each-answer'>"
                            + "<p class='answer-name'>" + comments.getUser_name() + " " + comments.getDate() + "</p>"
                            + "<p class='answer-text'>" + comments.getText() + "</p>"
                            + "<button class='reply-btn' data-reply='" + comments.getUser_name() + "'>reply</button>"
                    + "</div>");
        } else if(function_name.equals("add main comment")) {
            Comments comments = new Comments();
            comments.setUser_id((Integer) session.getAttribute("ID"));
            comments.setVideo_id(Integer.parseInt(req.getParameter("video_id")));
            comments.setUser_name((String) session.getAttribute("USERNAME"));
            comments.setDate(new Timestamp(System.currentTimeMillis()));
            comments.setText(req.getParameter("text"));
            comments.setType(req.getParameter("type"));
            db.newComment(comments);
            int number = Integer.parseInt(req.getParameter("number"));
            out.print("<div class='each-comment'>" +
                        "<p class='name'>" + comments.getUser_name() + " " + comments.getDate() + "</p>" +
                        "<p class='text'>" + comments.getText() + "</p>" +
                        "<button data-onclick='t|#answer-" + number + "|comment-display' class='react answer-btn'>answers</button>" +
                        "<button class='reply-btn' data-reply='" + comments.getUser_name() + "'>reply</button>" +
                        "<div id='answer-" + number + "' class='answer'>" +
                            "<div class='reply-input'>" +
                                "<input type='text'>" +
                                "<button class='reply-submit-btn'>submit</button>" +
                            "</div>" +
                        "</div>" +
                      "</div>");
        }

    }
}