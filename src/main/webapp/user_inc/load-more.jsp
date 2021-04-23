<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.DB" %>
<%@ page import="model.video" %>
<%@ page import="java.util.List" %>
<%
    int offset;
    if (request.getParameter("offset") != null) {
        offset = Integer.parseInt(request.getParameter("offset")) * 12;
    } else {
        offset = 0;
    }
    DB db = new DB();
    List<video> video = db.get_load_more_video(offset);
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
