<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
<meta name="renderer" content="webkit" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>新增推广</title>
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
        <form role="form" id="form" action="${RESOUCE_SYSTEM_URL}/promotion/add" method="post">
            <div class="form-group">
                <label for="website">标题:</label>
                <input id="website" class="form-control" type="text" name="title" value="">
            </div>

            <div class="form-group">
                <label for="keywords">推广价格:</label>
                <input id="price" class="form-control" type="text" name="price" value="">
            </div>

            <div class="form-group">
                <label for="website">网址链接:</label>
                <input id="website" class="form-control" type="text" name="url" value="">
            </div>
            <div class="form-group">
                <!--style给定宽度可以影响编辑器的最终宽度-->
                <script type="text/plain" id="myEditor" name="content" style="width:100%;height:40%" id="content">

                </script>
            </div>
            <input type="hidden" id="img" name="imageurl" value=""/>
            <div align="center">
                <button type="button" onclick="setImg()" class="btn btn-default btn-primary btn-size" name="button">提交</button>
                <button type="button" onclick="backTO()" class="btn btn-default btn-primary btn-size" name="button">取消</button>
            <div>
        </form>

    </div>

<script type="text/javascript" src="${RESOUCE_STATIC_URL}/js/util/HtmlUtil.js"></script>
<script type="text/javascript">
    //实例化编辑器
    //action="${RESOUCE_SYSTEM_URL}/promotion/add"
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
       /* var price = $("#price").val();
        var url = $("#website").val();
        var content = $("#content").val();
        var imageurl = $("#img").val();*/
        /*var res = $("#title").val();

        if(!res){
            alert("请输入标题");
            return false;
        }*/
        //var url = RESOUCE_SYSTEM_URL_JS+"/index";

         $("#form").submit();
        /*$.post("${RESOUCE_SYSTEM_URL}/promotion/add",{price:price,url:url,content:content,imageurl:imageurl},function(data){
            if(data.success){
                alert(data.msg);
                location.href = RESOUCE_SYSTEM_URL_JS + data.url;
            }else{
                alert(data.msg);
                return;
            }
        });*/

    }

    //返回首页
    function backTO(){
        window.location.href = "${RESOUCE_SYSTEM_URL}/admin";
    }


</script>
</body>
</html>
