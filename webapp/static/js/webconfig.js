var WzjbglManager = {
/*clearAddWebservice:function(){
	$('#websitconfig_add_win').window('close');
},*/
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
					$('#websitconfig_add_form').form('submit',{
						url:RESOUCE_SYSTEM_URL_JS+'/websiteconfig/update',
						success:function(data){
							var dataJson = eval('(' + data + ')'); 
							if(dataJson.success == true){
								$('#websitconfig_add_win').window('close');
								WzjbglManager.reload();
							}else{
								$.messager.alert('提示',dataJson.msg,'info');
							}
						}
					});
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
		          	field:'title',title:'<font color="black" size="2px">网站标题</font>',width:40,align:'center',sortable:true,
		          	formatter : function(value,row,index){
				        return '<font color="black" size="2px" >'+value+'</font>';
				      }
		          },
		          {
		        	field:'content',title:'<font color="black" size="2px">上传logo</font>',align:'center',width:90,
		        	formatter: function(value, row, index) { 
		        		return '<input type="button" id="uploadPic" onclick="uploadPic()" style="height:27px;width:70px;font-size:12px;line-height:0px;margin-top:-7px;color:black" value="上传图片"/>';
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
		beforePageText: '<font color="black" size="2px" >第</font>',//页数文本框前显示的汉字 
		afterPageText: '<font color="black" size="2px" >页    共 {pages} 页</font>', 
		displayMsg: '<font color="black" size="2px" >当前显示 {from} - {to} 条记录   共 {total} 条记录</font>', 
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
