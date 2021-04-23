package model;
import javax.persistence.*;

import java.util.ArrayList;
import java.util.Date;

@Entity
@Table(name = "videos")
@NamedQueries({
        @NamedQuery(name = "get all videos", query = "SELECT v from video v"),
        @NamedQuery(name = "get max id", query = "SELECT max(v.id) from video v"),
        @NamedQuery(name = "get video by id", query = "SELECT v from video v where v.id = ?1"),
        @NamedQuery(name = "get video by user id", query = "SELECT v from video v where v.user_id = ?1"),
        @NamedQuery(name = "search videos", query = "SELECT v from video v where v.name like CONCAT('%',?1,'%')"),
        @NamedQuery(name = "get newest video", query = "SELECT v from video v order by v.date desc")
})

public class video {
    @Id
    private int id;
    private int user_id;
    private String user_name;
    private String name;
    private String description;
    private Date date;
    private String file_name;

    @Transient
    private video_info video_info = new video_info();
    @Transient
    private ArrayList<topic> topic = new ArrayList<>();

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUser_id() { return user_id; }
    public void setUser_id(int user_id) { this.user_id = user_id; }

    public String getUser_name() { return user_name; }
    public void setUser_name(String user_name) { this.user_name = user_name; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public Date getDate() { return date; }
    public void setDate(Date date) { this.date = date; }

    public String getFile_name() { return file_name; }
    public void setFile_name(String file_name) { this.file_name = file_name; }

    public model.video_info getVideo_info() { return video_info; }
    public void setVideo_info(model.video_info video_info) { this.video_info = video_info; }

    public ArrayList<model.topic> getTopic() { return topic; }
    public void setTopic(ArrayList<model.topic> topic) { this.topic = topic; }

    public int getViews() { return this.video_info.getViews(); }
    public int getlike() {
        return this.video_info.getLikes();
    }
    public int getdislike() {
        return this.video_info.getDislikes();
    }

    @Override
    public String toString() {
        return "video{" +
                "id=" + id +
                ", user_id=" + user_id +
                ", user_name='" + user_name + '\'' +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", date='" + date + '\'' +
                ", file_name='" + file_name + '\'' +
                ", video_info=" + video_info +
                ", topic=" + topic +
                '}';
    }
}
