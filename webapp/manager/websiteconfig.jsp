<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div id="websitconfig_add_win" class="easyui-dialog" title="修改网站名称" style="width:290px;height:140px;background-color:rgba(0,0,0,0.09)"
        data-options="modal:true,closed:true,collapsible:false,minimizable:false,maximizable:false">
	<form enctype="multipart/form-data" class="easyui-form" id="websitconfig_add_form"  method="post" style="margin-top:20px">	
		<tr>
			<td>网站名称：</td>
		</tr>
		<tr>
			<td><input type="text" name="title" style="30px;margin-left:10px"/></td>
		</tr>
				
	</form>
	<div style="text-align: center; padding: 5px;margin-top:10px">
		<a id="websitconfig_submit" class="easyui-linkbutton">提交</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearAddWebservice()">取消</a>
	</div>
</div>