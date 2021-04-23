<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="model.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    DB db = new DB();
    int user_id = (int) session.getAttribute("ID");
    String username = (String) session.getAttribute("USERNAME");
    ArrayList<list> lists = db.get_list(user_id);
    request.setAttribute("lists", lists);
%>
<html data-user-id="<%= user_id %>">
<head>
    <title>Title</title>
    <link rel="stylesheet" href="css/user.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>


<%-- 54 auto lists subs --%>
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
        <div class="row react" data-onclick="h|.content-div s|#sub-videos">
            <div class="icon-div">
                <i class="fa fa-handshake-o" aria-hidden="true"></i>
            </div><!-- icon-div -->
            <p>Subscriber</p>
        </div><!-- row -->
        <div class="row react" id="video-page-open">
            <div class="icon-div">
                <svg viewBox="0 0 24 24">
                    <path fill-rule="evenodd" clip-rule="evenodd" d="M15.164 6.083l.948.011c3.405 0 5.888 2.428 5.888 5.78v4.307c0 3.353-2.483 5.78-5.888 5.78A193.5 193.5 0 0112.01 22c-1.374 0-2.758-.01-4.122-.038-3.405 0-5.888-2.428-5.888-5.78v-4.307c0-3.353 2.483-5.78 5.898-5.78 1.286-.02 2.6-.04 3.935-.04v-.163c0-.665-.56-1.204-1.226-1.204h-.972c-1.109 0-2.012-.886-2.012-1.965 0-.395.334-.723.736-.723.412 0 .736.328.736.723 0 .289.246.52.54.52h.972c1.481.01 2.688 1.194 2.698 2.64v.183c.619 0 1.238.008 1.859.017zm-4.312 8.663h-1.03v1.02a.735.735 0 01-.737.723.728.728 0 01-.736-.722v-1.021H7.31a.728.728 0 01-.736-.723c0-.395.334-.722.736-.722h1.04v-1.012c0-.395.324-.723.736-.723.403 0 .736.328.736.723v1.012h1.03c.403 0 .737.327.737.722a.728.728 0 01-.736.723zm4.17-1.629h.099a.728.728 0 00.736-.722.735.735 0 00-.736-.723h-.098a.722.722 0 100 1.445zm1.679 3.315h.098a.728.728 0 00.736-.723.735.735 0 00-.736-.723H16.7a.722.722 0 100 1.445z" />
                </svg><!-- svg -->
            </div><!-- icon-div -->
            <p>Video</p>
        </div><!-- row -->
        <div class="row react" id="history-button" data-onclick="h|.content-div s|#history">
            <div class="icon-div">
                <i class="fa fa-history" aria-hidden="true"></i>
            </div><!-- icon-div -->
            <p>History</p>
        </div><!-- row -->
        <c:forEach items="${lists}" var="l">
            <div class="row react list-btn" id="list-${l.getId()}" data-list-id="${l.getId()}" data-onclick="h|.content-div s|.list">
                <div class="icon-div">
                    <svg viewBox="0 0 24 24">
                        <path d="M12.1535 16.64L14.995 13.77C15.2822 13.47 15.2822 13 14.9851 12.71C14.698 12.42 14.2327 12.42 13.9455 12.71L12.3713 14.31V9.49C12.3713 9.07 12.0446 8.74 11.6386 8.74C11.2327 8.74 10.896 9.07 10.896 9.49V14.31L9.32178 12.71C9.03465 12.42 8.56931 12.42 8.28218 12.71C7.99505 13 7.99505 13.47 8.28218 13.77L11.1139 16.64C11.1832 16.71 11.2624 16.76 11.3515 16.8C11.4406 16.84 11.5396 16.86 11.6386 16.86C11.7376 16.86 11.8267 16.84 11.9158 16.8C12.005 16.76 12.0842 16.71 12.1535 16.64ZM19.3282 9.02561C19.5609 9.02292 19.8143 9.02 20.0446 9.02C20.302 9.02 20.5 9.22 20.5 9.47V17.51C20.5 19.99 18.5 22 16.0446 22H8.17327C5.58911 22 3.5 19.89 3.5 17.29V6.51C3.5 4.03 5.4901 2 7.96535 2H13.2525C13.5 2 13.7079 2.21 13.7079 2.46V5.68C13.7079 7.51 15.1931 9.01 17.0149 9.02C17.4333 9.02 17.8077 9.02318 18.1346 9.02595C18.3878 9.02809 18.6125 9.03 18.8069 9.03C18.9479 9.03 19.1306 9.02789 19.3282 9.02561ZM19.6045 7.5661C18.7916 7.5691 17.8322 7.5661 17.1421 7.5591C16.047 7.5591 15.145 6.6481 15.145 5.5421V2.9061C15.145 2.4751 15.6629 2.2611 15.9579 2.5721C16.7203 3.37199 17.8873 4.5978 18.8738 5.63395C19.2735 6.05379 19.6436 6.44249 19.945 6.7591C20.2342 7.0621 20.0223 7.5651 19.6045 7.5661Z" />
                    </svg><!-- svg -->
                </div><!-- icon-div -->
                <p>${l.getName()}</p>
            </div><!-- row -->
        </c:forEach>
        <div class="row react" id="menu-add-list" data-onclick="s|.cover s|.add-list">
            <div class="icon-div">
                <svg viewBox="0 0 24 24">
                    <path d="M12.1535 16.64L14.995 13.77C15.2822 13.47 15.2822 13 14.9851 12.71C14.698 12.42 14.2327 12.42 13.9455 12.71L12.3713 14.31V9.49C12.3713 9.07 12.0446 8.74 11.6386 8.74C11.2327 8.74 10.896 9.07 10.896 9.49V14.31L9.32178 12.71C9.03465 12.42 8.56931 12.42 8.28218 12.71C7.99505 13 7.99505 13.47 8.28218 13.77L11.1139 16.64C11.1832 16.71 11.2624 16.76 11.3515 16.8C11.4406 16.84 11.5396 16.86 11.6386 16.86C11.7376 16.86 11.8267 16.84 11.9158 16.8C12.005 16.76 12.0842 16.71 12.1535 16.64ZM19.3282 9.02561C19.5609 9.02292 19.8143 9.02 20.0446 9.02C20.302 9.02 20.5 9.22 20.5 9.47V17.51C20.5 19.99 18.5 22 16.0446 22H8.17327C5.58911 22 3.5 19.89 3.5 17.29V6.51C3.5 4.03 5.4901 2 7.96535 2H13.2525C13.5 2 13.7079 2.21 13.7079 2.46V5.68C13.7079 7.51 15.1931 9.01 17.0149 9.02C17.4333 9.02 17.8077 9.02318 18.1346 9.02595C18.3878 9.02809 18.6125 9.03 18.8069 9.03C18.9479 9.03 19.1306 9.02789 19.3282 9.02561ZM19.6045 7.5661C18.7916 7.5691 17.8322 7.5661 17.1421 7.5591C16.047 7.5591 15.145 6.6481 15.145 5.5421V2.9061C15.145 2.4751 15.6629 2.2611 15.9579 2.5721C16.7203 3.37199 17.8873 4.5978 18.8738 5.63395C19.2735 6.05379 19.6436 6.44249 19.945 6.7591C20.2342 7.0621 20.0223 7.5651 19.6045 7.5661Z" />
                </svg><!-- svg -->
            </div><!-- icon-div -->
            <p>Add list</p>
        </div><!-- row -->
    </div><!-- menu -->
    <div class="subscriber-list menu">
        <div class="first">
            <p>Subscriptions</p>
        </div><!-- first -->
        <%
            ArrayList<user> channels = db.get_all_user_subscriber(user_id);
            request.setAttribute("channels", channels);
        %>
        <c:forEach items="${channels}" var="c">
            <div class="row user-page-open" id="sub-list-${ c.getId() }" data-channel-id="${ c.getId() }">
                <div class="icon-div">
                    ${ c.getUsername().substring(0,1).toUpperCase() }
                </div><!-- icon-div -->
                <p>${ c.getUsername() }</p>
            </div><!-- row -->
        </c:forEach>
    </div><!-- subscriber_list -->
