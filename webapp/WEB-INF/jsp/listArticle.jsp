<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
<meta name="renderer" content="webkit" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
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
            <div class="col-xs-12 col-sm-8 col-md-8">
                <ul class="article">
                    <li>
                        <a href="#wode">测试用的fasfasdfas</a>
                        <div class="row">
                            <div class="col-xs-3 col-md-2 col-sm-2">
                                <img src="" alt="" />
                            </div>
                            <div class="col-xs-9 col-md-10 col-sm-10">
                                <span class="dec_word">
                                测试用的测试用的测试测试用的测试用的测试测试用的测试用的测试测试用的测试用的测试
                                测试用的测试用的测试测试用的测试用的测试测试用的测试用的测试测试用的测试用的测试
                                测试用的测试用的测试测试用的测试用的测试测试用的测试用的测试
                                测试用的测试用的测试测试用的测试用的测试
                                测试用的测试用的测试测试用的测试用的测试测试用的测试用的测试
                                </span>
                                <a class="website" href="#">网址链接</a>
                            </div>
                        </div>
                    </li>

                    <li>
                        <a href="#wode">测试用的fasfasdfas</a>
                        <div class="row">
                            <div class="col-xs-3 col-md-2 col-sm-2">
                                <img src="" alt="" />
                            </div>
                            <div class="col-xs-9 col-md-10 col-sm-10">
                                <span class="dec_word">
                                测试用的测试用的测试测试用的测试用的测试测试用的测试用的测试测试用的测试用的测试
                                测试用的测试用的测试测试用的测试用的测试测试用的测试用的测试测试用的测试用的测试
                                测试用的测试用的测试测试用的测试用的测试测试用的测试用的测试
                                测试用的测试用的测试测试用的测试用的测试
                                测试用的测试用的测试测试用的测试用的测试测试用的测试用的测试
                                </span>
                                <a class="website" href="#">网址链接</a>
                            </div>
                        </div>
                    </li>

                    <li>
                        <a href="#wode">测试用的fasfasdfas</a>
                        <div class="row">
                            <%-- <div class="col-xs-3 col-md-2 col-sm-2">
                                <img src="" alt="" />
                            </div> --%>
                            <div class="col-xs-12 col-md-12 col-sm-12">
                                <span class="dec_word">
                                测试用的测试用的测试测试用的测试用的测试测试用的测试用的测试测试用的测试用的测试
                                测试用的测试用的测试测试用的测试用的测试测试用的测试用的测试测试用的测试用的测试
                                测试用的测试用的测试测试用的测试用的测试测试用的测试用的测试
                                测试用的测试用的测试测试用的测试用的测试
                                测试用的测试用的测试测试用的测试用的测试测试用的测试用的测试
                                </span>
                                <a class="website" href="#">网址链接</a>
                            </div>
                        </div>
                    </li>
                </ul>
            </div>

            <div class="col-md-4 col-sm-4">
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

<script type="text/javascript">

    // var keywords = "<%=keywords%>";
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
        rows:4,
        url:"${RESOUCE_SYSTEM_URL}/article/page",
        pageId:'_pageNation',
        screen_width:screen_width
    };

    var param = {page:'1',rows:'10'};

    var pageNation = new PageNation(opts,param);

</script>
</body>
</html>
