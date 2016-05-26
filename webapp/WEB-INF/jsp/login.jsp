<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
    <meta name="renderer" content="webkit" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="keywords" content=""/>
    <title>网站系统</title>
    <%@ include file="/resource.jsp"%>
    <link rel="stylesheet" href="${RESOUCE_STATIC_URL}/lib/bootstrap-3.0.3-dist/dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" type="text/css" href="${RESOUCE_STATIC_URL}/css/style_new.css" />
</head>
<body>
    <div class="login">
        <div class="login_content">
            <div class="login_content_header">
               	 后台管理
            </div>
            <div class="login_content_form">
                <form role="form" action="" method="">
                    <div class="login_section">
                        <input type="text" placeholder="请输入用户名" id="username" name="username" />
                    </div>
                    <div class="login_section">
                        <input type="password" placeholder="请输入密码" id="password" name="password" />
                    </div>
                    <button type="button" onclick="Login.login();">登&nbsp;&nbsp;录</button>
                </form>
            </div>
        </div>
    </div>
    <!-- lib -->
    <script type="text/javascript" src="${RESOUCE_STATIC_URL}/lib/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="${RESOUCE_STATIC_URL}/lib/jquery.cookie-1.4.1.min.js"></script>

    <script type="text/javascript" src="${RESOUCE_STATIC_URL}/js/login.js"></script>
    <script type="text/javascript" src="${RESOUCE_STATIC_URL}/js/util/keywords.js"></script>

    <script type="text/javascript">
    	$(function(){
            Keywrods.getContent();
    		var logourl = "${logourl}";
    		//alert(logourl);
    		var tranlogourl = "${RESOUCE_STATIC_URL}"+logourl;
    		$('#img').attr('src',tranlogourl);
    	});
    </script>
</body>
</html>
