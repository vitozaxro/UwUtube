package model;

import javax.persistence.*;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class DB {
    public EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("uwutube");
    public EntityManager entityManager = entityManagerFactory.createEntityManager();
    // more data about video
    // more video info (views, like, dislike)
    public ArrayList<video> get_video_vld(ArrayList<video> videos) {
        Query full_info = entityManager.createNamedQuery("full info");
        List<Object[]> video_info = full_info.getResultList();
        for (int i = 0; i < videos.size(); i++) {
            for (int o = 0; o < video_info.size(); o++) {
                int video_id = Integer.parseInt(video_info.get(o)[0].toString());
                if (video_id == videos.get(i).getId()) {
                    videos.get(i).getVideo_info().setViews(Integer.parseInt(video_info.get(o)[1].toString()));
                    videos.get(i).getVideo_info().setLikes(Integer.parseInt(video_info.get(o)[2].toString()));
                    videos.get(i).getVideo_info().setDislikes(Integer.parseInt(video_info.get(o)[3].toString()));
                }
            }
        }
        return videos;
    }
    // more video info by id (views, like, dislike)
    public video get_video_vld_by_id(video video) {
        Query full_info = entityManager.createNamedQuery("full info by id");
        full_info.setParameter(1, video.getId());
        Object[] video_info = (Object[]) full_info.getSingleResult();
        System.out.println();
        System.out.println(video_info[2]);
        System.out.println(video_info[3]);
        video.getVideo_info().setViews(Integer.parseInt(video_info[1].toString()));
        video.getVideo_info().setLikes(Integer.parseInt(video_info[2].toString()));
        video.getVideo_info().setDislikes(Integer.parseInt(video_info[3].toString()));
        return video;
    }
    // video topic by id
    public video video_topic_by_id(video video) {
        Query topic = entityManager.createNamedQuery("get topic by id");
        topic.setParameter(1, video.getId());
        ArrayList<topic> video_topic = (ArrayList<topic>) topic.getResultList();
        for (int o = 0; o < video_topic.size(); o++) {
            video.getTopic().add(video_topic.get(o));
        }
        return video;
    }

    // user
    public boolean SignUp(user user) {
        entityManager.getTransaction().begin();
        try {
            Query select = entityManager.createNamedQuery("get user by email");
            select.setParameter(1, user.getEmail());
            user error = (user) select.getSingleResult();
        } catch (NoResultException e) {
            entityManager.persist(user);
            entityManager.getTransaction().commit();
            return true;
        }
        return false;
    }
    public String LogIn(user user){
        try {
            Query select = entityManager.createNamedQuery("get user by email");
            select.setParameter(1, user.getEmail());
            user email_check = (user) select.getSingleResult();
        } catch (NoResultException e) {
            return "email error";
        }
        try {
            Query select = entityManager.createNamedQuery("log in");
            select.setParameter(1, user.getEmail());
            select.setParameter(2,user.getPassword());
            user error = (user) select.getSingleResult();
            return error.getId() + "";
        } catch (NoResultException e) {
            return "password error";
        }
    }
    public user user_by_id(int id) {
        entityManager.getTransaction().begin();
        Query select = entityManager.createNamedQuery("get user by id");
        select.setParameter(1, id);
        user user = (user) select.getSingleResult();
        entityManager.getTransaction().commit();
        return user;
    }

    // list
    public void delete_list(int id) {
        entityManager.getTransaction().begin();
        Query query = entityManager.createNamedQuery("delete list");
        query.setParameter(1, id);
        query.executeUpdate();
        entityManager.getTransaction().commit();
        entityManager.getTransaction().begin();
        Query list_video = entityManager.createNamedQuery("delete all video from list");
        list_video.setParameter(1, id);
        list_video.executeUpdate();
        entityManager.getTransaction().commit();
    }
    public int add_list(list list){
        entityManager.getTransaction().begin();
        entityManager.persist(list);
        entityManager.getTransaction().commit();
        entityManager.getTransaction().begin();
        Query check = entityManager.createNamedQuery("get max list id");
        int l = (int) check.getSingleResult();
        entityManager.getTransaction().commit();
        return l;
    }
    public list get_list_by_id(int id) {
        entityManager.getTransaction().begin();
        Query query = entityManager.createNamedQuery("get list by id");
        query.setParameter(1, id);
        list l = (list) query.getSingleResult();
        entityManager.getTransaction().commit();
        return l;
    }
    public ArrayList<list> get_list(int id){
        entityManager.getTransaction().begin();
        Query select = entityManager.createNamedQuery("get list");
        select.setParameter(1,id);
        ArrayList<list> list = (ArrayList<list>) select.getResultList();
        entityManager.getTransaction().commit();
        return list;
    }

    // subscriber
    public void delete_subscriber(int user_id, int channel_id) {
        entityManager.getTransaction().begin();
        Query query = entityManager.createNamedQuery("subscribtion delete");
        query.setParameter(1, user_id);
        query.setParameter(2, channel_id);
        query.executeUpdate();
        entityManager.getTransaction().commit();
    }
    public void add_subscriber(int user_id, int channel_id) {
        entityManager.getTransaction().begin();
        subscriber s = new subscriber();
        s.setSubscriber_id(user_id);
        s.setChannel_id(channel_id);
        entityManager.persist(s);
        entityManager.getTransaction().commit();
    }
    public boolean check_subscribtion(int user_id, int channel_id) {
        entityManager.getTransaction().begin();
        try {
            Query query = entityManager.createNamedQuery("subscribtion check");
            query.setParameter(1, user_id);
            query.setParameter(2, channel_id);
            subscriber s = (subscriber) query.getSingleResult();
            entityManager.getTransaction().commit();
            return true;
        } catch (NoResultException e) {
            entityManager.getTransaction().commit();
            return false;
        }
    }
    public ArrayList<user> get_all_user_subscriber(int user_id) {
        entityManager.getTransaction().begin();
        Query query = entityManager.createNamedQuery("get all user subscration");
        query.setParameter(1, user_id);
        ArrayList<subscriber> s = (ArrayList<subscriber>) query.getResultList();
        ArrayList<user> users = new ArrayList<>();
        for (int i = 0;i < s.size();i++) {
            Query user_query = entityManager.createNamedQuery("get user by id");
            user_query.setParameter(1, s.get(i).getChannel_id());
            user u = (user) user_query.getSingleResult();
            users.add(u);
        }

        entityManager.getTransaction().commit();
        return users;
    }

    // comment
    public List<Comment_answer> get_comments(video video){
        entityManager.getTransaction().begin();
        Query query = entityManager.createNamedQuery("get comments by id");
        query.setParameter(1, video.getId());
        ArrayList<Comments> comments = (ArrayList<Comments>) query.getResultList();

        ArrayList<Comments> main = new ArrayList<>();
        ArrayList<Comments> reply = new ArrayList<>();

        ArrayList<Comment_answer> comment_answers = new ArrayList<>();

        for (int i = 0; i < comments.size();i++) {
            if (comments.get(i).getType().equals("reply")) {
                reply.add(comments.get(i));
            } else
                main.add(comments.get(i));
        }
        for (int i = 0;i < main.size();i++) {
            Comment_answer ca = new Comment_answer();
            ca.setComment(main.get(i));
            for (int o = 0;o < reply.size();o++) {
                if (reply.get(o).getComment_id() == ca.getComment().getId())
                    ca.getAnswers().add(reply.get(o));
            }
            comment_answers.add(ca);
        }



        entityManager.getTransaction().commit();
        return comment_answers;
    }
    public void newComment(Comments comments){
        entityManager.getTransaction().begin();
        entityManager.persist(comments);
        entityManager.getTransaction().commit();
    }

    // list_videos
    public ArrayList<video> get_list_videos(int playlist_id){
        entityManager.getTransaction().begin();
        System.out.println(playlist_id);
        Query select = entityManager.createNamedQuery("get list videos");
        select.setParameter(1,playlist_id);
        ArrayList<list_videos> list_videos = (ArrayList<list_videos>) select.getResultList();
        ArrayList<video> videos = new ArrayList<video>();
        entityManager.getTransaction().commit();
        for (int i = 0; i < list_videos.size(); i++) {
            video v = get_video_by_id(list_videos.get(i).getVideo_id());
            videos.add(v);
        }
        return videos;
    }
    public void add_list_video(int video_id, int playlist_id) {
        entityManager.getTransaction().begin();
        list_videos lv = new list_videos();
        lv.setVideo_id(video_id);
        lv.setPlaylist_id(playlist_id);
        entityManager.persist(lv);
        entityManager.getTransaction().commit();

    }
    public void remove_video_from_list(int video_id, int playlist_id) {
        entityManager.getTransaction().begin();
        Query query = entityManager.createNamedQuery("delete video from list");
        query.setParameter(1, video_id);
        query.setParameter(2, playlist_id);
        query.executeUpdate();
        entityManager.getTransaction().commit();
    }
    public boolean check_list_video(int list_id,int video_id) {
        entityManager.getTransaction().begin();
        Query query = entityManager.createNamedQuery("check list and video");
        query.setParameter(1, list_id);
        query.setParameter(2, video_id);
        try {
            list_videos l = (list_videos) query.getSingleResult();
            entityManager.getTransaction().commit();
            return true;
        } catch (NoResultException e) {
            entityManager.getTransaction().commit();
            return false;
        }
    }

    // notification
    public ArrayList<notification> generate_notifications(video video, int id) {
        entityManager.getTransaction().begin();
        Query query = entityManager.createNamedQuery("get all subscribtion");
        query.setParameter(1, video.getUser_id());
        ArrayList<subscriber> s = (ArrayList<subscriber>) query.getResultList();
        ArrayList<notification> notifications = new ArrayList<>();
        for (int i = 0;i < s.size();i++) {
            notification n = new notification();
            n.setUser_id(s.get(i).getSubscriber_id());
            n.setVideo_id(id);
            notifications.add(n);
        }
        entityManager.getTransaction().commit();
        return notifications;
    }

    public void add_notifications(notification n) {
        entityManager.getTransaction().begin();
        entityManager.persist(n);
        entityManager.getTransaction().commit();
    }

    // video
    // upload video and return id
    public int UploadVideo(video video){
        entityManager.getTransaction().begin();
        Query video_max_id_query = entityManager.createNamedQuery("get max id");
        int video_max_id = (int) video_max_id_query.getSingleResult();
        video.setFile_name("Uwutube-Content/" + video_max_id + ".mp4");
        entityManager.persist(video);
        entityManager.getTransaction().commit();
        return video_max_id;
    }
    // search video by name
    public ArrayList<video> search_videos(String name){
        entityManager.getTransaction().begin();
        Query query = entityManager.createNamedQuery("search videos");
        query.setParameter(1,name);
        ArrayList<video> searchvideos = (ArrayList<video>) query.getResultList();
        entityManager.getTransaction().commit();
        return searchvideos;
    }
    // get video by id
    public video get_video_by_id(int id) {
        entityManager.getTransaction().begin();
        Query query = entityManager.createNamedQuery("get video by id");
        query.setParameter(1, id);
        video video = (video) query.getSingleResult();
        video_topic_by_id(video);
        get_video_vld_by_id(video);
        entityManager.getTransaction().commit();
        return video;
    }

    public ArrayList<video> get_history(int user_id) {
        entityManager.getTransaction().begin();
        System.out.println("that new function");
        Query select = entityManager.createNamedQuery("get history by user id");
        select.setParameter(1, user_id);
        ArrayList<action> action = (ArrayList<action>) select.getResultList();
        ArrayList<video> videos = new ArrayList<video>();
        entityManager.getTransaction().commit();
        System.out.println("that action list" + action);

        for (int i = 0; i < action.size(); i++) {
            video v = get_video_by_id(action.get(i).getVideo_id());
            videos.add(v);
        }
        return videos;
    }
    public ArrayList<video> get_10_videos() {
        entityManager.getTransaction().begin();
        Query query = entityManager.createNamedQuery("get all videos");
        ArrayList<video> videos = (ArrayList<video>) query.setMaxResults(10).getResultList();
        get_video_vld(videos);
        entityManager.getTransaction().commit();
        return videos;
    }
    public ArrayList<video> get_load_more_video(int offset) {
        entityManager.getTransaction().begin();
        Query query = entityManager.createNamedQuery("get all videos");
        query.setFirstResult(offset);
        query.setMaxResults(12);
        ArrayList<video> videos = (ArrayList<video>) query.getResultList();
        get_video_vld(videos);
        entityManager.getTransaction().commit();
        return videos;
    }
    public ArrayList<video> get_newest_videos() {
        entityManager.getTransaction().begin();
        Query query = entityManager.createNamedQuery("get newest video");
        query.setMaxResults(16);
        ArrayList<video> videos = (ArrayList<video>) query.getResultList();
        get_video_vld(videos);
        entityManager.getTransaction().commit();
        return videos;
    }
    public ArrayList<video> get_video_by_topic(String topic) {
        entityManager.getTransaction().begin();
        Query query = entityManager.createNamedQuery("get topic by topic");
        query.setParameter(1, topic);
        ArrayList<topic> topics = (ArrayList<topic>) query.getResultList();
        ArrayList<video> videos = new ArrayList<>();
        entityManager.getTransaction().commit();
        for (int i = 0; i < topics.size(); i++) {
            video v = get_video_by_id(topics.get(i).getVideo_id());
            videos.add(v);
        }
        return videos;
    }
    public ArrayList<video> get_videos_by_user_id(int user_id) {
        entityManager.getTransaction().begin();
        Query query = entityManager.createNamedQuery("get video by user id");
        query.setParameter(1, user_id);
        ArrayList<video> videos = (ArrayList<video>) query.getResultList();
        get_video_vld(videos);
        entityManager.getTransaction().commit();
        return videos;
    }

    // action
    public void set_reaction(int user_id, int video_id, String reaction) {
        entityManager.getTransaction().begin();
        Query query = entityManager.createNamedQuery("set reaction");
        query.setParameter(1, reaction);
        query.setParameter(2, user_id);
        query.setParameter(3, video_id);
        query.executeUpdate();
        entityManager.getTransaction().commit();
    }
    // views add and raise
    public void views_counter(int user_id, int video_id){
        entityManager.getTransaction().begin();
        try {
            Query select = entityManager.createNamedQuery("get action by user id");
            select.setParameter(1, user_id);
            select.setParameter(2, video_id);
            action action = (model.action) select.getSingleResult();

            Query query = entityManager.createNamedQuery("views counter");
            query.setParameter(1, user_id);
            query.setParameter(2, new Timestamp(System.currentTimeMillis()));
            query.setParameter(3, video_id);
            query.executeUpdate();
            entityManager.getTransaction().commit();
        } catch (NoResultException e){
            action action = new action();
            action.setUser_id(user_id);
            action.setVideo_id(video_id);
            action.setAction("none");
            action.setDate(new Timestamp(System.currentTimeMillis()));
            action.setCount_views(1);

            entityManager.persist(action);
            entityManager.getTransaction().commit();
        }
    }
    public action check_action(int user_id, int video_id) {
        entityManager.getTransaction().begin();
        Query query = entityManager.createNamedQuery("get action by user id");
        query.setParameter(1, user_id);
        query.setParameter(2, video_id);
        action a = (action) query.getSingleResult();
        entityManager.getTransaction().commit();
        return a;
    }

    // topic
    public void add_topic(topic t) {
    entityManager.getTransaction().begin();
    entityManager.persist(t);
    entityManager.getTransaction().commit();
}

    // counting and others
    public int user_video_count(int user_id) {
        entityManager.getTransaction().begin();
        Query query = entityManager.createNamedQuery("get all subscribtion");
        query.setParameter(1, user_id);
        ArrayList<subscriber> s = (ArrayList<subscriber>) query.getResultList();
        entityManager.getTransaction().commit();
        int count = s.size();
        return count;
    }
    public int video_count() {
        entityManager.getTransaction().begin();
        Query query = entityManager.createNamedQuery("get all videos");
        int count = query.getResultList().size();
        entityManager.getTransaction().commit();
        return count;
    }
    public int sub_video_count(int user_id) {
        String channel_id = get_channel_id_string(user_id);
        int count = 0;
        if (channel_id != "") {
            entityManager.getTransaction().begin();
            String string_query = String.format("SELECT v from video v where v.user_id in (%s)", channel_id);
            Query query = entityManager.createQuery(string_query);
            count = query.getResultList().size();
            entityManager.getTransaction().commit();
        }
        return count;
    }
    public String get_channel_id_string(int user_id) {
        ArrayList<user> channels = get_all_user_subscriber(user_id);
        String channel_id = "";
        for (int i = 0; i < channels.size();i++) {
            if ((i + 1) != channels.size()) {
                channel_id = channel_id + channels.get(i).getId() + ",";
            } else {
                channel_id = channel_id + channels.get(i).getId();
            }
        }
        return channel_id;
    }
    public ArrayList<video> get_notification_video(int user_id) {
        entityManager.getTransaction().begin();
        Query notification_query = entityManager.createNamedQuery("get user notifications");
        notification_query.setParameter(1, user_id);
        ArrayList<notification> notifications = (ArrayList<notification>) notification_query.getResultList();
        ArrayList<video> videos = new ArrayList<>();
        entityManager.getTransaction().commit();
        for (int i = 0;i < notifications.size();i++) {
            video v = get_video_by_id(notifications.get(i).getVideo_id());
            videos.add(v);
        }
        return videos;
    }

    public ArrayList<video> get_subscriber_video(int user_id, int offset) {
        String channel_id = get_channel_id_string(user_id);
        ArrayList<video> videos = new ArrayList<>();
        if (channel_id != "") {
            entityManager.getTransaction().begin();
            String string_query = String.format("SELECT v from video v where v.user_id in (%s)", channel_id);
            Query query = entityManager.createQuery(string_query);
            query.setFirstResult(offset);
            query.setMaxResults(12);
            videos = (ArrayList<video>) query.getResultList();
            entityManager.getTransaction().commit();
        }
        return videos;
    }
}