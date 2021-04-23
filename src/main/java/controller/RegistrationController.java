package controller;
import javax.persistence.NoResultException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.*;
import com.sun.net.httpserver.HttpServer;
import model.DB;
import model.user;
import org.hibernate.HibernateException;
import java.util.regex.Pattern;

public class RegistrationController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        resp.setContentType("text/html");
        DB db = new DB();
        PrintWriter out = resp.getWriter();

        user user = new user();
        user.setUsername( req.getParameter("username"));
        user.setEmail(req.getParameter("email"));
        user.setPassword(req.getParameter("password"));

        String password_regex = "(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=\\S+$).{8,}";
        boolean validation = req.getParameter("password").matches(password_regex);
        if (validation) {
            if (db.SignUp(user)){
                out.print("successful");
            } else {
                out.print("email error");
            }
        } else {
            out.print("password is not valid");
        }
    }
}

