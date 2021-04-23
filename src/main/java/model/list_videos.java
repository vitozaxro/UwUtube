package model;

import javax.persistence.*;

@Entity
@NamedQueries({
        @NamedQuery(name = "get list videos", query ="select l from list_videos l where l.playlist_id = ?1"),
        @NamedQuery(name = "check list and video", query ="select l from list_videos l where l.playlist_id = ?1 and l.video_id = ?2"),
        @NamedQuery(name = "delete video from list", query ="delete from list_videos l where l.video_id = ?1 and l.playlist_id = ?2"),
        @NamedQuery(name = "delete all video from list", query ="delete from list_videos l where l.playlist_id = ?1")
})
@Table(name = "list_videos")
public class list_videos {
    @Id
    private int id;
    private int video_id;
    private int playlist_id;


    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getVideo_id() { return video_id; }
    public void setVideo_id(int video_id) { this.video_id = video_id; }

    public int getPlaylist_id() { return playlist_id; }
    public void setPlaylist_id(int playlist_id) { this.playlist_id = playlist_id; }

    @Override
    public String toString() {
        return "list_videos{" +
                "id=" + id +
                ", video_id=" + video_id +
                ", playlist_id=" + playlist_id +
                '}';
    }
}