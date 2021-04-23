<%@ page import="java.util.List" %>
<%@ page import="model.*" %>
<%@ page import="java.util.Objects" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    DB db = new DB();
    int id = Integer.parseInt(request.getParameter("id"));
    video main_video = db.get_video_by_id(id);
    int user_id = 1;

    if (session.getAttribute("ID")!=null){
        user_id = (int) session.getAttribute("ID");
    }
    db.views_counter(user_id, id);

    List<topic> tags = main_video.getTopic();
    request.setAttribute("tags", tags);

    List<Comment_answer> comments = db.get_comments(main_video);
    request.setAttribute("comments_answers", comments);
%>
<div class="left-each-video" id="video-div">
    <div class="video">
        <video controls src="<%= main_video.getFile_name() %>" class="video">
            <source src="<%= main_video.getFile_name() %>" type="video/mp4">
        </video><!-- video -->
    </div><!-- video -->
    <div class="video-info">
        <div class="top">
            <c:forEach items="${tags}" var="t">
                <a href="#" class="search-by-tag">${t.getTopic()}</a>
            </c:forEach>
        </div><!-- top -->
        <div class="middle">
            <div class="name-date">
                <p><%= main_video.getName() %></p>
                <p><%= main_video.getViews() %> views • <%= main_video.getDate() %></p>
            </div><!-- name-date -->
            <%
                action a = db.check_action(user_id, id);
            %>
            <div class="ld" id="ld" data-status="<%= a.getAction() %>">
                <div class="like">
                    <%
                        if (Objects.equals(a.getAction(), "like")) {
                    %>
                        <i class="fa fa-thumbs-up active" id="like" aria-hidden="true"></i>
                    <%  } else { %>
                        <i class="fa fa-thumbs-up tooltip" title="You must login to use those function" id="like" aria-hidden="true"></i>
                    <%  } %>
                    <p id="like_p"><%= main_video.getlike() %></p>
                </div><!-- like -->
                <div class="dislike">
                    <% if (Objects.equals(a.getAction(), "dislike")) { %>
                        <i class="fa fa-thumbs-down active" id="dislike" aria-hidden="true"></i>
                    <%  } else { %>
                        <i class="fa fa-thumbs-down tooltip" title="You must login to use those function" id="dislike" aria-hidden="true"></i>
                    <%  } %>
                    <p id="dislike_p"><%= main_video.getdislike() %></p>
                </div><!-- dislike -->
            </div><!-- ld -->
            <%
                if (user_id != 1) {
                ArrayList<list> lists = db.get_list(user_id);
                request.setAttribute("lists", lists);
            %>
            <div class="lists-dropdown">
                <div class="dropdown-button">
                    <i class="fa fa-plus-circle" aria-hidden="true"></i>
                </div>
                <div class="dropdown-content">
                    <% int o = 0; %>
                    <c:forEach items="${lists}" var="l">
                        <div class="row list-to-add-row">
                            <%
                                boolean b = db.check_list_video(lists.get(o).getId() ,id);
                                if (b) {
                            %>
                                <input type="checkbox" value="${l.getName()}" data-id="${l.getId()}" id="${l.getName()}" checked>
                            <% } else { %>
                                <input type="checkbox" value="${l.getName()}" data-id="${l.getId()}" id="${l.getName()}">
                            <% } %>
                            <label for="${l.getName()}">${l.getName()}</label>
                        </div>
                        <% o++; %>
                    </c:forEach>
                </div>
            </div>
            <% } %>
        </div><!-- middle -->
        <div class="low">
            <div class="user">
                <div>
                    <p class="img"><%= main_video.getUser_name().substring(0,1).toUpperCase() %></p>
                    <p class="user-page-open" id="user_id" data-channel-id="<%= main_video.getUser_id() %>"><%= main_video.getUser_name() %></p>
                </div><!-- div -->
                <%
                    if (user_id != main_video.getUser_id()) {
                        boolean check = db.check_subscribtion(user_id, main_video.getUser_id());
                        if (check != false) {
                %>
                        <button style="background: #6b6260;" data-sub="subscribed" data-channel-id="<%= main_video.getUser_id() %>" class="subscriber-btn subscriber">subscribed</button>
                <%      } else { %>
                        <button style="background: #ff592e;" data-sub="subscribe" data-channel-id="<%= main_video.getUser_id() %>" title="You must login to use those function" class="subscriber-btn subscriber tooltip">subscribe</button>
                <%
                        }
                    }
                %>
            </div><!-- user -->
            <div class="description">
                <p><%= main_video.getDescription() %></p>
            </div><!-- description -->
        </div><!-- low -->
    </div><!-- video-info -->
    <div class="comment">
        <% if (user_id != 1) { %>
            <div class="main-comment-input">
                <input type="text">
                <button id="submit-main-comment">submit</button>
            </div>
        <% } %>
        <% int i = 0; %>
        <c:forEach items="${comments_answers}" var="c">
            <div class="each-comment" data-comment-id="${c.getMainId()}">
                <p class="name">${c.getMainuser_name()} ${c.getMainDate()}</p>
                <p class="text">${c.getMainText()}</p>
                <button data-onclick="t|#answer-<%=i%>|comment-display" class="react answer-btn">answers</button>
                <button class="reply-btn tooltip" title="You must login to use those function" data-reply="${c.getMainuser_name()}">reply</button>
                <%
                    request.setAttribute("answers", comments.get(i).getAnswers());
                %>
                <div id="answer-<%=i%>" class="answer comment-display">
                    <c:forEach items="${answers}" var="a">
                        <div class="each-answer">
                            <p class="answer-name">${a.getUser_name()} ${a.getDate()}</p>
                            <p class="answer-text">${a.getText()}</p>
                            <button class="reply-btn tooltip" title="You must login to use those function" data-reply="${a.getUser_name()}">reply</button>
                        </div><!-- each-answer -->
                    </c:forEach>
                    <% if (user_id != 1) { %>
                        <div class="reply-input">
                            <input type="text">
                            <button class="reply-submit-btn">submit</button>
                        </div><!-- reply-input -->
                    <% } %>
                </div><!-- answer -->
            </div><!-- each-comment -->
            <% i++; %>
        </c:forEach>
    </div><!-- comment -->
</div><!-- left-each-video -->
<div class="right-each-video">
    <div class="recommendations">
        <%
            List<video> ten_video = db.get_10_videos();
            request.setAttribute("ten_video", ten_video);
        %>
        <c:forEach items="${ten_video}" var="tv">
            <div class="each-video-rec video-open" data-video-open="${tv.getId()}">
                <div class="left-video">
                    <video src="${tv.getFile_name()}" class="video">
                        <source src="${tv.getFile_name()}" type="video/mp4">
                    </video><!-- video -->
                </div><!-- left-video -->
                <div class="right-text">
                    <h3 class="name">
                        ${tv.getName()}
                    </h3><!-- name -->
                    <p class="username">
                        ${tv.getUser_name()}
                    </p><!-- username -->
                    <p class="views">
                        Views: ${tv.getViews()}
                    </p><!-- views -->
                    <p class="date">
                        ${tv.getDate()}
                    </p><!-- date -->
                </div><!-- right-text -->
            </div><!-- each-video-rec -->
        </c:forEach>
    </div><!-- recommendations -->
</div><!-- right-each-video -->