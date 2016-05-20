var WzjbglManager = {
		del:function(){
			var rows = $('#wzjbglgrid').datagrid('getChecked');
			if(rows.length<=0){
				$.messager.alert('提示','请选择进行删除！','info');
				return;
			}else{
				var idArry = new Array();
				$(rows).each(function(index,item){
					idArry.push(item.id);

				});
				$.messager.defaults={ok:"确定",cancel:"取消"}; 
				$.messager.confirm('温馨提示', '是否要删除该信息？', function(r){
					$.get(RESOUCE_SYSTEM_URL_JS+'/userlog/del',{ids:idArry},function(data){
						if(data.success){
							$.messager.alert('提示','删除成功','info');
							ManagerUserLog.reload();
						}else{
							$.messager.alert('警告','删除失败','warning');
						}
					});
				});
			}	
		},
/**
 * 加载表格数据
 */
loadgrid : function(){
	$('#wzjbglgrid').datagrid({
		queryParams:{//搜索条件
			operatime:"",
			content:"",
		},
		toolbar: [{
			text:'修改',
			iconCls: 'icon-edit',
			handler: function(){
				var rows = $('#wzjbglgrid').datagrid('getChecked');
				if(rows.length<=0 || rows.length>1){
					$.messager.alert('提示','请选择一个设备进行编辑！','info');
					return;
				}
				$('#websitconfig_add_win').window('open');
				$('#websitconfig_add_form').form('clear');
				$('#websitconfig_add_form').form('load',rows[0]);
				$('#websitconfig_submit').unbind('click');
				$('#websitconfig_submit').click(function(){
					alert('修改');
					});
				}
			}],
		singleSelect:false,
		selectOnCheck:true,
		fitColumns:true,
		autoRowHeight:true,
		pageSize:20,
		pageList:[5,10,15,20],
		striped:true,
		url:RESOUCE_SYSTEM_URL_JS+'/websiteconfig/page',
		method:'GET',
		columns:[[
		          {
		          	field:'id',title:'id',checkbox:true
		          },
		          {
		          	field:'title',title:'网站标题',width:40,align:'center',sortable:true
		          },
		          {
		        	field:'content',title:'上传logo',align:'center',width:90,
		        	formatter: function(value, row, index) { 
		        		return '<input type="button" id="uploadPic" onclick="uploadPic()" value="上传图片"/>';
		        	}
		          }
		          ]],
		          rownumbers:true,
		          pagination:true,
		          pagePosition:'bottom'
	});
	var page = $('#wzjbglgrid').datagrid('getPager');
	$(page).pagination({
		pageNumber:1,
		beforePageText: '第',//页数文本框前显示的汉字 
		afterPageText: '页    共 {pages} 页', 
		displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录', 
	});
},
reload:function(){//重新加载，保持在当前页
	$('#wzjbglgrid').datagrid('reload');
}
};
function uploadPic(){
	//alert('2345');
	$('#webconfig_add_win').window('open');
} 
