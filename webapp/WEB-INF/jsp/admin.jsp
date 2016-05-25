<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
    <meta name="renderer" content="webkit" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <%@ include file="/resource.jsp"%>
    <link rel="stylesheet" href="${RESOUCE_STATIC_URL}/lib/bootstrap-3.3.5-dist/css/bootstrap.css">
	<link rel="stylesheet" href="${RESOUCE_STATIC_URL}/css/style.css">
	<link href="${RESOUCE_STATIC_URL}/umeditor/themes/default/css/umeditor.css" type="text/css" rel="stylesheet">
	<script type="text/javascript" src="${RESOUCE_STATIC_URL}/lib/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" charset="utf-8" src="${RESOUCE_STATIC_URL}/umeditor/umeditor.config.js"></script>
	<script type="text/javascript" charset="utf-8" src="${RESOUCE_STATIC_URL}/umeditor/umeditor.min.js"></script>
	<script type="text/javascript" src="lang/zh-cn/zh-cn.js"></script>
	<script type="text/javascript" src="${RESOUCE_STATIC_URL}/lib/bootstrap-3.3.5-dist/js/bootstrap.js"></script>
  <!--   <link rel="stylesheet"
		href="${RESOUCE_STATIC_URL}/lib/bootstrap-3.0.3-dist/dist/css/bootstrap.min.css" /> -->
	<link rel="stylesheet" type="text/css"
		href="${RESOUCE_STATIC_URL}/lib/jquery-easyui-1.3.5/themes/default/easyui.css" />
	<link rel="stylesheet" type="text/css"
		href="${RESOUCE_STATIC_URL}/lib/jquery-easyui-1.3.5/themes/icon.css" />
	<link rel="stylesheet" type="text/css"
		href="${RESOUCE_STATIC_URL}/css/manager.css" />
	<script type="text/javascript"
		src="${RESOUCE_STATIC_URL}/lib/jquery-easyui-1.3.5/jquery.easyui.min.js"></script>
	<script type="text/javascript"
		src="${RESOUCE_STATIC_URL}/lib/jquery-easyui-1.3.5/jquery.easyui.extend.js"></script>
	<script type="text/javascript"
		src="${RESOUCE_STATIC_URL}/lib/jquery.uploadify.js"></script>
	<script type="text/javascript"
		src="${RESOUCE_STATIC_URL}/js/article.js"></script>
    <script type="text/javascript"
		src="${RESOUCE_STATIC_URL}/js/jubao.js"></script>
	<script type="text/javascript"
		src="${RESOUCE_STATIC_URL}/js/webconfig.js"></script>
	<script type="text/javascript"
		src="${RESOUCE_STATIC_URL}/js/promotion.js"></script>
    <script type="text/javascript"
		src="${RESOUCE_STATIC_URL}/js/advert.js"></script>
    <title>网站后台登录</title>
    <%@ include file="/resource.jsp" %>
   <style>
	input::-ms-clear {
		display: none;
	}
	/* body{
		margin: 0;
		border: 0;
		width:100%;
		height:100%;
		overflow:hidden;
		/* background: repeat-x url(../../static/img/backimg.png); */
		backgroud-color:red;
		position:absolute;
		font-family:"Helvetica Neue", Helvetica, Microsoft Yahei, Hiragino Sans GB, WenQuanYi Micro Hei, sans-serif;
		font-size:12px; color:#FFFFFF;
	} */
	h1{
		font-size:29px;
		color:gray;
		margin-left:10px;
		line-height:37px;
	}
