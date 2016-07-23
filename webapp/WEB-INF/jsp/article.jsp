<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
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
    <title>上传你的文章</title>
    <%@ include file="/resource.jsp" %>
    <link href="${RESOUCE_STATIC_URL}/umeditor/themes/default/css/umeditor.css" type="text/css" rel="stylesheet">
    <script type="text/javascript">
        var system = {};
        var p = navigator.platform;
            system.win = p.indexOf("Win") == 0; 
            system.mac = p.indexOf("Mac") == 0; 
            system.x11 = (p == "X11") || (p.indexOf("Linux") == 0);    
        var isDesktop = false;
        var head = document.getElementsByTagName('head')[0];
        var link = document.createElement('link');
        link.rel = 'stylesheet';
        link.type = 'text/css';
        if(system.win||system.mac){//如果是电脑
        	isDesktop = true;
            link.href = '${RESOUCE_STATIC_URL}/css/search.css';
        }else{  //如果是手机
            link.href = '${RESOUCE_STATIC_URL}/css/msearch.css';
        }
        head.appendChild(link);
    </script>
    <script type="text/javascript" src="${RESOUCE_STATIC_URL}/lib/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="${RESOUCE_STATIC_URL}/umeditor/umeditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="${RESOUCE_STATIC_URL}/umeditor/umeditor.min.js"></script>
    <script type="text/javascript" src="${RESOUCE_STATIC_URL}/umeditor/lang/zh-cn/zh-cn.js"></script>
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
                            <span class="tools" style="display:none;">
                                <a href="${RESOUCE_SYSTEM_URL}/article/index">上传你的文章</a>
                            </span>
                        </form>
                    </div>
                </div>
            </div>
        </div><!-- /head -->

        <div id="s_tab" class="s_tab">
            <a href="${RESOUCE_SYSTEM_URL}/">首页</a>
            <span>&gt;</span>
            <a href="#" class="active">上传你的文章</a>
        </div><!-- /tab -->

		<div id="wrapper_wrapper">
            <div id="content-left" style="float:none;">
                <div id="container" class="container-l">
                    <div class="c-container" style="width:100%;">
                        <div class="c-row">
                            <form role="form" id="form2" action="" method="">
                                <div class="form-group">
                                    <label for="title">标题：</label>
                                    <input id="title" placeholder="请输入标题" class="form-control" type="text" name="title" value="" onblur="testTitle()" maxLength="50">
                                    <span id="titleNum">还可输入50字</span>
                                </div>
                                <div class="form-group">
                                    <label for="website" style="font-size:14px;">相关网页链接：</label>
                                    <input id="website" placeholder="请输入网址链接" class="form-control" type="text" name="website" value="" onblur="testUrl()" maxLength="100">
                                    <span id="urlNum">还可输入100字</span>
                                </div>
                                <div class="form-group">
                                    <!--style给定宽度可以影响编辑器的最终宽度-->
                                    <script type="text/plain" id="myEditor" name="content" style="width:100%;height:500px;" ></script>
                                </div>
                                <div id="contentNum" style="margin-bottom:10px;">还可输入 <span>5000</span> 字</div>
                                <input type="hidden" id="img" name="imageurl" value=""/>
                                <div class="form-group">
                                    <input id="agree" checked="true" class="form-control" type="checkbox" name="agree" value=""/>
                                    <label for="agree" style="font-size:14px;width:auto;">我已经阅读并同意《百度用户使用协议》</label>
                                </div>
                                <button type="button" onclick="setImg()" class="btn btn-default" name="button">提交</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div id="footer">
                <span id="help">
                    <a id="setf" href="${RESOUCE_SYSTEM_URL}/law?param=flsm">免责声明</a>
                    <a id="seth" href="${RESOUCE_SYSTEM_URL}/law?param=lxwm">使用协议</a>
                    <a id="segy" href="${RESOUCE_SYSTEM_URL}/law?param=gywm">关于我们</a>
                </span>
            </div><!-- /footer -->
        </div>
	</div>
    <div class="message"></div>
	<script type="text/javascript" src="${RESOUCE_STATIC_URL}/js/util/HtmlUtil.js"></script>
    <script type="text/javascript">
        //实例化编辑器
        var isFirst = true;
        var um = UM.getEditor('myEditor');
        um.setContent('<p style="color:#bbb;">还可输入5000字</p>');
        um.addListener('blur',function(){
            if(um.getContent().trim().length == 0) {
                um.setContent('<p style="color:#bbb;">还可输入5000字</p>');
                $('#contentNum').html('还可输入 <span>5000</span> 字');
                isFirst = true;
            }
        });
        um.addListener('focus',function(){
            if(isFirst) {
                um.setContent('');
                isFirst = false;
            }
        });

        um.addListener('contentChange', function(){
            var length = um.getPlainTxt().length;

            if(length > 5000) {
                $('#contentNum').html('您已超过<span style="color:#cc0000"> '+(length-5000)+' </span>字');
            } else {
                $('#contentNum').html('还可输入<span> '+(5000-length)+' </span>字');
            }
        });

        $('#title').focus();

        function setImg() {

            if(!$("input[type='checkbox']").is(':checked')){
                alert("请先阅读《百度用户使用协议》并同意协议内容");
                return false;
            }

            var res = UM.getEditor('myEditor').getContent();

            var objE = document.createElement("div");

            objE.innerHTML = res;

            var obj = objE.childNodes;

            var rt = $(obj).find('img').each(function(index, el) {
                if(index == 0){
                    var path = $(el).attr("src");
                    $("#img").val(path);
                }
            });

            var img = $('#img').val();

            var res = $("#title").val().trim();
            var url = $('#website').val().trim();
            var regexp = new RegExp("(http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?", "gi");
            if(res == '' || res == null){
                $('#title').addClass('error');
                return false;
            }

            if(url != ""){
                if(url.match(regexp) == null) {
                    $('#website').addClass('error');
                    return false;
                }
            }


            if(UM.getEditor('myEditor').getPlainTxt().length > 5000) {
                return false;
            }

            //$("#form2").submit();
            $.post(RESOUCE_SYSTEM_URL_JS+'/article/save',{title:res,content:UM.getEditor("myEditor").getContent(),website:url,imageurl:img},function(data) {
                if(data.success) {
                    $('.message').text('上传文章成功').fadeIn();
                    setTimeout(function(){
                        $('.message').fadeOut();
                    },3000);
                    $('#title').val('');
                    $('#website').val('');
                    $('#titleNum').text('还可输入50字');
                    $('#urlNum').text('还可输入100字');
                    $('#img').val('');
                    UM.getEditor("myEditor").setContent('');
                }
            });
        }

        function testTitle() {
            var res = $("#title").val().trim();
            if(res == '' || res == null){
                $('#title').addClass('error');
            } else {
                $('#title').removeClass('error');
            }
        }

        function testUrl() {
            var url = $('#website').val().trim();
            var regexp = new RegExp("(http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?", "gi");
            if(url.match(regexp) == null) {
                $('#website').addClass('error');
            } else {
                $('#website').removeClass('error');
            }
        }

        //实时文字长度限制
        $('#title').on('input propertychange', function(){
            var length = $(this).val().trim().length;
            $('#titleNum').text('还可输入'+(50-length)+'字');
        });

        $('#website').on('input propertychange', function(){
            var length = $(this).val().trim().length;
            $('#urlNum').text('还可输入'+(100-length)+'字');
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

        var url = RESOUCE_SYSTEM_URL_JS+"/websiteconfig/getinfo";

        $.get(url,function(data){
            var obj = data.wc;
            $("meta[name='keywords']").attr("content",obj.keywords);
            //$("#jgwab").html('<i class="c-icon-jgwablogo"></i>'+obj.beianhao);备案号
            $.ajax({ //获取logo
                type: 'get',
                url: '${RESOUCE_STATIC_URL}'+obj.logourl,
                success: function(){
                    $("#result_logo>img").attr("src","${RESOUCE_STATIC_URL}"+"${qitalogourl}");
                },
                error: function(){

                }
            });
        });

        $('#kw').on('focus', function(){
            $('.s_ipt_wr').addClass('iptfocus');
        }).on('blur', function(){
            $('.s_ipt_wr').removeClass('iptfocus');
        });
        $("#su").on("click",function(){
            //获取要搜寻的关键字
            var keywords = $("#kw").val();
            if(keywords.trim() == '') {
                window.location.href = RESOUCE_SYSTEM_URL_JS + '/';
            } else {
                window.location.href="${RESOUCE_SYSTEM_URL}/article/list?keywords="+keywords;
            }
            return false;
        });

        $(document).ready(function(){
            $.ajaxSetup ({
                cache: false //关闭AJAX缓存
            });
        });
        <%--$(document).on('keyup',function(event) {--%>
            <%--event.preventDefault();--%>
            <%--if (event.keyCode == 13) {--%>
                <%--var keywords = $("#kw").val();--%>
                <%--if(keywords.trim() == '') {--%>
                    <%--window.location.href = RESOUCE_SYSTEM_URL_JS + '/';--%>
                <%--} else {--%>
                    <%--window.location.href="${RESOUCE_SYSTEM_URL}/article/list?keywords="+keywords;--%>
                <%--}--%>
            <%--}--%>
            <%--return false;--%>
        <%--});--%>
    </script>
</body>
</html>
