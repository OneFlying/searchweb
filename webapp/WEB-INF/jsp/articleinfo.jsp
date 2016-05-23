<%@page import="com.yf.model.Article"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
<meta name="renderer" content="webkit" />
<meta name="viewport" content="width=device-width, initial-scale=1.0,maximum-scale=1, user-scalable=no">
<%
	Article article = (Article)request.getAttribute("article");

%>
<title><%=article.getTitle() %></title>
<%@ include file="/resource.jsp" %>


<link rel="stylesheet" href="${RESOUCE_STATIC_URL}/lib/bootstrap-3.3.5-dist/css/bootstrap.css">
<link rel="stylesheet" href="${RESOUCE_STATIC_URL}/lib/fancybox/jquery.fancybox.css">
<link rel="stylesheet" href="${RESOUCE_STATIC_URL}/css/style.css">
<script type="text/javascript" src="${RESOUCE_STATIC_URL}/lib/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="lang/zh-cn/zh-cn.js"></script>
<script type="text/javascript" src="${RESOUCE_STATIC_URL}/lib/fancybox/jquery.fancybox.js"></script>
<script type="text/javascript" src="${RESOUCE_STATIC_URL}/lib/bootstrap-3.3.5-dist/js/bootstrap.js"></script>
</head>
<body>
    <%-- <div class="">
        <a href="${RESOUCE_SYSTEM_URL}/index">返回</a>
    </div> --%>
    <div class="navbar navbar-default" style="padding-bottom: .3em;">
        <a style="margin-left:12.5%;" class="nav-brand-logo" href="${RESOUCE_SYSTEM_URL}/">
            <img src="${RESOUCE_STATIC_URL}/img/index_logo.png"/>
        </a>
        <span class="search_form">
            <input type="text" name="name" value="">
            <a id="btn" href="#"><i class="glyphicon glyphicon-search"></i></a>
        </span>
    </div>

    <div class="container info-container">
        <div class="row">
            <div class="info-title">
                <%=article.getTitle() %>
            </div>
        </div>
        <div class="row">
            <hr/>
        </div>
        <div class="row">
            <div id="article_content" class="">
                <%=article.getContent()%>
            </div>
        </div>
    </div>

    <div class="navbar navbar-default navbar-bottom content-navbar-bottom">
        <div class="container">
            <div class="row">
                <a id="modal" class="content-jubao" href="#inline1">举报</a>

                <div id="inline1" style="width:500px;height:300px;display: none;">
            		<textarea name="jubao_content" rows="12" cols="79"></textarea>
                    <a id="btn_submit">提交</a>
            	</div>
            </div>
        </div>
    </div>

<script type="text/javascript" src="${RESOUCE_STATIC_URL}/js/util/HtmlUtil.js"></script>
<script type="text/javascript">

    $(document).ready(function(){
        $("#modal").fancybox({
            'hideOnContentClick': true
        });


        $("#btn_submit").unbind('click');
        $("#btn_submit").bind('click',function(){

            var articleid = "<%=article.getId()%>";
            var content = $("textarea[name='jubao_content']").val();
            var url = "${RESOUCE_SYSTEM_URL}/jubao/add";

            $.post(url,{articleid:articleid,content:content},function(data){
                var res = eval("("+data+")");
                if(res.success){
                    $.fancybox.close();
                }
            });

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
