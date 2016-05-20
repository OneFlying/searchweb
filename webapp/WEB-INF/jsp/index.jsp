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
            <form>
                <input type="text" name="name" value="">
                <input id="btn" type="button" name="name" value="搜索一下">
                <span class="">
                    <a href="${RESOUCE_SYSTEM_URL}/article/index">上传文章</a>
                </span>
            </form>

        </div>
    </div>

</div>

<script type="text/javascript" src="${RESOUCE_STATIC_URL}/lib/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="${RESOUCE_STATIC_URL}/lib/bootstrap-3.3.5-dist/js/bootstrap.js"></script>
<script type="text/javascript">


    $("#btn").unbind('click');
    $("#btn").bind("click",function(){
        //获取要搜寻的关键字
        var keywords = $("input[type='text']").val();
        window.location.href="${RESOUCE_SYSTEM_URL}/article/list?keywords="+keywords;
    })
</script>
</body>
</html>
