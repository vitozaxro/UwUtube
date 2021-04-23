<%@ page import="model.video" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.DB" %>
<%@ page import="model.user" %>
<%
    int id = 1;
    if (session.getAttribute("ID") != null) {
        id = (int) session.getAttribute("ID");
    }
    DB db = new DB();
    int user_id = Integer.parseInt(request.getParameter("user_id"));
    user user = db.user_by_id(user_id);
    int sub = db.user_video_count(user_id);
    ArrayList<video> video = db.get_videos_by_user_id(user_id);
    request.setAttribute("video", video);
%>
<div class="user_head">
    <div class="left-user-head">
        <p class="one-letter">
            <%= user.getUsername().substring(0,1).toUpperCase() %>
        </p>
        <div>
            <p class="name">
                <%= user.getUsername() %>
            </p>
            <p class="subscriber">
                <%= sub %>
            </p>
        </div>
    </div>
    <div class="right-user-head">
        <%
            if (id != user_id) {
                boolean check = db.check_subscribtion(id, user_id);
                if (check != false) {
        %>
                    <button style="background: #6b6260;" data-sub="subscribed" data-channel-id="<%= user_id %>" class="subscriber-btn subscriber">subscribed</button>
        <%      } else { %>
                    <button style="background: #ff592e;" data-sub="subscribe" data-channel-id="<%= user_id %>" title="You must login to use those function" class="subscriber-btn subscriber tooltip">subscribe</button>
        <%
                }
           }
        %>

    </div>
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
