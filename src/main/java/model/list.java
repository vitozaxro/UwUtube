package model;

import javax.persistence.*;

@Entity
@NamedQueries({
        @NamedQuery(name = "get list", query ="select l from list l where l.user_id = ?1"),
        @NamedQuery(name = "get list by id", query ="select l from list l where l.id = ?1"),
        @NamedQuery(name = "check list", query ="select l from list l where l.name = ?1 and l.user_id = ?2"),
        @NamedQuery(name = "delete list", query ="delete from list l where l.id = ?1"),
        @NamedQuery(name = "get max list id", query = "SELECT max(l.id) from list l")
})
@Table(name = "lists")
public class list {
    @Id
    private int id;
    private int user_id;
    private String name;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUser_id() { return user_id; }
    public void setUser_id(int user_id) { this.user_id = user_id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    @Override
    public String toString() {
        return "list{" +
                "id=" + id +
                ", user_id=" + user_id +
                ", name='" + name + '\'' +
                '}';
    }
}