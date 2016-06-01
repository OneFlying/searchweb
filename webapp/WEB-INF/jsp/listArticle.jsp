<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<%@page import="com.yf.utils.KeyWordUtil"%>
<%
    KeyWordUtil keyUtil = KeyWordUtil.getInstance();
    String keywordsContent = keyUtil.getContent();
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
    <meta name="renderer" content="webkit" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0,maximum-scale=1, user-scalable=no">
    <meta name="keywords" content="<%=keywordsContent%>"/>
    <title>剑三搜索</title>
    <%@ include file="/resource.jsp" %>
    <%
        String keywords = (String)request.getAttribute("keywords");
    %>
    <script type="text/javascript">
        var system = {};
        var p = navigator.platform;
            system.win = p.indexOf("Win") == 0; 
            system.mac = p.indexOf("Mac") == 0; 
            system.x11 = (p == "X11") || (p.indexOf("Linux") == 0);
        var head = document.getElementsByTagName('head')[0];
        var link = document.createElement('link');
            link.rel = 'stylesheet';
            link.type = 'text/css';
        if(system.win||system.mac||system.x11){//如果是电脑
            link.href = '${RESOUCE_STATIC_URL}/css/search.css';
        }else{  //如果是手机
            link.href = '${RESOUCE_STATIC_URL}/css/msearch.css';
        }
        head.appendChild(link);
    </script>
