$('body').on('click','.react',function() {
    var full = $(this).attr("data-onclick");
    action(full);
});

$('body').on('focus','.focus-input',function() {
    var full = $(this).attr("data-focus");
    action(full);
});

function action(full) {
    var full_split = full.split(" ");
    for (var i = 0; i < full_split.length; i++) {
        var part = full_split[i];
        var part_split = part.split("|");

        if (part_split[0] == "a")
            $(part_split[1]).addClass(part_split[2]);
        else if (part_split[0] == "r")
            $(part_split[1]).removeClass(part_split[2]);
        else if (part_split[0] == "t")
            $(part_split[1]).toggleClass(part_split[2]);
        else if (part_split[0] == "h")
            $(part_split[1]).hide();
        else if (part_split[0] == "s")
            $(part_split[1]).show();
        // a - add r - remove t - toggle h - hide s - show type|element|class
    }
}

var video_timer;
// start video when hover
$(".each-video-div").on('mouseenter', function() {
    $(this).children(".upper").children().trigger("play");
    var element = $(this).children(".upper").children().get(0);
    video_timer = setInterval(function() {
        element.currentTime = 0;
    },10000);
});
// pause video after mouse is out
$(".each-video-div").on("mouseout", function() {
    $(this).children(".upper").children().trigger('pause');
    var element = $(this).children(".upper").children().get(0);
    element.currentTime = 0;
    clearInterval(video_timer);
});