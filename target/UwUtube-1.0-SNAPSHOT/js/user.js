$(document).ready(function(){
    var user_id = $("html").attr("data-user-id");
    var video_id;
    // answer last-1
    var max = 0;
    // load more content
    var load_more_home = 0;
    var load_more_sub = 0;
    // max video count
    var video_count_home = $("#home").attr("data-video-count");
    var video_count_sub = $("#sub-videos").attr("data-video-count");
    if (video_count_home <= 12) {
        $("#load-more-home").hide();
    }
    if (video_count_sub <= 12) {
        $("#load-more-sub").hide();
    }

    $("html").removeAttr("data-user-id");

    $("#history-button").click(function() {
        $.ajax({
            url: 'user_inc/history.jsp',
            type: 'POST',
            dataType: 'html',
            data: {user_id: user_id},
            success: function(data)  {
                $('#history').html(data);
            }
        });
    });
    // video page loading
    $('body').on('click','.video-open',function(){
        $("#video-page-open").attr("data-onclick", "h|.content-div s|#each-video");
        $(".content-div").hide();
        $("#each-video").show();
        video_id = $(this).attr("data-video-open");
        $.ajax({
            url: 'user_inc/video.jsp',
            type: 'POST',
            dataType: 'html',
            data: {id: video_id},
            success: function(data)  {
                $('#each-video').html(data);
            }
        });
        max = 0;
        setTimeout(function () {
            max_answer_i();
            remove_tooltip();
        }, 1000)
    });
    // like set and remove
    $('body').on('click','#like',function(){
        var function_name;
        var todo = $("#ld").attr("data-status");
        if (todo == "like") {
            function_name = "remove reaction";
        } else {
            function_name = "set like";
        }
        $.ajax({
            url: 'VideoController',
            type: 'POST',
            dataType: 'html',
            data: {
                function_name: function_name,
                user_id: user_id,
                video_id: video_id
            },
            success: function()  {
                $("#ld").removeAttr("data-status");
                if (function_name == "remove reaction") {
                    $("#like").removeClass("active");
                    $("#dislike").removeClass("active");
                    $("#ld").attr("data-status", "none");
                } else if(function_name == "set like") {
                    $("#like").addClass("active");
                    $("#dislike").removeClass("active");
                    $("#like_p").text(parseInt($("#like_p").text()) + 1);
                    $("#ld").attr("data-status", "like");
                }
                if (todo == "dislike") {
                    $("#dislike_p").text(parseInt($("#dislike_p").text()) - 1);
                } else if (todo == "like") {
                    $("#like_p").text(parseInt($("#like_p").text()) - 1);
                }
            }
        });
    });
    // dislike set and remove
    $('body').on('click','#dislike',function() {
        var function_name;
        var todo = $("#ld").attr("data-status");
        if (todo == "dislike") {
            function_name = "remove reaction";
        } else {
            function_name = "set dislike";
        }
        $.ajax({
            url: 'VideoController',
            type: 'POST',
            dataType: 'html',
            data: {
                function_name: function_name,
                user_id: user_id,
                video_id: video_id
            },
            success: function()  {
                $("#ld").removeAttr("data-status");
                if (function_name == "remove reaction") {
                    $("#like").removeClass("active");
                    $("#dislike").removeClass("active");
                    $("#ld").attr("data-status", "none");
                } else if(function_name == "set dislike") {
                    $("#dislike").addClass("active");
                    $("#like").removeClass("active");
                    $("#dislike_p").text(parseInt($("#dislike_p").text()) + 1);
                    $("#ld").attr("data-status", "dislike");
                }
                if (todo == "like") {
                    $("#like_p").text(parseInt($("#like_p").text()) - 1);
                } else if (todo == "dislike") {
                    $("#dislike_p").text(parseInt($("#dislike_p").text()) - 1);
                }
            }
        });
    });
    // subscribe add and remove
    $('body').on('click','.subscriber-btn',function() {
        var subornot = $(this).attr("data-sub");
        var function_name;
        if (subornot == "subscribed") {
            function_name = "remove subscriber";
        } else {
            function_name = "add subscriber";
        }
        var channel_id = $(this).attr("data-channel-id");
        var this_button = $(this);
        $.ajax({
            url: 'VideoController',
            type: 'POST',
            dataType: 'html',
            data: {
                function_name: function_name,
                user_id: user_id,
                channel_id: channel_id
            },
            success: function( data)  {
                $(".subscriber-btn").removeAttr("data-sub");
                if(function_name == "add subscriber") {
                    $(".subscriber-btn").css("background", "#6b6260");
                    $(".subscriber-btn").text("subscribed");
                    $(".subscriber-btn").attr("data-sub", "subscribed");
                    $(data).insertAfter(".subscriber-list > .first");
                } else if(function_name == "remove subscriber") {
                    $(".subscriber-btn").css("background", "#ff592e");
                    $(".subscriber-btn").text("subscribe");
                    $(".subscriber-btn").attr("data-sub", "subscribe");
                    $("#sub-list-" + channel_id).remove();
                }
            }
        });
    });
    // replay text right in input
    $('body').on('click','.reply-btn',function() {
        var name = $(this).attr("data-reply");
        var input = $(this).parents(".each-comment").children(".answer").children(".reply-input").children("input");
        input.val(name);
        input.focus();
    });
    // make reply on comment
    $('body').on('click','.reply-submit-btn',function() {
        var comment_id = $(this).parents(".each-comment").attr("data-comment-id");
        var input_value = $(this).parent().children("input").val();
        var type = "reply";
        var function_name = "add reply comment";

        var toadd = $(this).parent();
        if (input_value != "" || input_value != " " || input_value != "  ") {
            $.ajax({
                url: 'VideoController',
                type: 'POST',
                dataType: 'html',
                data: {
                    function_name: function_name,
                    user_id: user_id,
                    video_id: video_id,
                    comment_id: comment_id,
                    text: input_value,
                    type: type
                },
                success: function (data) {
                    $(data).insertBefore(toadd);
                    remove_tooltip();
                }
            });
        }
    });
    // add main type comment
    $('body').on('click','#submit-main-comment',function() {
        var input_value = $(this).parent().children("input").val();
        var type = "main";
        var function_name = "add main comment";
        var toadd = $(this).parent();
        max++;
        if (input_value != "" || input_value != " " || input_value != "  ") {
            $.ajax({
                url: 'VideoController',
                type: 'POST',
                dataType: 'html',
                data: {
                    function_name: function_name,
                    user_id: user_id,
                    video_id: video_id,
                    text: input_value,
                    type: type,
                    number: max
                },
                success: function (data) {
                    $(data).insertAfter(toadd);
                }
            });
        }
    });
    // add video to list and remove it form there
    $('body').on('click','.list-to-add-row',function() {
        var isornotchecked = $(this).children("input").is(':checked');
        var list_id = $(this).children("input").attr("data-id");
        var function_name;
        if (isornotchecked) {
            function_name = "add video to list";
        } else {
            function_name = "remove video form list";
        }
        $.ajax({
            url: 'VideoController',
            type: 'POST',
            dataType: 'html',
            data: {
                function_name: function_name,
                video_id: video_id,
                playlist_id: list_id
            }
        });
    });
    // load more home content
    $('body').on('click','#load-more-home',function(){
        load_more_home++;
        $.ajax({
            url: 'user_inc/load-more.jsp',
            type: 'POST',
            dataType: 'html',
            data: {offset: load_more_home},
            success: function(data)  {
                $(data).insertBefore("#load-more-home");
            }
        });
        if (video_count_home <= (load_more_home + 1) * 12) {
            $("#load-more-home").hide();
        }
    });
    // search loading
    $('body').on('click','.search-btn',function() {
        var search = $(".search-input").val();
        $.ajax({
            url: 'user_inc/search.jsp',
            type: 'POST',
            dataType: 'html',
            data: {
                search: search
            },
            success: function(data)  {
                $('.content-div').hide();
                $('#for-load-content').html(data).show();
            }
        });
    });
    // loading by tags
    $('body').on('click','.search-by-tag',function() {
        var tag_name = $(this).text();
        $.ajax({
            url: 'user_inc/tags.jsp',
            type: 'POST',
            dataType: 'html',
            data: {
                tag_name: tag_name
            },
            success: function(data)  {
                $('.content-div').hide();
                $('#for-load-content').html(data).show();
            }
        });
    });
    // logout
    $('body').on('click','.logout',function() {
        $.ajax({
            url: 'UserController',
            type: 'POST',
            dataType: 'html',
            data: {
                function_name: "log out"
            },
            success: function()  {
                location.reload();
            }
        });
    });
    // loading by user id
    $('body').on('click','.user-page-open',function() {
        var channel_id = $(this).attr("data-channel-id");
        $.ajax({
            url: 'user_inc/userpage.jsp',
            type: 'POST',
            dataType: 'html',
            data: {
                user_id: channel_id
            },
            success: function(data)  {
                $('.content-div').hide();
                $('#for-load-content').html(data).show();
                remove_tooltip();
            }
        });
    });
    // add list
    $('body').on('click','#add-list',function() {
        var name = $("#add-list-input").val();
        $.ajax({
            url: 'UserController',
            type: 'POST',
            dataType: 'html',
            data: {
                function_name: "add list",
                name: name
            },
            success: function(data)  {
                $(data).insertBefore($("#menu-add-list"));
                $("#add-list-input").val("");
            }
        });
    });
    // load list
    $('body').on('click','.list-btn',function() {
        var list_id = $(this).attr("data-list-id");
        $.ajax({
            url: 'user_inc/list.jsp',
            type: 'POST',
            dataType: 'html',
            data: {
                list_id: list_id
            },
            success: function(data)  {
                $(".list").html(data);
            }
        });
    });
    // remove list
    $('body').on('click','.remove-list',function() {
        var list_id = $(this).attr("data-id");
        var div = $(this).parent().parent().children();
        $.ajax({
            url: 'UserController',
            type: 'POST',
            dataType: 'html',
            data: {
                function_name: "remove list",
                list_id: list_id
            },
            success: function()  {
                div.remove();
                $("#list-" + list_id).remove();
                $("#home").show();
            }
        });
    });
    // load more sub content
    $('body').on('click','#load-more-sub',function(){
        load_more_sub++;
        $.ajax({
            url: 'user_inc/subscriber_videos.jsp',
            type: 'POST',
            dataType: 'html',
            data: {offset: load_more_sub},
            success: function(data)  {
                $(data).insertBefore("#load-more-sub");
            }
        });
        if (video_count_sub <= (load_more_sub + 1) * 12) {
            $("#load-more-sub").hide();
        }
    });



    // answer max i
    function max_answer_i() {
        $('.answer').each(function() {
            var value = $(this).attr("id");
            var part = value.split("-");
            value = parseInt(part[1]);
            max = (value > max) ? value : max;
        });
    }
    // remove tooltip
    function remove_tooltip() {
        $(".tooltip").attr("title", "");
    }
});
