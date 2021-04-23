<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.video" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.DB" %>
<%
    DB db = new DB();
    int user_id = Integer.parseInt(request.getParameter("user_id"));
    ArrayList<video> history = db.get_history(user_id);
    request.setAttribute("history", history);
%>
<div class="head">
    <h1>History</h1>
</div>
<c:forEach items="${history}" var="h">
    <div class="row video-open" data-video-open="${h.getId()}">
        <div class="left-row">
            <video preload="metadata" loop muted src="${h.getFile_name()}" class="video">
                <source src="${h.getFile_name()}" type="video/mp4">
            </video>
        </div>
        <div class="right-row">
            <p class="name">${h.getName()}</p>
            <p class="author-name">${h.getUser_name()}</p>
        </div>
    </div>
</c:forEach>