</div><!-- left -->
<div class="right">
    <div class="header">
        <div class="search">
            <input class="search-input" type="text">
            <button class="search-btn">
                <svg class="svg-icon search-icon" aria-labelledby="title desc" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 19.9 19.7"><title id="title">Search Icon</title><desc id="desc">A magnifying glass icon.</desc><g class="search-path" fill="none" stroke="#848F91"><path stroke-linecap="square" d="M18.5 18.3l-5.4-5.4"/><circle cx="8" cy="8" r="7"/></g></svg>
            </button><!-- search-btn -->
        </div><!-- search -->
        <div class="notifications">
            <div class="dropdown-button react" data-onclick="t|#notification-dropdown-content|dropdown-content-display">
                <i class="fa fa-bell-o" aria-hidden="true"></i>
            </div><!-- dropdown-button -->
            <div class="dropdown-content" id="notification-dropdown-content">
                <%
                    ArrayList<video> notification = db.get_notification_video(user_id);
                    request.setAttribute("notification", notification);
                %>
                <c:forEach items="${notification}" var="n">
                    <div class="notification-video video-open" data-video-open="${n.getId()}">
                        <div class="left-video">
                            <video preload="metadata" loop muted src="${ n.getFile_name() }" class="video">
                                <source src="${ n.getFile_name() }" type="video/mp4">
                            </video>
                        </div>
                        <div class="right-text">
                            <p class="name">${ n.getName() }</p>
                            <p class="author-name">${ n.getUser_name() }</p>
                        </div>
                    </div>
                </c:forEach>
            </div><!-- dropdown-content -->
        </div><!-- notifications -->

        <div class="user">
            <div class="dropdown-button">
                <div class="letter">
                    <%= username.substring(0,1).toUpperCase() %>
                </div><!-- letter -->
                <div class="arrow-down">
                    <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                        <path d="M7.41 7.84L12 12.42l4.59-4.58L18 9.25l-6 6-6-6z"/>
                        <path d="M0-.75h24v24H0z" fill="none"/>
                    </svg><!-- arrow-down -->
                </div><!-- arrow-down -->
            </div><!-- dropdown-button -->
            <div class="dropdown-content">
                <button>
                    <a href="upload.jsp">upload video</a>
                </button>
                <button class="logout">Log out</button>
            </div><!-- dropdown-content -->
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
        <%
            all_video_count = db.sub_video_count(user_id);
        %>
        <div class="sub-videos content-div" data-video-count="<%= all_video_count%>" id="sub-videos">
            <jsp:include page="user_inc/subscriber_videos.jsp" />
            <button class="load-more" id="load-more-sub">load more</button>
        </div><!-- sub-videos -->
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
        <div class="list content-div">
            <!-- lists will be loader here -->
        </div><!-- list -->
        <div class="history content-div" id="history">
            <!-- history is loaded here -->
        </div><!-- history -->
    </div><!-- content -->
</div><!-- right -->
<div class="cover react" data-onclick="h|.cover h|.add-list"></div>
<div class="add-list">
    <p>Add list</p>
    <input type="text" id="add-list-input">
    <button id="add-list">submit</button>
</div><!-- add-list -->

<script src="js/user.js"></script>
<script src="js/react.js"></script>
</body>
</html>

<%--#242329--%>