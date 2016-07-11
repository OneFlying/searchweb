<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript">
	function clearAddWebservice(){
		$('#websitconfig_add_win').window('close');
	}
</script>
<style>
#webtable{
	border-collapse:separate;border-spacing:15px;
}
</style>
<div id="websitconfig_add_win" class="easyui-dialog" title="修改网站信息" style="width:350px;height:270px;background-color:rgba(0,0,0,0.09)"
        data-options="modal:true,closed:true,collapsible:false,minimizable:false,maximizable:false">
	<form enctype="multipart/form-data" class="easyui-form" id="websitconfig_add_form"  method="post" style="margin-top:20px">	
		<input type="hidden" name="id"/>
		<table id="webtable">
			<tr>
				<td>网站名称：</td>
				<td><input type="text" name="title" style="width:215px;"/></td>
			</tr>
			<tr>
				<td>网站关键字：</td>
				<td><input type="text" name="keywords" style="width:215px;"/></td>
			</tr>
			<tr>
				<td>网站备内容：</td>
				<td><input type="text" name="content" style="width:215px;"/></td>
			</tr>
			<tr>
				<td>网站备案号：</td>
				<td><input type="text" name="beianhao" style="width:215px;"/></td>
			</tr>		
		</table>	
	</form>
	<div style="text-align: center; padding: 5px;margin-top:10px">
		<a id="websitconfig_submit" class="easyui-linkbutton">提交</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearAddWebservice()">取消</a>
	</div>
</div>