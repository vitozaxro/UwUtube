package model;

import java.util.ArrayList;
import java.util.Date;

public class Comment_answer {
    private Comments comment = new Comments();
    private ArrayList<Comments> answers = new ArrayList<>();

    public Comments getComment() { return comment; }
    public void setComment(Comments comment) { this.comment = comment; }

    public ArrayList<Comments> getAnswers() { return answers; }
    public void setAnswers(ArrayList<Comments> answers) { this.answers = answers; }

    public int getMainId() {
        return comment.getId();
    }
    public int getMainUser_id() {
        return comment.getUser_id();
    }
    public int getMainVideo_id() {
        return comment.getVideo_id();
    }
    public int getMainComment_id() { return comment.getComment_id(); }
    public String getMainText() { return comment.getText(); }
    public Date getMainDate() { return comment.getDate(); }
    public String getMainuser_name() { return comment.getUser_name(); }

    @Override
    public String toString() {
        return "Comment_answer{" +
                "comment=" + comment +
                ", answers=" + answers +
                '}';
    }
}
