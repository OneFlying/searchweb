<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript">
	function clearAddUser(){
		$('#user_add_win').window('close');
	}
</script>
<style>
#webtable{
	border-collapse:separate;border-spacing:15px;
}
</style>
<div id="user_add_win" class="easyui-dialog" title="修改网站信息" style="width:350px;height:250px;background-color:rgba(0,0,0,0.09)"
        data-options="modal:true,closed:true,collapsible:false,minimizable:false,maximizable:false">
	<form enctype="multipart/form-data" class="easyui-form" id="user_add_form"  method="post" style="margin-top:20px">	
		<input type="hidden" name="id"/>
		<table id="webtable">
			<tr>
				<td>用户名：</td>
				<td><input type="text" name="username" style="width:215px;"/></td>
			</tr>
			<tr>
				<td>密　码：</td>
				<td><input type="text" name="password" style="width:215px;"/></td>
			</tr>					
		</table>	
	</form>
	<div style="text-align: center; padding: 5px;margin-top:10px">
		<a id="user_submit" class="easyui-linkbutton">提交</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearAddUser()">取消</a>
	</div>
</div>