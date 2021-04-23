$(document).ready(function(){
    var video_id;
    // home load more
    var load_more_home = 0;
    var video_count_home = $("#home").attr("data-video-count");
    if (video_count_home <= 12) {
        $("#load-more-home").hide();
    }
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
    // loading by user id
    $('body').on('click','#user_id',function() {
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
            }
        });
    });
    // cleaning inputs
    function clean_value_signup() {
        $("#username_signup").val("");
        $("#email_signup").val("");
        $("#password_signup").val("");
        $("#confirm_password_signup").val("");
    }
    // sign up
    $("#signup_submit").click(function(){
        var username = $("#username_signup").val();
        var email = $("#email_signup").val();
        var password = $("#password_signup").val();
        var confirm_password = $("#confirm_password_signup").val();

        if (password === confirm_password) {
            $.ajax({
                url: "RegistrationController",
                type: 'POST',
                data: {
                    username : username,
                    email : email,
                    password : password
                },
                success: function(result) {
                    console.log(result);
                    if (result === "successful") {
                        clean_value_signup();
                    } else if(result === "email error") {
                        $(".email-error").show();
                    } else if(result === "password is not valid") {
                        $(".password-error").show();
                    }
                }
            });
        } else {
            $(".confirm-password-error").show();
        }
    });
    // login
    $("#login_submit").click(function(){
        var email = $("#email_login").val();
        var password = $("#password_login").val();
        $.ajax({
            url: "LoginController",
            type: 'POST',
            data: {
                email : email,
                password : password
            },
            success: function(result) {
                console.log(result);
                if (result == "successful") {
                    location.reload();
                } else if (result == "email error") {
                    $(".login-email-error").show();
                } else if (result == "password error") {
                    $(".login-password-error").show();
                }
            }
        });
    });
});