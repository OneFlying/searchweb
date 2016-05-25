<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
<meta name="renderer" content="webkit" />
<meta name="viewport" content="width=device-width, initial-scale=1.0,maximum-scale=1, user-scalable=no">
<title>法律声明</title>
<%@ include file="/resource.jsp" %>

<link rel="stylesheet" href="${RESOUCE_STATIC_URL}/lib/bootstrap-3.3.5-dist/css/bootstrap.css">
<link rel="stylesheet" href="${RESOUCE_STATIC_URL}/css/style.css">
</head>
<body>

<div class="container law-container">
    <div class="row">
        <div class="col-xs-12 col-sm-4 col-md-4 text-right">
            <img src="" alt="" />
        </div>
        <div class="col-xs-12 col-sm-8 col-md-8">
            <div class="law-content">
                <span>法律声明</span>
                
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="${RESOUCE_STATIC_URL}/lib/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="${RESOUCE_STATIC_URL}/lib/bootstrap-3.3.5-dist/js/bootstrap.js"></script>
<script type="text/javascript">
    $(document).ready(function(){

        var url = RESOUCE_SYSTEM_URL_JS+"/websiteconfig/getinfo";

        $.get(url,function(data){
            var obj = data.wc;
            //$("title").text(obj.title);
            $("img").attr("src","${RESOUCE_STATIC_URL}"+obj.logourl);
        });
    });
</script>
</body>
</html>
