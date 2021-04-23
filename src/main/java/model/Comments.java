package model;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "comments")
@NamedQueries({
        @NamedQuery(name = "get comments by id", query = "select c from Comments c where c.video_id = ?1")

})
public class Comments {
    @Id
    private int id;
    private int user_id;
    private int video_id;
    private int comment_id;
    private String user_name;
    private Date date;
    private String text;
    private String type;


    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public int getUser_id() {
        return user_id;
    }
    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public int getVideo_id() {
        return video_id;
    }
    public void setVideo_id(int video_id) {
        this.video_id = video_id;
    }

    public int getComment_id() { return comment_id; }
    public void setComment_id(int comment_id) { this.comment_id = comment_id; }

    public String getText() { return text; }
    public void setText(String text) {
        this.text = text;
    }

    public Date getDate() { return date; }
    public void setDate(Date date) { this.date = date; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public String getUser_name() { return user_name; }
    public void setUser_name(String user_name) { this.user_name = user_name; }

    @Override
    public String toString() {
        return "Comments{" +
                "id=" + id +
                ", user_id=" + user_id +
                ", video_id=" + video_id +
                ", comment_id=" + comment_id +
                ", date=" + date +
                ", text='" + text + '\'' +
                ", type='" + type + '\'' +
                '}';
    }
}
