<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.DB" %>
<%@ page import="model.video" %>
<%@ page import="java.util.List" %>
<%
    DB db = new DB();
    String search = request.getParameter("search");

    List<video> video = db.search_videos(search);
    request.setAttribute("video", video);
%>
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