</head>
<body>
    <div id="wrapper" class="wrapper_s">

        <div id="head">
            <div class="head_wrapper">
                <div class="s_form">
                    <div class="s_form_wrapper">
                        <a id="result_logo" href="${RESOUCE_SYSTEM_URL}/" style="cursor:pointer;">
                            <img src="${RESOUCE_STATIC_URL}/img/plus_logo.png" alt="返回首页" title="返回首页">
                        </a>
                        <form id="form" name="f" class="fm" action="" method="" onsubmit="return false;">
                            <span class="s_ipt_wr">
                                <input id="kw" name="wd" class="s_ipt" value="" maxlength="255" autocomplete="off">
                            </span>
                            <span class="s_btn_wr">
                                <button id="su" value="" class="s_btn"><span class="glyphicon glyphicon-search"></span></button>
                            </span>
                            <span class="tools">
                                <a href="${RESOUCE_SYSTEM_URL}/article/index" style="text-decoration:none;">上传你的文章</a>
                            </span>
                        </form>
                    </div>
                </div>
            </div>
        </div><!-- /head -->

        <div id="s_tab" class="s_tab">
            <a class="active" href="${RESOUCE_SYSTEM_URL}/">首页</a>
            <span>&gt;</span>
            <a href="#">搜索结果页</a>
        </div><!-- /tab -->

        <div id="wrapper_wrapper">
            <div id="container" class="container-l">
                <div id="content_right" class="cr-offset">
                    <!-- <span style="font-size:14px;font-weight:bold;margin-bottom:5px;display:block;">广告推荐</span>
                    <table>
                        <tr>
                            <td>1111</td>
                            <td>2222</td>
                            <td>3333</td>
                            <td>4444</td>
                        </tr>
                    </table> -->
                </div><!-- /ad -->

                <div class="head_nums_cont_outer">
                    <div class="nums">
                        	<!-- 共为您搜索到1000条相关数据 -->
                    </div>
                </div><!-- /num -->

                <div id="content_left">
                    <%-- <div class="content_top">
                        <div class="content_top_item">
                            <a href="#">
                                <div class="content_title">广西南宁医院--一家大型的医院</div>
                                <div class="content_content">
                                    <div class="c_col_l">
                                        <a href="" target="_blank" class="">
                                            <img src="${RESOUCE_STATIC_URL}/img/backimg.png">
                                        </a>
                                    </div>
                                    <div class="c_col_r">
                                        <p>2016年5月2日 - 以“博爱”、“仁爱”、“曙光”为名称的医院大部分被林氏家族所控制。以“华夏”、“华康”、“华东”等名称开头的医院基本上被陈氏家族所控制。黄...“曙光”为名称的医院大部分被林氏家族所控制。以“华夏”、“华康”、“华东”等名称开头的医院基本上被陈氏家族所控制。黄...</p>
                                    </div>
                                </div>
                                <div class="content_link">
                                    <a href="#">http://www.baidu.com</a>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="c-container">
                        <div class="c-row">
                            <h3>
                                <a href="#">测试连接测试连接测试连接测试连接测试连接测试连接</a>
                            </h3>
                            <div class="c_col_l">
                                <a href="" target="_blank" class="">
                                    <img src="${RESOUCE_STATIC_URL}/img/backimg.png">
                                </a>
                            </div>
                            <div class="c_col_r">
                                <p>2016年5月2日 - 以“博爱”、“仁爱”、“曙光”为名称的医院大部分被林氏家族所控制。以“华夏”、“华康”、“华东”等名称开头的医院基本上被陈氏家族所控制。黄...“曙光”为名称的医院大部分被林氏家族所控制。以“华夏”、“华康”、“华东”等名称开头的医院基本上被陈氏家族所控制。黄...</p>
                                <p class="c_col_link"><a href="#">http://www.baidu.com</a></p>
                            </div>
                        </div>

                    </div> --%>
                </div><!-- /content -->

                <div style="clear:both;height: 0"></div>

                <div id="rs">

                </div><!-- /相关搜索 -->

                <div id="page" class="pagenation">

                </div><!-- /page -->
            </div>

            <div id="footer">
                <form id="form1" name="f" class="fm" action="" method="" onsubmit="return false;">
                    <span class="s_ipt_wr">
                        <input id="kw1" name="wd" class="s_ipt" value="" maxlength="255" autocomplete="off">
                    </span>
                    <span class="s_btn_wr">
                        <button id="su1" value="" class="s_btn"><span class="glyphicon glyphicon-search"></span></button>
                    </span>
                    <span class="tools">
                        <a href="${RESOUCE_SYSTEM_URL}/article/index">上传你的文章</a>
                    </span>
                </form>
                <span id="help">
                    <a id="seth" href="${RESOUCE_SYSTEM_URL}/law?param=lxwm">使用协议</a>
                    <a id="setf" href="${RESOUCE_SYSTEM_URL}/law?param=flsm">免责声明</a>
                    <a id="segy" href="${RESOUCE_SYSTEM_URL}/law?param=gywm">关于我们</a>
                </span>
                <span id="copy">
                    &copy; xx.com 2016
                </span>
            </div><!-- /footer -->
        </div>
    </div>
    <%--<div class="navbar navbar-default navbar-fixed-top" style="padding-bottom: .3em;,">--%>
        <%--<a class="nav-brand-logo" href="${RESOUCE_SYSTEM_URL}/">--%>
            <%--<img src="${RESOUCE_STATIC_URL}/img/index_logo.png"/>--%>
        <%--</a>--%>
        <%--<span class="search_form">--%>
            <%--<input type="text" name="name" value="">--%>
            <%--<a id="btn" href="#"><i class="glyphicon glyphicon-search"></i></a>--%>
        <%--</span>--%>
    <%--</div>--%>
    <%--<div class="container content">--%>
        <%--<div class="row rel-search">--%>
            <%--<div class="col-sm-6 col-md-8">--%>
                <%--<span id="res_total"></span>--%>
            <%--</div>--%>
            <%--<span id="res_total"></span>--%>
        <%--</div>--%>
        <%--<div class="row rel-search"  id="height-over" style="min-height:450px">--%>
            <%--<!--搜索内容展示部分-->--%>
            <%--<div id="page_content" class="col-xs-12 col-md-8"></div>--%>

            <%--<!--右侧广告部分-->--%>
            <%--<div id="ad" class="col-xs-12 col-md-4 ad-content" style="border-left:1px solid silver;min-height: 200px;margin-top:.3em;">--%>

            <%--</div>--%>
        <%--</div>--%>

        <%--<!--相关搜索-->--%>
        <%--<div class="row rel-search" style="min-height:100px" >--%>
            <%--<div class="col-xs-12 col-sm-6 col-md-8">--%>
                <%--<div class="relevant-search">--%>
                    <%--<span>相关搜索</span>--%>
                <%--</div>--%>
                <%--<div class="relevant-search-res">--%>
                    <%--<table>--%>
                        <%--<tbody></tbody>--%>
                    <%--</table>--%>
                <%--</div>--%>
            <%--</div>--%>
        <%--</div>--%>

        <%--<!--底部-->--%>
        <%--<div class="row rel-search" style="margin-top:19px">--%>
            <%--<div class="col-xs-12 col-sm-6 col-md-8">--%>
                <%--<div class="pagenation" id="_pageNation">--%>
                <%--</div>--%>
            <%--</div>--%>
        <%--</div>--%>
    <%--</div>--%>

<%--<!--底部-->--%>
<%--<div class="navbar navbar-default navbar-bottom content-footer">--%>
    <%--<div class="container">--%>
        <%--<div class="row">--%>
            <%--<div class="content-footer-notice">--%>
                <%--<a href="${RESOUCE_SYSTEM_URL}/law?param=gywm">关于我们</a>|--%>
                <%--<a href="${RESOUCE_SYSTEM_URL}/law?param=lxwm">联系我们</a>|--%>
                <%--<a href="${RESOUCE_SYSTEM_URL}/law?param=flsm">法律声明</a>--%>
            <%--</div>--%>
        <%--</div>--%>
    <%--</div>--%>
<%--</div>--%>


