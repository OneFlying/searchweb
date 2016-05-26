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

<link rel="stylesheet" href="${RESOUCE_STATIC_URL}/lib/bootstrap-3.3.5-dist/css/bootstrap.css">
<link rel="stylesheet" href="${RESOUCE_STATIC_URL}/css/style.css">
</head>
<body>

<div class="container">
    <!--logos-->
    <div class="row">
        <div class="logo">
            <img src="${RESOUCE_STATIC_URL}/img/index_logo.png"/>
        </div>
    </div>

    <!--搜索框-->
    <div class="row">
        <div class="index_form">
            <%-- <form> --%>
                <input type="text" value="">
                <a id="btn" href="#"><i class="glyphicon glyphicon-search"></i></a>
                <%-- <input id="btn" type="button" value="搜索一下"> --%>
                <span class="">
                    <a href="${RESOUCE_SYSTEM_URL}/article/index">上传文章</a>
                </span>
            <%-- </form> --%>
        </div>
    </div>

    <div class="row notice">
        <div class="text-center">
            <a href="${RESOUCE_SYSTEM_URL}/law?param=gywm">关于我们</a>|
            <a href="${RESOUCE_SYSTEM_URL}/law?param=lxwm">联系我们</a>|
            <a href="${RESOUCE_SYSTEM_URL}/law?param=flsm">法律声明</a>
            <%-- <span>&copy;2016 公司名称 沪ICP证1000000323号<i class="icr-logo"></i></span> --%>
            <span><i class="ba-logo"></i><span>沪公安网备100003232号</span></span>
        </div>
    </div>
</div>

<script type="text/javascript" src="${RESOUCE_STATIC_URL}/lib/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="${RESOUCE_STATIC_URL}/lib/bootstrap-3.3.5-dist/js/bootstrap.js"></script>
<script type="text/javascript" src="${RESOUCE_STATIC_URL}/js/util/CompatibleStyle.js"></script>
<script type="text/javascript" src="${RESOUCE_STATIC_URL}/js/util/keywords.js"></script>

<script type="text/javascript">
    $(document).ready(function(){
        Keywrods.getContent();

        /*兼容浏览器点击数据框outline*/
        CompStyle.lineStyle();

        var url = RESOUCE_SYSTEM_URL_JS+"/websiteconfig/getinfo";

        $.get(url,function(data){
            var obj = data.wc;
            $("title").text(obj.title);
            $(".ba-logo~span").text(obj.beianhao);
            $(".logo>img").attr("src","${RESOUCE_STATIC_URL}"+obj.logourl);
        });
    });
    $("#btn").bind("click",function(){
        //获取要搜寻的关键字
        var keywords = $("input[type='text']").val();
        window.location.href="${RESOUCE_SYSTEM_URL}/article/list?keywords="+keywords;
        return false;
    });
    $(document).on('keyup',function(event) {
    	event.preventDefault();
    	if (event.keyCode == 13) {
    		var keywords = $("input[type=text]").val();
            window.location.href="${RESOUCE_SYSTEM_URL}/article/list?keywords="+keywords;
    	}
    	return false;
    });
</script>
</body>
</html>
