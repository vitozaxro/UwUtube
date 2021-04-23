package model;

import javax.persistence.*;

@Entity
@NamedQueries({
        @NamedQuery(name = "get user notifications", query ="SELECT n from notification n where n.user_id = ?1"),
        @NamedQuery(name = "delete user notification", query ="delete from notification n where n.user_id = ?1")
})
@Table(name = "notification")
public class notification {
    @Id
    private int id;
    private int user_id;
    private int video_id;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUser_id() { return user_id; }
    public void setUser_id(int user_id) { this.user_id = user_id; }

    public int getVideo_id() { return video_id; }
    public void setVideo_id(int video_id) { this.video_id = video_id; }

    @Override
    public String toString() {
        return "notification{" +
                "id=" + id +
                ", user_id=" + user_id +
                ", video_id=" + video_id +
                '}';
    }
}
