<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.DB" %>
<%@ page import="model.video" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.list" %>
<%
    int list_id = Integer.parseInt(request.getParameter("list_id"));
    DB db = new DB();
    list l = db.get_list_by_id(list_id);
    ArrayList<video> video = db.get_list_videos(list_id);
    request.setAttribute("video", video);
%>
<div class="head">
    <h1><%= l.getName() %></h1>
    <i class="fa fa-trash remove-list" data-id="<%= list_id %>" aria-hidden="true"></i>
</div>
<c:forEach items="${video}" var="v">
    <div class="row video-open" data-video-open="${v.getId()}">
        <div class="left-row">
            <video preload="metadata" loop muted src="${v.getFile_name()}" class="video">
                <source src="${v.getFile_name()}" type="video/mp4">
            </video>
        </div>
        <div class="right-row">
            <p class="name">${v.getName()}</p>
            <p class="author-name">${v.getUser_name()}</p>
        </div>
    </div>
</c:forEach>
