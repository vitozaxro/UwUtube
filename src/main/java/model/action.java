package model;

import javax.persistence.*;
import java.sql.Timestamp;
import java.util.Date;


@Entity
@Table(name = "action")
@NamedQueries({
        @NamedQuery(name = "views counter", query = "update action a set a.count_views = a.count_views + 1, a.date = ?2 where a.user_id = ?1 and a.video_id = ?3"),
        @NamedQuery(name = "get action by user id", query = "SELECT a from action a where a.user_id = ?1 and a.video_id = ?2"),
        @NamedQuery(name = "get history by user id", query = "select a FROM action a where a.user_id = ?1 order by a.date desc"),
        @NamedQuery(name = "set reaction", query = "UPDATE action a set a.action = ?1 where a.user_id = ?2 and a.video_id = ?3")
})
public class action {
    @Id
    private int id;
    private int user_id;
    private int video_id;
    private String action;
    private Date date;
    private int count_views;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUser_id() { return user_id; }
    public void setUser_id(int user_id) { this.user_id = user_id; }

    public int getVideo_id() { return video_id; }
    public void setVideo_id(int video_id) { this.video_id = video_id; }

    public String getAction() { return action; }
    public void setAction(String action) { this.action = action; }

    public Date getDate() { return date; }
    public void setDate(Timestamp date) { this.date = date; }

    public int getCount_views() { return count_views; }
    public void setCount_views(int count_views) { this.count_views = count_views; }

    @Override
    public String toString() {
        return "action{" +
                "id=" + id +
                ", user_id=" + user_id +
                ", video_id=" + video_id +
                ", action='" + action + '\'' +
                ", date=" + date +
                ", count_views=" + count_views +
                '}';
    }
}
