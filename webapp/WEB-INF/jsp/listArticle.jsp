<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
<meta name="renderer" content="webkit" />
<meta name="viewport" content="width=device-width, initial-scale=1.0,maximum-scale=1, user-scalable=no">
<meta name="keywords" content=""/>
<title>剑三搜索</title>
<%@ include file="/resource.jsp" %>

<%
    String keywords = (String)request.getAttribute("keywords");
%>
<link rel="stylesheet" href="${RESOUCE_STATIC_URL}/lib/bootstrap-3.3.5-dist/css/bootstrap.css">
<link rel="stylesheet" href="${RESOUCE_STATIC_URL}/css/style.css">
</head>
<body>

    <div class="navbar navbar-default navbar-fixed-top" style="padding-bottom: .3em;,">
        <a class="nav-brand-logo" href="${RESOUCE_SYSTEM_URL}/">
            <img src="${RESOUCE_STATIC_URL}/img/index_logo.png"/>
        </a>
        <span class="search_form">
            <input type="text" name="name" value="">
            <a id="btn" href="#"><i class="glyphicon glyphicon-search"></i></a>
            <%-- <input id="btn" type="button" name="name" value="搜索一下"> --%>
        </span>
    </div>

    <%-- <div class="content">

    </div> --%>
    <div class="container content">
        <div class="row rel-search">
            <div class="col-sm-6 col-md-8">
                <span id="res_total"></span>
            </div>
            <span id="res_total"></span>
        </div>
        <div class="row rel-search"  id="height-over" style="min-height:450px">
            <!--搜索内容展示部分-->
            <div id="page_content" class="col-xs-12 col-md-8"></div>

            <!--右侧广告部分-->
            <div id="ad" class="col-xs-12 col-md-4 ad-content" style="border-left:1px solid silver;min-height: 200px;margin-top:.3em;">

            </div>
        </div>

        <!--相关搜索-->
        <div class="row rel-search" style="min-height:100px" >
            <div class="col-xs-12 col-sm-6 col-md-8">
                <div class="relevant-search">
                    <span>相关搜索</span>
                </div>
                <div class="relevant-search-res">
                    <table>
                        <tbody></tbody>
                    </table>
                </div>
            </div>
        </div>

        <!--底部-->
        <div class="row rel-search" style="margin-top:19px">
            <div class="col-xs-12 col-sm-6 col-md-8">
                <div class="pagenation" id="_pageNation">
                </div>
            </div>
        </div>
    </div>

<!--底部-->
<div class="navbar navbar-default navbar-bottom content-footer">
    <div class="container">
        <div class="row">
            <div class="content-footer-notice">
                <a href="${RESOUCE_SYSTEM_URL}/aboutus">关于我们</a>|
                <a href="${RESOUCE_SYSTEM_URL}/agreement">使用协议</a>|
                <a href="${RESOUCE_SYSTEM_URL}/law">法律声明</a>
            </div>
        </div>
    </div>
</div>


<script type="text/javascript" src="${RESOUCE_STATIC_URL}/lib/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="${RESOUCE_STATIC_URL}/lib/bootstrap-3.3.5-dist/js/bootstrap.js"></script>
<script type="text/javascript" src="${RESOUCE_STATIC_URL}/js/pagenation.js"></script>
<script type="text/javascript" src="${RESOUCE_STATIC_URL}/js/page.js"></script>
<script type="text/javascript" src="${RESOUCE_STATIC_URL}/js/util/HtmlUtil.js"></script>
<script type="text/javascript" src="${RESOUCE_STATIC_URL}/js/util/CompatibleStyle.js"></script>
<script type="text/javascript" src="${RESOUCE_STATIC_URL}/js/util/keywords.js"></script>

<script type="text/javascript">
// style="min-height:459px"
    var Bheight = window.screen.height ;
  // alert(Bheight); 
   /// alert( $('#height-over').style.height);
   if(Bheight>800&&Bheight<1080){
        $('#height-over').attr('style','min-height:'+(Bheight*0.52)+'px'+'')
   }else if(Bheight>=1080&Bheight<1600){
        $('#height-over').attr('style','min-height:'+(Bheight*0.60)+'px'+'')
   }else if(Bheight <700){
         $('#height-over').attr('style','min-height:'+(Bheight*0.30)+'px'+'')
   }
  
     var keywords = "<%=keywords%>";
     $("input[type='text']").val(keywords);

     Page.getRelSearchData(keywords);
     Page.getAdertInfo(keywords,"ad");
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
        url:RESOUCE_SYSTEM_URL_JS+"/article/search",
        pageId:'_pageNation',
        contentId:'page_content',
        screen_width:screen_width
    };

    var param = {page:'1',rows:'10',keywords:keywords};


    var pageNation = new PageNation(opts,param);

    $(document).keydown(function(event) {
        if (event.keyCode == 13) {
            var keywords = $("input[type='text']").val();
            $("input[type='text']").val(keywords);
            keywords = $("input[type=text]").val();
            $("title").text(keywords);
            param.keywords = keywords;
            pageNation.initPage(opts,param);
            Page.getRelSearchData(keywords);
            Page.getAdertInfo(keywords,"ad");
        }
    });

    $("#btn").unbind('click');
    $("#btn").bind('click',function(event) {
        /* Act on the event */
        keywords = $("input[type=text]").val();
        $("input[type='text']").val(keywords);
        $("title").text(keywords);
        param.keywords = keywords;
        pageNation.initPage(opts,param);
        Page.getRelSearchData(keywords);
        Page.getAdertInfo(keywords,"ad");

    });

</script>
<script type="text/javascript">

    $(document).ready(function(){
        Keywrods.getContent();
        /*兼容浏览器点击数据框outline*/
        CompStyle.lineStyle();

        $("title").text("<%=keywords%>");

        var url = RESOUCE_SYSTEM_URL_JS+"/websiteconfig/getinfo";

        $.get(url,function(data){
            var obj = data.wc;
            //$("title").text(obj.title);
            $(".nav-brand-logo>img").attr("src","${RESOUCE_STATIC_URL}"+obj.logourl);
        });
    });

</script>
</body>
</html>
