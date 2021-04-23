package controller;

import model.DB;
import model.user;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

public class LoginController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");

        HttpSession session = req.getSession();
        PrintWriter out = resp.getWriter();
        DB db = new DB();

        user user = new user();

        user.setEmail(req.getParameter("email"));
        user.setPassword(req.getParameter("password"));

        String result = db.LogIn(user);
        if (result.equals("email error")) {
            out.print("email error");
        } else if (result.equals("password error")) {
            out.print("password error");
        } else {
            session.setAttribute("ID", Integer.parseInt(result));
            user u = db.user_by_id((Integer) session.getAttribute("ID"));
            session.setAttribute("USERNAME", u.getUsername());
            out.print("successful");
        }
//       that how to kill, session session.invalidate();
    }
}
