<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.DB" %>
<%@ page import="model.video" %>
<%@ page import="java.util.List" %>
<%
    DB db = new DB();
    String tag_name = request.getParameter("tag_name");
    List<video> video = db.get_video_by_topic(tag_name);
    request.setAttribute("video", video);
%>
<div class="tag_name">
    <h1>#<%= tag_name %></h1>
</div>
<div class="fifteen-video-row">
    <c:forEach items="${video}" var="v">
        <div class="each-video-div video-open" data-video-open="${v.getId()}">
            <div class="upper">
                <video preload="metadata" loop muted src="${v.getFile_name()}" class="video">
                    <source src="${v.getFile_name()}" type="video/mp4">
                </video>
            </div>
            <div class="lower">
                <p class="name">${v.getName()}</p>
                <p class="views">Views: ${v.getViews()}</p>
            </div>
        </div>
    </c:forEach>
</div>
