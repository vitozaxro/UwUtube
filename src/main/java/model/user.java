package model;

import javax.persistence.*;

@Entity
@Table(name = "Users")
@NamedQueries({
        @NamedQuery(name = "get user by email", query = "SELECT u From user u where u.email = ?1 "),
        @NamedQuery(name = "log in", query = "SELECT u From user u where u.email = ?1 and u.password = ?2"),
        @NamedQuery(name = "get user by id", query = "SELECT u From user u where u.id = ?1")
})

public class user {
    @Id
    protected int id;
    protected String username;
    protected String email;
    protected String password;


    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    @Override
    public String toString() {
        return "user{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", email='" + email + '\'' +
                ", password='" + password + '\'' +
                '}';
    }
}
