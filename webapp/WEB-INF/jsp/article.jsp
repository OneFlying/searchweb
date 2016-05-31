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
    <title>上传你的文章</title>
    <%@ include file="/resource.jsp" %>
    <link href="${RESOUCE_STATIC_URL}/umeditor/themes/default/css/umeditor.css" type="text/css" rel="stylesheet">
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
                        <a id="result_logo" onclick="window.history.go(-1);">
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
            <a class="active" href="javascript:;" onclick="window.history.go(-1);">首页</a>
            <span>&gt;</span>
            <a href="#">上传你的文章</a>
        </div><!-- /tab -->

		<div id="wrapper_wrapper">
            <div id="content-left" style="float:none;">
                <div id="container" class="container-l">
                    <div class="c-container" style="width:100%;">
                        <div class="c-row">
                            <form role="form" id="form2" action="${RESOUCE_SYSTEM_URL}/article/save" method="post">
                                <div class="form-group">
                                    <label for="title">标题：</label>
                                    <input id="title" placeholder="请输入标题" class="form-control" type="text" name="title" value="">
                                </div>
                                <div class="form-group">
                                    <label for="website" style="font-size:14px;">网址链接：</label>
                                    <input id="website" placeholder="请输入网址链接" class="form-control" type="text" name="website" value="">
                                </div>
                                <div class="form-group">
                                    <!--style给定宽度可以影响编辑器的最终宽度-->
                                    <script type="text/plain" id="myEditor" name="content" style="width:840px;height:500px;" ></script>
                                </div>
                                <input type="hidden" id="img" name="imageurl" value=""/>

                                <button type="button" onclick="setImg()" class="btn btn-default" name="button">提交</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div id="footer">
                <span id="help">
                    <a id="seth" href="${RESOUCE_SYSTEM_URL}/law?param=lxwm">使用协议</a>
                    <a id="setf" href="${RESOUCE_SYSTEM_URL}/law?param=flsm">免责声明</a>
                    <a id="segy" href="${RESOUCE_SYSTEM_URL}/law?param=gywm">关于我们</a>
                </span>
            </div><!-- /footer -->
        </div>
	</div>
	<script type="text/javascript" src="${RESOUCE_STATIC_URL}/js/util/HtmlUtil.js"></script>
    <script type="text/javascript">
        //实例化编辑器
        var um = UM.getEditor('myEditor');
        um.addListener('blur',function(){
            $('#focush2').html('编辑器失去焦点了')
        });
        um.addListener('focus',function(){
            $('#focush2').html('')
        });
        var res = um.getContent();

        //alert(res);
        function setImg() {
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

            var res = $("#title").val();

            if(!res){
                alert("请输入标题");
                return false;
            }
            //var url = RESOUCE_SYSTEM_URL_JS+"/index";

            $("#form2").submit();

        }

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
                    $("#result_logo>img").attr("src","${RESOUCE_STATIC_URL}"+obj.logourl);
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
