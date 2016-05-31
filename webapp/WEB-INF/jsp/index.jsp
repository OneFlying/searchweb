<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.yf.utils.KeyWordUtil"%>
<%
    KeyWordUtil keyUtil = KeyWordUtil.getInstance();
    String keywordsContent = keyUtil.getContent();
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
    <meta name="renderer" content="webkit" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0,maximum-scale=1, user-scalable=no">
    <meta name="keywords" content="<%=keywordsContent%>"/>
    <meta name="description" content="" />
    <title>仿百度搜索</title>
    <%@ include file="/resource.jsp" %>
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
            link.href = '${RESOUCE_STATIC_URL}/css/main.css';
        }else{  //如果是手机
            link.href = '${RESOUCE_STATIC_URL}/css/mobile.css';
        }
        head.appendChild(link);
    </script>
    <!--[if lte IE 8]>
        <style index="index" >
            .s_form {  top: 260px  }
        </style>
    <![endif]-->
    <!--[if IE 8]>
        <style index="index" >
            #u1 a.mnav,#u1 a.mnav:visited,#u1 a.lb,#u1 a.lb:visited,#u1 a.pf,#u1 a.pf:visited,#u1 a.bri,#u1 a.bri:visited {
                font-family: simsun
            }
        </style>
    <![endif]-->
</head>
<body>
    <div id="wrapper" style="display:block;">
        <div id="head" class="s_down">
            <div class="head_wrapper">
                <div class="s_form">
                    <div class="s_form_wrapper">
                        <div id="lg">
                            <img hidefocus="true" src="${RESOUCE_STATIC_URL}/img/bd_logo1.png" width="270" height="129">
                        </div>
                        <form id="form" name="f" action="" class="fm" onsubmit="return false;">
                            <span class="bg s_ipt_wr">
                                <input id="kw" name="wd" class="s_ipt" value="" maxlength="255" autocomplete="off" title="" />
                            </span>
                            <span class="bg s_btn_wr">
                                <button id="su" class="bg s_btn"><span class="glyphicon glyphicon-search"></span></button>
                            </span>
                        </form>
                        <div id="m">
                            <a href="${RESOUCE_SYSTEM_URL}/article/index">上传你的文章</a>
                        </div>
                    </div>
                </div>
            </div>
            <div id="ftCon">
                <div class="ftCon-Wrapper">
                    <div id="ftConw">
                        <p id="lh">
                            <a id="seth" href="${RESOUCE_SYSTEM_URL}/law?param=lxwm">使用协议</a>
                            <a id="setf" href="${RESOUCE_SYSTEM_URL}/law?param=flsm">免责声明</a>
                            <a id="segy" href="${RESOUCE_SYSTEM_URL}/law?param=gywm">关于我们</a>
                        </p>
                        <p id="cp">
                            &copy;&nbsp;xx.com 2016
                            <%--<a href="">使用百度前必读</a>&nbsp;
                            <a href="">意见反馈</a>&nbsp;
                            京ICP证030173号&nbsp;
                            <i class="c-icon-icrlogo"></i>--%>
                        </p>
                        <%--<p id="jgwab">
                            <i class="c-icon-jgwablogo"></i>
                            京公网安备11000002000001号
                        </p>--%>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript" src="${RESOUCE_STATIC_URL}/lib/jquery-1.11.1.min.js"></script>
    <script type="text/javascript">
        (function(){
            if(!system.win && !system.mac && !system.x11){//如果是手机，隐藏上传链接
                $('#m').css({display:'none'});
                $('#lg>img').attr({width:'175',height:'55'});
            }
            $('#kw').focus();   //搜索框默认获取焦点
            $('.s_ipt_wr').addClass('iptfocus');

            var url = RESOUCE_SYSTEM_URL_JS+"/websiteconfig/getinfo";

            $.get(url,function(data){
                var obj = data.wc;
                $("title").text(obj.title);
                $("meta[name='keywords']").attr("content",obj.keywords);
                //$("#jgwab").html('<i class="c-icon-jgwablogo"></i>'+obj.beianhao);备案号
                $.ajax({ //获取logo
                    type: 'get',
                    url: '${RESOUCE_STATIC_URL}'+obj.logourl,
                    success: function(){
                        $("#lg>img").attr("src","${RESOUCE_STATIC_URL}"+obj.logourl);
                    },
                    error: function(){
                        if(!system.win && !system.mac && !system.x11){
                            $('#lg>img').attr({'src':'${RESOUCE_STATIC_URL}/img/plus_logo.png'});
                        }
                    }
                });
            });
        })();
        $('#kw').on('focus', function(){
            $('.s_ipt_wr').addClass('iptfocus');
        }).on('blur', function(){
            $('.s_ipt_wr').removeClass('iptfocus');
        });
        $("#su").on("click",function(){
            //获取要搜寻的关键字
            var keywords = $("#kw").val();
            window.location.href="${RESOUCE_SYSTEM_URL}/article/list?keywords="+keywords;
            return false;
        });
        $(document).on('keyup',function(event) {
            event.preventDefault();
            if (event.keyCode == 13) {
                var keywords = $("#kw").val();
                window.location.href="${RESOUCE_SYSTEM_URL}/article/list?keywords="+keywords;
            }
            return false;
        });
    </script>
</body>
</html>
