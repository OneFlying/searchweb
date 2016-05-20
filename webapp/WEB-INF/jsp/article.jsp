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
<title>书写文章</title>
<%@ include file="/resource.jsp" %>

<link rel="stylesheet" href="${RESOUCE_STATIC_URL}/lib/bootstrap-3.3.5-dist/css/bootstrap.css">
<link rel="stylesheet" href="${RESOUCE_STATIC_URL}/css/style.css">
<link href="${RESOUCE_STATIC_URL}/umeditor/themes/default/css/umeditor.css" type="text/css" rel="stylesheet">
<script type="text/javascript" src="${RESOUCE_STATIC_URL}/lib/jquery-1.11.1.min.js"></script>
<script type="text/javascript" charset="utf-8" src="${RESOUCE_STATIC_URL}/umeditor/umeditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${RESOUCE_STATIC_URL}/umeditor/umeditor.min.js"></script>
<script type="text/javascript" src="lang/zh-cn/zh-cn.js"></script>
<script type="text/javascript" src="${RESOUCE_STATIC_URL}/lib/bootstrap-3.3.5-dist/js/bootstrap.js"></script>
</head>
<body>

    <div class="container">
        <form role="form" action="${RESOUCE_SYSTEM_URL}/article/save" method="post">
            <div class="form-group">
                <label for="title">标题:</label>
                <input id="title" class="form-control" type="text" name="title" value="">
            </div>
            <div class="form-group">
                <label for="keywords">关键字:</label>
                <input id="keywords" class="form-control" type="text" name="keywords" value="">
            </div>
            <div class="form-group">
                <label for="website">网址链接:</label>
                <input id="website" class="form-control" type="text" name="website" value="">
            </div>

            <div class="form-group">
                <!--style给定宽度可以影响编辑器的最终宽度-->
                <script type="text/plain" id="myEditor" name="content" style="width:100%;height:300px;" >

                </script>
            </div>
            <input type="hidden" id="img" name="imageurl" value=""/>

            <button type="submit" onclick="setImg()" class="btn btn-default btn-primary btn-size" name="button">提交</button>
            <button type="button" onclick="back()" class="btn btn-default btn-primary btn-size" name="button">返回</button>
        </form>

    </div>

<script type="text/javascript" src="${RESOUCE_STATIC_URL}/js/util/xmlUtil.js"></script>
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
        });;

    }

    //返回首页
    function back(){
        window.location.href = "${RESOUCE_SYSTEM_URL}/index";
    }







</script>
</body>
</html>
