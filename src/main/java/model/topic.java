package model;

import javax.persistence.*;

@Entity
@Table(name = "topic")
@NamedQueries({
        @NamedQuery(name = "get all topic", query = "SELECT t from topic t"),
        @NamedQuery(name = "get topic by id", query = "SELECT t from topic t where t.video_id = ?1"),
        @NamedQuery(name = "get topic by topic", query = "SELECT t from topic t where t.topic like concat('%',?1,'%')")
})
public class topic {
    @Id
    int id;
    int video_id;
    String topic;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getVideo_id() { return video_id; }
    public void setVideo_id(int video_id) { this.video_id = video_id; }

    public String getTopic() { return topic; }
    public void setTopic(String topic) { this.topic = topic; }

    @Override
    public String toString() {
        return "topic{" +
                "id=" + id +
                ", video_id=" + video_id +
                ", topic='" + topic + '\'' +
                '}';
    }
}
