<%@ page import="model.DB" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.list" %>
<%@ page import="model.video" %>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    DB db = new DB();
%>
<html data-user-id="1">
<head>
    <title>Title</title>
    <link rel="stylesheet" href="css/incognito.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
<div class="left">
    <a href="#" class="logo">
        UwUtube
    </a><!-- a -->
    <div class="menu">
        <div class="first">
            <p>Menu</p>
        </div><!-- first -->
        <div class="row react" data-onclick="h|.content-div s|#home">
            <div class="icon-div">
                <svg viewBox="0 0 24 24">
                    <path d="M9.135 20.773v-3.057c0-.78.637-1.414 1.423-1.414h2.875c.377 0 .74.15 1.006.414.267.265.417.625.417 1v3.057c-.002.325.126.637.356.867.23.23.544.36.87.36h1.962a3.46 3.46 0 002.443-1 3.41 3.41 0 001.013-2.422V9.867c0-.735-.328-1.431-.895-1.902l-6.671-5.29a3.097 3.097 0 00-3.949.072L3.467 7.965A2.474 2.474 0 002.5 9.867v8.702C2.5 20.464 4.047 22 5.956 22h1.916c.68 0 1.231-.544 1.236-1.218l.027-.009z" />
                </svg><!-- svg -->
            </div><!-- icon-div -->
            <p>Home</p>
        </div><!-- row -->
        <div class="row react" data-onclick="h|.content-div s|#newest">
            <div class="icon-div">
                <svg viewBox="0 0 24 24">
                    <path fill-rule="evenodd" clip-rule="evenodd" d="M10.835 12.007l.002.354c.012 1.404.096 2.657.242 3.451 0 .015.16.802.261 1.064.16.38.447.701.809.905a2 2 0 00.91.219c.249-.012.66-.137.954-.242l.244-.094c1.617-.642 4.707-2.74 5.891-4.024l.087-.09.39-.42c.245-.322.375-.715.375-1.138 0-.379-.116-.758-.347-1.064-.07-.099-.18-.226-.28-.334l-.379-.397c-1.305-1.321-4.129-3.175-5.593-3.79 0-.013-.91-.393-1.343-.407h-.057c-.665 0-1.286.379-1.603.991-.087.168-.17.496-.233.784l-.114.544c-.13.874-.216 2.216-.216 3.688zm-6.332-1.525C3.673 10.482 3 11.162 3 12a1.51 1.51 0 001.503 1.518l3.7-.328c.65 0 1.179-.532 1.179-1.19 0-.658-.528-1.191-1.18-1.191l-3.699-.327z" />
                </svg><!-- svg -->
            </div><!-- icon-div -->
            <p>Newest</p>
        </div><!-- row -->
        <div class="row react" id="video-page-open">
            <div class="icon-div">
                <svg viewBox="0 0 24 24">
                    <path fill-rule="evenodd" clip-rule="evenodd" d="M15.164 6.083l.948.011c3.405 0 5.888 2.428 5.888 5.78v4.307c0 3.353-2.483 5.78-5.888 5.78A193.5 193.5 0 0112.01 22c-1.374 0-2.758-.01-4.122-.038-3.405 0-5.888-2.428-5.888-5.78v-4.307c0-3.353 2.483-5.78 5.898-5.78 1.286-.02 2.6-.04 3.935-.04v-.163c0-.665-.56-1.204-1.226-1.204h-.972c-1.109 0-2.012-.886-2.012-1.965 0-.395.334-.723.736-.723.412 0 .736.328.736.723 0 .289.246.52.54.52h.972c1.481.01 2.688 1.194 2.698 2.64v.183c.619 0 1.238.008 1.859.017zm-4.312 8.663h-1.03v1.02a.735.735 0 01-.737.723.728.728 0 01-.736-.722v-1.021H7.31a.728.728 0 01-.736-.723c0-.395.334-.722.736-.722h1.04v-1.012c0-.395.324-.723.736-.723.403 0 .736.328.736.723v1.012h1.03c.403 0 .737.327.737.722a.728.728 0 01-.736.723zm4.17-1.629h.099a.728.728 0 00.736-.722.735.735 0 00-.736-.723h-.098a.722.722 0 100 1.445zm1.679 3.315h.098a.728.728 0 00.736-.723.735.735 0 00-.736-.723H16.7a.722.722 0 100 1.445z" />
                </svg><!-- svg -->
            </div><!-- icon-div -->
            <p>Video</p>
        </div><!-- row -->
    </div><!-- menu -->
</div><!-- left -->
<div class="right">
    <div class="header">
        <div class="search">
            <input class="search-input" type="text">
            <button class="search-btn">
                <svg class="svg-icon search-icon" aria-labelledby="title desc" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 19.9 19.7"><title id="title">Search Icon</title><desc id="desc">A magnifying glass icon.</desc><g class="search-path" fill="none" stroke="#848F91"><path stroke-linecap="square" d="M18.5 18.3l-5.4-5.4"/><circle cx="8" cy="8" r="7"/></g></svg>
            </button><!-- search-btn -->
        </div><!-- search -->
        <div class="user">
            <button id="login-open-btn" data-onclick="h|.sign_up_content s|.log_in_content a|.cover|open r|#signup_open|active a|#login_open|active a|#sl_modal|open" class="login-btn react">log in</button>
            <button id="signup-open-btn" data-onclick="h|.log_in_content s|.sign_up_content a|.cover|open a|#signup_open|active r|#login_open|active a|#sl_modal|open" class="signup-btn react">sign up</button>
        </div><!-- user -->
    </div><!-- header -->
    <div class="content">
        <%
            int all_video_count = db.video_count();
        %>
        <div class="home content-div" data-video-count="<%= all_video_count%>" id="home">
            <jsp:include page="user_inc/load-more.jsp" />
            <button class="load-more" id="load-more-home">load more</button>
        </div><!-- home -->
        <div id="each-video" class="each-video content-div">
            <!-- here will be loaded each video content -->
        </div> <!-- each-video -->
        <%
            List<video> newest_video = db.get_newest_videos();
            request.setAttribute("newest_video", newest_video);
        %>
        <div class="newest content-div" id="newest">
            <div class="fifteen-video-row">
                <c:forEach items="${newest_video}" var="nv">
                    <div class="each-video-div video-open" data-video-open="${nv.getId()}">
                        <div class="upper">
                            <video preload="metadata" loop muted src="${nv.getFile_name()}" class="video">
                                <source src="${nv.getFile_name()}" type="video/mp4">
                            </video><!-- video -->
                        </div><!-- upper -->
                        <div class="lower">
                            <p class="name">${nv.getName()}</p>
                            <p class="views">Views: ${nv.getViews()}</p>
                        </div><!-- lower -->
                    </div><!-- each-video-div -->
                </c:forEach>
            </div><!-- fifteen-video-row -->
        </div><!-- newest -->
        <div class="for-load-content content-div" id="for-load-content">
            <%-- here will be loaded all content like user page, search and search by tags--%>
        </div><!-- for-load-content -->
        <div class="history content-div" id="history">
            <!-- history is loaded here -->
        </div><!-- history -->
    </div><!-- content -->
</div><!-- right -->
<jsp:include page="user_inc/login_model.jsp"/>
<script src="js/incognito.js"></script>
<script src="js/react.js"></script>
</body>
</html>

<%--#242329--%>