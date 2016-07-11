<%@ page import="java.util.*" %>
<%@ page import="com.yf.model.Article"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.yf.utils.KeyWordUtil,com.yf.model.Websitconfig"%>
<%
    KeyWordUtil keyUtil = KeyWordUtil.getInstance();
	Websitconfig  websitconfig = keyUtil.getContent();
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
    <meta name="renderer" content="webkit" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0,maximum-scale=1, user-scalable=no">
    <meta name="keywords" content="<%=websitconfig.getKeywords()%>"/>
    <meta name="description" content="<%=websitconfig.getContent()%>" />
    <%
        Article article = (Article)request.getAttribute("article");
    %>
    <title><%=article.getTitle() %></title>
    <%@ include file="/resource.jsp" %>
    <script type="text/javascript">
        var system = {};
        var isDesktop = false;
        var p = navigator.platform;
            system.win = p.indexOf("Win") == 0; 
            system.mac = p.indexOf("Mac") == 0; 
            system.x11 = (p == "X11") || (p.indexOf("Linux") == 0);
        var head = document.getElementsByTagName('head')[0];
        var link = document.createElement('link');
            link.rel = 'stylesheet';
            link.type = 'text/css';
        if(system.win||system.mac){//如果是电脑
            isDesktop = true;
            link.href = '${RESOUCE_STATIC_URL}/css/info.css';
        }else{  //如果是手机
            link.href = '${RESOUCE_STATIC_URL}/css/minfo.css';
        }
        head.appendChild(link);
    </script>
    <script type="text/javascript" src="${RESOUCE_STATIC_URL}/lib/jquery-1.11.1.min.js"></script>