</style>
<script type="text/javascript">
	//设置全局jquery的ajax都无缓存
	$.ajaxSetup({
		cache : false
	});

	$(function() {
		var logourl = "${logourl}";
		var tranlogourl = "${RESOUCE_STATIC_URL}"+logourl;
		$('#img').attr('src',tranlogourl);
		var title = "${title}";
		//alert(title);
		//alert($('#title').val());
		//动态菜单数据
		var treeData = [ {
			text : "管理模块",
			children : [
            {
				text : "网站基本管理",
				attributes : {
					url : "",
					type : 'WZJBGL'
				}
			}, {
				text : "文章管理",
				attributes : {
					url : "",
					type : 'WZGL'
				}
			}, {
				text : "举报管理",
				attributes : {
					url : "",
					type : 'JBGL'
				}
			}, {
				text : "推广管理",
				attributes : {
					url : "",
					type : 'TGGL'
				}
			},{
                text : "广告管理",
                attributes : {
                    url : "",
                    type : 'GGGL'
                }
            }
	       ]
       }];

		//实例化树形菜单
		$("#tree").tree({
			data : treeData,
			lines : true,
			onClick : function(node) {
				if (node.attributes) {
					Open(node.text, node.attributes.url, node.attributes.type);
				}
			}
		});
		//在右边center区域打开菜单，新增tab
		function Open(text, url, type) {
			if ($("#tabs").tabs('exists', text)) {
				$('#tabs').tabs('select', text);
			} else {
				switch (type) {
				case 'WZJBGL':
					$('#tabs')
							.tabs(
									'add',
									{
										title : text,
										closable : true,
										content : '<div id="wzjbglgrid" style="height:auto"></div>'

									});
					WzjbglManager.loadgrid();
					break;
				case 'WZGL':
					$('#tabs')
							.tabs(
									'add',
									{
										title : text,
										closable : true,
										content : '<div id="wzglgrid" style="height:auto;"></div>'
									});
					WzglManager.loadgrid();
					break;
				case 'JBGL':
					$('#tabs')
							.tabs(
									'add',
									{
										title : text,
										closable : true,
										content : '<div id="jbglgrid" style="height:auto;"></div>'
									});
					JbglManager.loadgrid();
					break;
				case 'TGGL':
					$('#tabs')
							.tabs(
									'add',
									{
										title : text,
										closable : true,
										content : '<div id="tgglgrid" style="height:auto;"></div>'
									});
					TgglManager.loadgrid();
					break;

                case 'GGGL':
                    $('#tabs')
							.tabs(
									'add',
									{
										title : text,
										closable : true,
										content : '<div id="ggglgrid" style="height:auto;"></div>'
									});
					GgglManager.loadgrid();
					break;
				case 'LOGOUT':
					$.get('${RESOUCE_SYSTEM_URL}/logout', function(data) {
						//location.reload(true);
					});
					break;
				default:
					break;
				}

			}

		}

		//绑定tabs的右键菜单
		$("#tabs").tabs({
			onContextMenu : function(e, title) {
				e.preventDefault();
				$('#tabsMenu').menu('show', {
					left : e.pageX,
					top : e.pageY
				}).data("tabTitle", title);
			}
		});

		//实例化menu的onClick事件
		$("#tabsMenu").menu({
			onClick : function(item) {
				CloseTab(this, item.name);

			}
		});

		//几个关闭事件的实现
		function CloseTab(menu, type) {
			var curTabTitle = $(menu).data("tabTitle");
			var tabs = $("#tabs");

			if (type === "close") {
				tabs.tabs("close", curTabTitle);
				return;
			}

			var allTabs = tabs.tabs("tabs");
			var closeTabsTitle = [];

			$.each(allTabs, function() {
				var opt = $(this).panel("options");
				if (opt.closable && opt.title != curTabTitle
						&& type === "Other") {
					closeTabsTitle.push(opt.title);
				} else if (opt.closable && type === "All") {
					closeTabsTitle.push(opt.title);
				}
			});

			for ( var i = 0; i < closeTabsTitle.length; i++) {
				tabs.tabs("close", closeTabsTitle[i]);
			}
		}
	});
</script>
</head>
<body class="easyui-layout" ondragstart="return false;">
	<div region="north" class="north" title="">
		<div class="north-title">
			<img id="img" alt="" src="">
			<span id="title">网站后台管理</span>
		</div>

		 <div class="north-logout">
            <a href="${RESOUCE_SYSTEM_URL}/logout" >
                <img src="${RESOUCE_STATIC_URL}/img/logout.png"/>
                <span>退出</span>
            </a>
        </div>
	</div>
	<div region="center" title="内容">
		<div class="easyui-tabs" fit="true" border="false" id="tabs">
			<div title="首页"></div>
		</div>
	</div>
	<div region="west" class="west" title="菜单">
		<ul id="tree"></ul>
	</div>

	<div id="tabsMenu" class="easyui-menu" style="width:120px;">
		<div name="close">关闭</div>
		<div name="Other">关闭其他</div>
		<div name="All">关闭所有</div>
	</div>
	<%@ include file="/manager/webconfig.jsp"%>
	<%@ include file="/manager/websiteconfig.jsp"%>
    <%@ include file="/manager/upload.jsp"%>

</body>
</html>
