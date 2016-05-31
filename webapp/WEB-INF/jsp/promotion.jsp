<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
    <meta name="renderer" content="webkit" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>后台配置管理</title>
    <%@ include file="/resource.jsp" %>
    <!--<link rel="stylesheet" href="${RESOUCE_STATIC_URL}/lib/bootstrap-3.3.5-dist/css/bootstrap.css">
    <link rel="stylesheet" href="${RESOUCE_STATIC_URL}/css/style.css">-->
	
	<link rel="stylesheet" href="${RESOUCE_STATIC_URL}/css/search.css" />
    <link href="${RESOUCE_STATIC_URL}/umeditor/themes/default/css/umeditor.css" type="text/css" rel="stylesheet">
    <script type="text/javascript" src="${RESOUCE_STATIC_URL}/lib/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="${RESOUCE_STATIC_URL}/umeditor/umeditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="${RESOUCE_STATIC_URL}/umeditor/umeditor.min.js"></script>
    <script type="text/javascript" src="${RESOUCE_STATIC_URL}/umeditor/lang/zh-cn/zh-cn.js"></script>
	<style type="text/css">
		body {
			font-family: Arial, 'Microsoft Yahei', '微软雅黑', sans-serif;
		}
		h1 {
			margin: 0 0;
			font-size: 24px;
			font-weight: normal;
			line-height: 50px;
			padding-left: 115px;
		}
	</style>
</head>
<body>
	<div id="wrapper" class="wrapper_s">
        <div id="head">
            <div class="head_wrapper">
                <div class="s_form">
                    <div class="s_form_wrapper">
						<h1>后台配置管理-新增推广信息</h1>
                    </div>
                </div>
            </div>
        </div><!-- /head -->

        <div id="s_tab" class="s_tab">
            <a class="active" href="javascript:;">新增推广信息</a>
        </div><!-- /tab -->

		<div id="wrapper_wrapper">
            <div id="content-left" style="float:none;">
                <div id="container" class="container-l">
                    <div class="c-container" style="width:100%;">
                        <div class="c-row">
                            <form role="form" id="form2" action="" method="">
                                <div class="form-group">
									<label for="title">标题:</label>
									<input id="title" class="form-control" type="text" name="title" value="" onblur="testTitle()" maxLength="50">
                                    <span id="titleNum">还可输入50字</span>
                                </div>
								<div class="form-group">
									<label for="price">推广价格:</label>
									<input id="price" class="form-control" type="text" name="price" value="" onblur="testPrice()">
								</div>
                                <div class="form-group">
									<label for="url">网址链接:</label>
									<input id="url" class="form-control" type="text" name="url" value="" onblur="testUrl()" maxLength="100">
                                    <span id="urlNum">还可输入100字</span>
                                </div>
                                <div class="form-group">
									<!--style给定宽度可以影响编辑器的最终宽度-->
									<script type="text/plain" id="myEditor" name="content" style="width:840px;height:500px;">
									</script>
                                </div>
                                <div id="contentNum" style="margin-bottom:10px;">还可输入 <span>5000</span> 字</div>
                                <input type="hidden" id="img" name="imageurl" value=""/>

                                <button type="button" onclick="setImg()" class="btn btn-default" name="button">提交</button>
								<button type="button" onclick="backTO()" class="btn btn-default" name="button">取消</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
	</div>
    <div class="message"></div>
	<script type="text/javascript" src="${RESOUCE_STATIC_URL}/js/util/HtmlUtil.js"></script>
	<script type="text/javascript">
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
            var length = um.getPlainTxt().length-1;

            if(length > 5000) {
                $('#contentNum').html('您已超过<span style="color:#cc0000"> '+(length-5000)+' </span>字');
            } else {
                $('#contentNum').html('还可输入<span> '+(5000-length)+' </span>字');
            }
        });

        $('#title').focus();
		
		function testPrice() {
			var price = $('#price').val().trim();
			if(price == '' || price == null) {
				$('#price').addClass('error');
			} else {
				$('#price').removeClass('error');
			}
			if(isNaN(price)) {
				$('#price').addClass('error');
			} else {
				$('#price').removeClass('error');
			}
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
            var url = $('#url').val().trim();
            var regexp = new RegExp("(http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?", "gi");
            if(url.match(regexp) == null) {
                $('#url').addClass('error');
            } else {
                $('#url').removeClass('error');
            }
        }

        //实时文字长度限制
        $('#title').on('input propertychange', function(){
            var length = $(this).val().trim().length;
            $('#titleNum').text('还可输入'+(50-length)+'字');
        });

        $('#url').on('input propertychange', function(){
            var length = $(this).val().trim().length;
            $('#urlNum').text('还可输入'+(100-length)+'字');
        });

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
			
			var img = $('#img').val();

            var title = $("#title").val().trim();
            var url = $('#url').val().trim();
			var price = $('#price').val().trim();
            var regexp = new RegExp("(http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?", "gi");
            if(title == '' || title == null){
                $('#title').addClass('error');
                return false;
            }

            if(url.match(regexp) == null) {
                $('#url').addClass('error');
                return false;
            }
			
			if(price == '' || price == null) {
				$('#price').addClass('error');
				return false;
			}
			if(isNaN(price)) {
				$('#price').addClass('error');
				return false;
			} 

            if(UM.getEditor('myEditor').getPlainTxt().length > 4999) {
                return false;
            }
			var url = RESOUCE_SYSTEM_URL_JS+"/promotion/add";
			//$("#form1").submit();
			$.post(url,{price:price,content:UM.getEditor('myEditor').getContent(),imageurl:img,url:url,title:title},function(data){
                if(data.success) {
                    $('#title').val('');
                    $('#img').val('');
                    $('#url').val('');
                    $('#price').val('');
                    UM.getEditor('myEditor').setContent('<p style="color:#bbb;">还可输入5000字</p>');
                    isFirst = true;
                    $('#titleNum').text('还可输入50字');
                    $('#urlNum').text('还可输入100字');
                    $('#contentNum').html('还可输入 <span>5000</span> 字');
                }
                $('.message').text(data.msg).fadeIn();
                setTimeout(function(){
                    $('.message').fadeOut();
                },3000);
			});
		}

		//返回首页
		function backTO(){
			window.close();
		}
	</script>
</body>
</html>