</head>
<body>
    <div class="wide-screen">
        <div class="head">
            <div class="top-search-box">
                <div class="search-box-logo" onclick="window.location.href='${RESOUCE_SYSTEM_URL}/'" style="cursor:pointer;">
                    <img alt="logo" src="${RESOUCE_STATIC_URL}/img/plus_logo.png" id="logo" />
                </div>
                <div class="search-box-form">
                    <form method="" id="form1" class="f" action="" onsubmit="return false;">
                        <div class="box">
                        	<div class="left_box">
                        		<input type="text" id="kw" name="kw" class="s-input" value="">
                        	</div>
                            <div class="right_box">
                            	<button id="su" class="s-btn"><span class="glyphicon glyphicon-search"></span></button>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="search-box-tools">
                    <a href="${RESOUCE_SYSTEM_URL}/article/index">上传你的文章</a>
                </div>
            </div>
        </div>
        <div class="navbar">
            <div class="s_navbar">
                <a class="active" href="javascript:;">搜索结果</a>
                <span>&gt;</span>
                <a href="#" class="subActive">
                    <%=article.getTitle() %>
                </a>
            </div>
        </div>
        <div class="content">
            <div class="s_content">
                <div class="s_content_left">
                    <div class="s_top">
                        <h1><%=article.getTitle() %></h1>
                        <%
                            if( article.getDate() != null){
                        %>
                        <div class="date">更新时间：<%=article.getDate()%></div>
                        <%}%>
                    </div>
                    <div class="s_middle" style="clear:both;">
                        <%=article.getContent()%>
                    </div>
                    <div class="s_website">
                        相关网页：
                        <a href="<%=article.getWebsite()%>">
                            <%=article.getWebsite()%>
                        </a>
                    </div>
                    <div class="s_bottom">
                        <div class="s_ground">
                            <div class="s_g_title"></div>
                            <div class="s_g_button">
                                <%-- <span id="showMessage">评论</span> --%>
                            </div>
                        </div>
                        <div class="s_g_text">
                            <textarea name="me_content" title="" maxLength="200"></textarea>
                            <div class="s_g_text_btn">
                                <span id="memNum">还可输入200字</span>
                                <button id="memBtn">我要评论</button>
                            </div>
                        </div>
                        <div class="s_list" id="evaluate">
                            <!-- 留言列表 -->
                        </div>
                    </div>
                </div>
                <div class="s_content_right">
                    <div id="inline1" class="fancybox-decoration right_box" style="display:none;">
                        <h2>我要举报</h2>
                        <textarea name="jubao_content" title="" maxLength="200"></textarea>
                        <div id="jbNum">还可输入200字</div>
                        <a id="btn_submit" class="btn_submit btn_gray">我要举报</a>
                    </div>
                    <div id="inline2" class="fancybox-decoration right_box">
                        <h2>我要留言</h2>
                        <textarea name="mes_content" title="" maxLength="200"></textarea>
                        <div id="meNum">还可输入200字</div>
                        <a id="mes_submit" class="btn_submit">我要留言</a>
                    </div>
                </div>
            </div>
        </div>
        <div style="clear:both;height:0"></div>
        <div class="footer">
            &copy;xx.com 2016
            <a id="setf" href="${RESOUCE_SYSTEM_URL}/law?param=flsm">免责声明</a>
            <a id="seth" href="${RESOUCE_SYSTEM_URL}/law?param=lxwm">使用协议</a>
            <a id="segy" href="${RESOUCE_SYSTEM_URL}/law?param=gywm">关于我们</a>
        </div>
    </div>
    <!-- 返回顶部 -->
    <a href="#" id="scrollTop"><span class="glyphicon glyphicon-menu-up"></span></a>
    <!-- 我要举报 -->
    <a href="#" id="jbBtn">我要<br>举报</a>
    <!-- 举报窗口 -->
    <div class="jbFrame">
        <div class="f_title">
            <span>我要举报</span>
            <a href="#" onclick="$('.jbFrame').fadeOut(500);"><span></span></a>
        </div>
        <div class="f_content">
            <textarea name="jbMessage" maxLength="200"></textarea>
        </div>
        <span id="jbMessageNum">还可输入200字</span>
        <button id="jbMessageBtn">我要举报</button>
        <div class="f_bottom">
            我们会尽快的处理您的举报信息
        </div>
    </div>

    <!-- 提示窗口 -->
    <div class="message"></div>

    <script type="text/javascript" src="${RESOUCE_STATIC_URL}/js/util/HtmlUtil.js"></script>
    <script type="text/javascript" src="${RESOUCE_STATIC_URL}/js/evaluate.js"></script>
    <script type="text/javascript">
        //滚动事件监听
        var initTop = 0;
        var isFixed = false;
        $(window).scroll(function(){
            var scrollTop = $(window).scrollTop();
            if(scrollTop > initTop){
                if(scrollTop >= 500) {
                    $('#scrollTop').css({display:'block'});
                }
                if(isDesktop) {
                	if(scrollTop >= 150) {
                		isFixed = true;
                		<%--if($(window).width() >= 1280) {--%>
                			<%--$('.s_content_right').addClass('content_right_fixed')--%>
							 <%--.css({right: ($(window).width()-1040)/2-17+'px'});--%>
                		<%--}--%>
                	}
                }
            }else {
                if(scrollTop == 0) {
                    $('#scrollTop').css({display:'none'});
                }
                if(scrollTop == 0) {
                	isFixed = false;
                	$('.s_content_right').removeClass('content_right_fixed');
                }
            }
            initTop = scrollTop;
        });

        if(isDesktop) {
            $('#scrollTop,#jbBtn').css({
                right: ($(window).width()-1040)/2-80+'px'
            });
        }

        $('#scrollTop').bind('click',function(){
            $('html,body').animate({scrollTop:0},500);
        });

        $('textarea[name="jubao_content"]').on('input propertychange', function(){
            var length = $(this).val().trim().length;
            $('#jbNum').text('还可输入'+(200-length)+'字');
        });

        $('textarea[name="jbMessage"]').on('input propertychange', function(){
            var length = $(this).val().trim().length;
            $('#jbMessageNum').text('还可输入'+(200-length)+'字');
        });

        $('textarea[name="me_content"]').on('input propertychange', function(){
            var length = $(this).val().trim().length;
            $('#memNum').text('还可输入'+(200-length)+'字');
        });


        $('textarea[name="mes_content"]').on('input propertychange', function(){
            var length = $(this).val().trim().length;
            $('#meNum').text('还可输入'+(200-length)+'字');
        });

        $(document).ready(function(){
            $.ajaxSetup ({
                cache: false //关闭AJAX缓存
            });
            //加载留言
            Evaluate.getMessage("<%=article.getId()%>","evaluate");

            var url = RESOUCE_SYSTEM_URL_JS+"/websiteconfig/getinfo";

            $.get(url,function(data){
                var obj = data.wc;
                $("meta[name='keywords']").attr("content",obj.keywords);
                $.ajax({ //获取logo
                    type: 'get',
                    url: '${RESOUCE_STATIC_URL}'+obj.logourl,
                    success: function(){
                        $("#logo").attr("src","${RESOUCE_STATIC_URL}"+"${qitalogourl}");
                    },
                    error: function(){

                    }
                });
            });

            $('#memBtn').bind('click',function(){
                var articleid = "<%=article.getId()%>";
                var content = $("textarea[name='me_content']").val();
                if(content == '' || content == null) return false;
                var url = "${RESOUCE_SYSTEM_URL}/message/add";

                $.post(url,{articleId:articleid,content:content},function(data){
                    var res = eval("("+data+")");
                    if(res.success){
                        $("textarea[name='me_content']").val('');
                        $('#memNum').text('还可输入200字');
                        $('.message').text('感谢您的留言，您的留言可以帮助其他用户').fadeIn();
                        setTimeout(function(){
                            $('.message').fadeOut();
                        },1500);
                        // $('.s_g_text').slideUp(500);
                        //加载留言
                        Evaluate.getMessage("<%=article.getId()%>","evaluate");
                    }
                });
            });

            $('#jbMessageBtn').bind('click',function(){
                var articleid = "<%=article.getId()%>";
                var content = $("textarea[name='jbMessage']").val();
                if(content == '' || content == null) return false;
                var url = "${RESOUCE_SYSTEM_URL}/jubao/add";

                $.post(url,{articleid:articleid,content:content},function(data){
                    var res = eval("("+data+")");
                    if(res.success){
                        $("textarea[name='jbMessage']").val('');
                        $('#jbMessageNum').text('还可输入200字');
                        $('.jbFrame').fadeOut();
                        $('.message').text('感谢您的举报信息，我们会尽快处理').fadeIn();
                        setTimeout(function(){
                            $('.message').fadeOut(500);
                        },3000);
                    }
                });
            });

            $("#btn_submit").bind('click',function(){

                var articleid = "<%=article.getId()%>";
                var content = $("textarea[name='jubao_content']").val();
                if(content == '' || content == null) return false;
                var url = "${RESOUCE_SYSTEM_URL}/jubao/add";

                $.post(url,{articleid:articleid,content:content},function(data){
                    var res = eval("("+data+")");
                    if(res.success){
                        $("textarea[name='jubao_content']").val('');
                        $('#jbNum').text('还可输入200字');
                        $('.message').text('感谢您的举报信息，我们会尽快处理').fadeIn();
                        setTimeout(function(){
                            $('.message').fadeOut();
                        },3000);
                    }
                });

            });

            $("#mes_submit").bind('click',function(){

                var articleid = "<%=article.getId()%>";
                var content = $("textarea[name='mes_content']").val();
                if(content == '' || content == null) return false;
                var url = "${RESOUCE_SYSTEM_URL}/message/add";

                $.post(url,{articleId:articleid,content:content},function(data){
                    var res = eval("("+data+")");
                    if(res.success){
                        $("textarea[name='mes_content']").val('');
                        $('#meNum').text('还可输入200字');
                        $('.message').text('感谢您的留言，您的留言可以帮助其他用户').fadeIn();
                        setTimeout(function(){
                            $('.message').fadeOut();
                        },3000);
                        //加载留言
                        Evaluate.getMessage("<%=article.getId()%>","evaluate");
                    }
                });
            });

            $('#showMessage').on('click',function(){
                $('.s_g_text').slideDown(500);
            });

            $('#jbBtn').on('click',function(){
                $('.jbFrame').fadeIn(500);
            });
        });

        //修正页面
        $('.content').css({
            minHeight: $(window).height() - 202 + 'px'
        });

        $(window).on('resize',function(){
            $('.content').css({
                minHeight: $(window).height() - 202 + 'px'
            });
            if(isDesktop) {
                $('#scrollTop,#jbBtn').css({
                    right: ($(window).width()-1040)/2-80+'px'
                });
            }
            <%--if(isFixed) {--%>
            	<%--$('.s_content_right').css({right: ($(window).width()-1040)/2-21+'px'});--%>
            <%--}--%>
        });

        $("#su").bind("click",function(){
            //获取要搜寻的关键字
            var keywords = $("#kw").val();
            if(keywords.trim() == '') {
                window.location.href = RESOUCE_SYSTEM_URL_JS + '/';
            } else {
                window.location.href="${RESOUCE_SYSTEM_URL}/article/list?keywords="+keywords;
            }
            return false;
        });
    </script>
</body>
</html>
