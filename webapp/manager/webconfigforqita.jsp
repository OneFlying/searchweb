<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div id="webconfigfor_add_win" class="easyui-dialog" title="上传图片" style="width:340px;height:140px;background-color:rgba(0,0,0,0.09)"
        data-options="modal:true,closed:true,collapsible:false,minimizable:false,maximizable:false">
	<form enctype="multipart/form-data" class="easyui-form" action="${RESOUCE_SYSTEM_URL}/img/uploadqita" method="post" style="margin-top:20px;height:60px;">
			<input type="file" name="pic" id="filepath" style="float:left;height:30px;margin-left:10px"/>
			<input type="submit" value="上传" style="float:left;height:30px"/>
	</form>
	<span style="font-size:12px;color:red">尺寸不超过350*109</span>
</div>