<script type="text/javascript" src="${RESOUCE_STATIC_URL}/lib/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="${RESOUCE_STATIC_URL}/lib/bootstrap-3.3.5-dist/js/bootstrap.js"></script>
<script type="text/javascript" src="${RESOUCE_STATIC_URL}/js/pagenation.js"></script>
<script type="text/javascript" src="${RESOUCE_STATIC_URL}/js/page.js"></script>
<script type="text/javascript" src="${RESOUCE_STATIC_URL}/js/util/HtmlUtil.js"></script>

<script type="text/javascript">
    $.ajaxSetup ({
        cache: false //关闭AJAX缓存
    });
    //未做手机端浏览器判定
    var initTop = 0;
    $(window).scroll(function(){
        var scrollTop = $(window).scrollTop();
        if(scrollTop > initTop){
            if(scrollTop >= 93) {
                $('#head').addClass('s_down');
            }
        } else {
            if(scrollTop == 0) {
                $('#head').removeClass('s_down');
            }
        }
        initTop = scrollTop;
    });

    //搜索框默认获取焦点
    $('#kw').focus();
    $('.s_ipt_wr').addClass('iptfocus');

    $('#kw').on('focus', function(){
        $('.s_ipt_wr').addClass('iptfocus');
    }).on('blur', function(){
        $('.s_ipt_wr').removeClass('iptfocus');
    });

    var keywords = "<%=keywords%>";
    $("#kw").val(keywords);
    $('#kw1').val(keywords);

    //相关搜索
    if(!system.win && !system.mac && !system.x11) { //如果是手机
        Page.getRelSearchData(keywords,true);
    } else {
        Page.getRelSearchData(keywords);
    }

    //广告
    Page.getAdertInfo(keywords,"content_right");

    var opts = {
        page:1,
        rows:10,
        page_total:10,
        url:RESOUCE_SYSTEM_URL_JS+"/article/search",
        pageId:'page',
        contentId:'content_left'
    };

    var param = {page:'1',rows:'10',keywords:keywords};
    var pageNation = new PageNation(opts,param);

    $(document).keydown(function(event) {
        if (event.keyCode == 13) {
            var keywords = $("#kw").val();
            if(keywords.trim() == '') {
                window.location.href = RESOUCE_SYSTEM_URL_JS + '/';
            }
            $("#kw").val(keywords);
            keywords = $("#kw").val();
            $("title").text(keywords);
            param.keywords = keywords;
            pageNation.initPage(opts,param);
            Page.getRelSearchData(keywords);
            Page.getAdertInfo(keywords,"content_right");
        }
    });

    $("#su").bind('click',function(event) {
        /* Act on the event */
        var keywords = $("#kw").val();
        if(keywords.trim() == '') {
            window.location.href = RESOUCE_SYSTEM_URL_JS + '/';
        }
        $("#kw").val(keywords);
        keywords = $("#kw").val();
        $("title").text(keywords);
        param.keywords = keywords;
        pageNation.initPage(opts,param);
        Page.getRelSearchData(keywords);
        Page.getAdertInfo(keywords,"content_right");
    });

    $("#su1").bind('click',function(event) {
        /* Act on the event */
        var keywords = $("#kw1").val();
        if(keywords.trim() == '') {
            window.location.href = RESOUCE_SYSTEM_URL_JS + '/';
        }
        $("#kw1").val(keywords);
        keywords = $("#kw1").val();
        $("title").text(keywords);
        param.keywords = keywords;
        pageNation.initPage(opts,param);
        Page.getRelSearchData(keywords);
        Page.getAdertInfo(keywords,"content_right");
    });

    //修正页面
    $('#container').css({
        minHeight: $(window).height() - 177 + 'px'
    });

    $(window).on('resize',function(){
        $('#container').css({
            minHeight: $(window).height() - 177 + 'px'
        });
    });

</script>
<script type="text/javascript">

    $(document).ready(function(){
        $("title").text("<%=keywords%>");
        $("#result_logo>img").attr("src","${RESOUCE_STATIC_URL}"+"${qitalogourl}");

        var url = RESOUCE_SYSTEM_URL_JS+"/websiteconfig/getinfo";

        $.get(url,function(data){
            var obj = data.wc;
            $("meta[name='keywords']").attr("content",obj.keywords);
            <%--$.ajax({ //获取logo--%>
                <%--type: 'get',--%>
                <%--url: '${RESOUCE_STATIC_URL}'+obj.logourl,--%>
                <%--success: function(){--%>
                    <%--$("#result_logo>img").attr("src","${RESOUCE_STATIC_URL}"+obj.qitalogourl);--%>
                <%--},--%>
                <%--error: function(){--%>
                    <%--$('#result_logo>img').attr({'src':'${RESOUCE_STATIC_URL}/img/plus_logo.png'});--%>
                <%--}--%>
            <%--});--%>
        });
    });

</script>
</body>
</html>
