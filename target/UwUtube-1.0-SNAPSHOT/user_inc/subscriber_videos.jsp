<%@ page import="model.video" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.DB" %>
<%
    DB db = new DB();
    int offset;
    if (request.getParameter("offset") != null) {
        offset = Integer.parseInt(request.getParameter("offset")) * 12;
    } else {
        offset = 0;
    }
    int user_id = (int) session.getAttribute("ID");
    ArrayList<video> video = db.get_subscriber_video(user_id, offset);
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
