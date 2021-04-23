package model;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
@Entity
@NamedQueries({
        @NamedQuery(name = "full info", query = "select video_id, sum(count_views) as views, sum(case when action = 'like' then 1 else 0 end ) as likes, sum(case when action = 'dislike' then 1 else 0 end) as dislikes from action group by video_id"),
        @NamedQuery(name = "full info by id", query = "select video_id, coalesce(sum(count_views), 0) as views, coalesce(sum(case when action = 'like' then 1 else 0 end ), 0) as likes, coalesce(sum(case when action = 'dislike' then 1 else 0 end), 0) as dislikes from action where video_id = ?1")
})
class video_info {
    @Id
    private int video_id;
    private int views;
    private int likes;
    private int dislikes;

    public int getVideo_id() { return video_id; }
    public void setVideo_id(int video_id) { this.video_id = video_id; }

    public int getViews() { return views; }
    public void setViews(int views) { this.views = views; }

    public int getLikes() { return likes; }
    public void setLikes(int likes) { this.likes = likes; }

    public int getDislikes() { return dislikes; }
    public void setDislikes(int dislikes) { this.dislikes = dislikes; }

    @Override
    public String toString() {
        return "video_info{" +
                "video_id=" + video_id +
                ", views=" + views +
                ", likes=" + likes +
                ", dislikes=" + dislikes +
                '}';
    }

}
