<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript">



	function clearAddAdvert(){
		$('#advert_add_win').window('close');
	}


	//添加终端
	function addAdvert(){
		//var ip=$('#ip1').val();
		//var bool = $('#device_add_form').form('validate');
		// var area = $('#fayuannum1').attr('value');
		// var username = $('#username').val();
		// var phone = $('#telphone').val();
		//alert(checkPhone(phone));
		//alert(ip);
		var title = $("#title_").val();
		var desc = $("#desc").val();
		var adurl = $("#adurl").val();
		var price = $("#price").val();
		var logourl = $("#logourl").val();

		if(title != ""){
			if(desc != ""){
				if(adurl !=""){
					if(price != ""){
						if(logourl != ""){
							$('#advert_add_form').form('submit',{
								url:'${RESOUCE_SYSTEM_URL}/advert/add',
								success:function(data){
									//console.log(data);

									var dataJson = eval('(' + data + ')');
										if(dataJson.success == true){
											$('#advert_add_win').window('close');
											GgglManager.loadgrid();
										}else{
											$.messager.alert('提示',dataJson.msg,'info');
										}
									}
							});
						}else{
							$.messager.alert('提示','请上传广告logo','info');
						}
					}else{
						$.messager.alert('提示','请填写价格','info');
					}
				}else{
					$.messager.alert('提示','请填写广告链接网址','info');
				}
			}else {
				$.messager.alert('提示','请填写广告描述','info');
			}
		}else{
			$.messager.alert('提示','请填写广告标题','info');
		}

	}

	function uploadLogo(){

		 var formData = new FormData($("#advert_logo")[0]);
		 var url= "${RESOUCE_SYSTEM_URL}/advert/upload";
	     $.ajax({
	          url: url,
	          type: 'POST',
	          data: formData,
	          async: false,
	          cache: false,
	          contentType: false,
	          processData: false,
	          success: function (data) {
	              $("#logourl").val(RESOUCE_STATIC_URL_JS+data.logourl);
				  $("#advertlogo_add_win").window('close');
	          }
	     });
	}
</script>
<div id="advertlogo_add_win" class="easyui-dialog" title="上传图片" style="width:340px;height:100px;background-color:rgba(0,0,0,0.09)"
        data-options="modal:true,closed:true,collapsible:false,minimizable:false,maximizable:false">
	<form id="advert_logo" enctype="multipart/form-data" class="easyui-form"  method="post" style="margin-top:20px">
		<input type="file" name="pic" id="filepath" style="float:left;height:30px;margin-left:10px"/>
		<input type="button" onclick="uploadLogo()" value="上传" style="float:left;height:30px"/>
	</form>
</div>

<div id="advert_add_win" class="easyui-dialog" title="修改广告信息" style="width:390px;height:300px;background-color:rgba(0,0,0,0.09)"
        data-options="modal:true,closed:true,collapsible:false,minimizable:false,maximizable:false">
	<form class="easyui-form" id="advert_add_form"  method="post" style="margin-top:20px">
		<table 	id="webtable">
			<tr>
				<td>广告标题：</td>
				<td><input id="title_" type="text" name="title" value="" style="width:210px;margin-left:10px"/></td>
			</tr>
			<tr style="margin-top:10px;">
				<td>广告描述：</td>
				<td><input id="desc" type="text" name="desc" value="" style="width:210px;margin-left:10px"/></td>
			</tr>
			<tr>
				<td>广告网址：</td>
				<td><input id="adurl" type="text" name="adurl" value="" style="width:210px;margin-left:10px"/></td>
			</tr>
			<tr>
				<td>广告价格：</td>
				<td><input id="price" type="text" name="price" value="" style="width:210px;margin-left:10px"/></td>
			</tr>
		</table>
		<input id="logourl" type="hidden" name="logourl" value=""/>

	</form>
	<div style="text-align: center; padding: 5px;margin-top:10px">
		<a id="advert_submit" class="easyui-linkbutton">提交</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearAddAdvert()">取消</a>
	</div>
</div>
