package model;

import javax.persistence.*;

@Entity
@Table(name = "subscribers")
@NamedQueries({
        @NamedQuery(name = "get all subscribtion", query ="select s from subscriber s where s.channel_id = ?1"),
        @NamedQuery(name = "get all user subscration", query ="select s from subscriber s where s.subscriber_id = ?1"),
        @NamedQuery(name = "subscribtion check", query ="select s from subscriber s where s.subscriber_id = ?1 and s.channel_id = ?2"),
        @NamedQuery(name = "subscribtion delete", query ="delete from subscriber s where s.subscriber_id = ?1 and s.channel_id = ?2")
})
public class subscriber {
    @Id
    private int id;
    private int subscriber_id;
    private int channel_id;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getSubscriber_id() { return subscriber_id; }
    public void setSubscriber_id(int subscriber_id) { this.subscriber_id = subscriber_id; }

    public int getChannel_id() { return channel_id; }
    public void setChannel_id(int channel_id) { this.channel_id = channel_id; }

    @Override
    public String toString() {
        return "subscriber{" +
                "id=" + id +
                ", subscriber_id=" + subscriber_id +
                ", channel_id=" + channel_id +
                '}';
    }
}
