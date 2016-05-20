<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
<meta name="renderer" content="webkit" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>剑三搜索</title>
<%@ include file="/resource.jsp" %>

<%
    String keywords = (String)request.getAttribute("keywords");
%>
<link rel="stylesheet" href="${RESOUCE_STATIC_URL}/lib/bootstrap-3.3.5-dist/css/bootstrap.css">
<link rel="stylesheet" href="${RESOUCE_STATIC_URL}/css/style.css">
</head>
<body>

    <div class="navbar navbar-default navbar-fixed-top">
        <a class="nav-brand-logo" href="${RESOUCE_SYSTEM_URL}/index">
            <img src="${RESOUCE_STATIC_URL}/img/index_logo.png"/>
        </a>
        <span class="search_form">
            <input type="text" name="name" value="">
            <input id="btn" type="button" name="name" value="搜索一下">
        </span>

    </div>

    <%-- <div class="content">

    </div> --%>
    <div class="container content">

        <div class="row">
            <div id="page_content" class="col-xs-11 col-sm-8 col-md-8 ">

            </div>

            <div class="col-xs-1 col-md-4 col-sm-4 content-ad">
             	   广告
            </div>
        </div>

        <div class="row">
            <div class="pagenation" id="_pageNation">
            </div>
        </div>


    </div>


<script type="text/javascript" src="${RESOUCE_STATIC_URL}/lib/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="${RESOUCE_STATIC_URL}/lib/bootstrap-3.3.5-dist/js/bootstrap.js"></script>
<script type="text/javascript" src="${RESOUCE_STATIC_URL}/js/pagenation.js"></script>
<script type="text/javascript" src="${RESOUCE_STATIC_URL}/js/page.js"></script>
<script type="text/javascript" src="${RESOUCE_STATIC_URL}/js/util/HtmlUtil.js"></script>

<script type="text/javascript">


     var keywords = "<%=keywords%>";

    //Page.initpage();




    //var screen_width;
    //监听屏幕宽度变化做出判断

    var screen_width;
    $(window).resize(function(event) {
        screen_width = $(window).width();

    });

    //防止刷新时获取不到分页导航条
    if(screen_width == undefined){
        screen_width = $(window).width();//获取当前窗口宽度
    }
    var opts = {
        page:1,
        rows:10,
        url:"${RESOUCE_SYSTEM_URL}/article/search",
        pageId:'_pageNation',
        contentId:'page_content',
        screen_width:screen_width
    };

    var param = {page:'1',rows:'10',keywords:keywords};


    var pageNation = new PageNation(opts,param);

    $(document).keydown(function(event) {
        if (event.keyCode == 13) {
            var keywords = $("input[type='text']").val();
            keywords = $("input[type=text]").val();
            param.keywords = keywords;
            pageNation.initPage(opts,param);
        }
    });

    $("#btn").unbind('click');
    $("#btn").bind('click',function(event) {
        /* Act on the event */
        keywords = $("input[type=text]").val();
        param.keywords = keywords;
        pageNation.initPage(opts,param);

    });

</script>
<script type="text/javascript">

    $(document).ready(function(){

        var url = RESOUCE_SYSTEM_URL_JS+"/websiteconfig/getinfo";

        $.get(url,function(data){
            var obj = data.wc;
            $("title").text(obj.title);
            $(".nav-brand-logo>img").attr("src","${RESOUCE_STATIC_URL}"+obj.logourl);
        });
    });

</script>
</body>
</html>
