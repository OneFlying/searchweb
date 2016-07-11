var ZhglManager = {
/*clearAddWebservice:function(){
	$('#websitconfig_add_win').window('close');
},*/
	/**
	 * 加载表格数据
	 */
	loadgrid : function(){
		$('#zhglgrid').datagrid({
			queryParams:{//搜索条件
				operatime:"",
				content:"",
			},
			toolbar: [{
				text:'修改',
				iconCls: 'icon-edit',
				handler: function(){
					var rows = $('#zhglgrid').datagrid('getChecked');
					if(rows.length<=0 || rows.length>1){
						$.messager.alert('提示','请选择一个设备进行编辑！','info');
						return;
					}
					$('#user_add_win').window('open');
					$('#user_add_form').form('clear');
					$('#user_add_form').form('load',rows[0]);
					$('#user_submit').unbind('click');
					$('#user_submit').click(function(){
						$('#user_add_form').form('submit',{
							url:RESOUCE_SYSTEM_URL_JS+'/user/update',
							success:function(data){
								var dataJson = eval('(' + data + ')');
								if(dataJson.success == true){
									$('#user_add_win').window('close');
									ZhglManager.reload();
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
			url:RESOUCE_SYSTEM_URL_JS+'/user/page',
			method:'GET',
			columns:[[
			          {
			          	field:'id',title:'id',checkbox:true
			          },
			          {
			          	field:'username',title:'<font color="black" size="2px">用户名</font>',width:40,align:'center',sortable:true,
			          	formatter : function(value,row,index){
					        return '<font color="black" size="2px" >'+value+'</font>';
					      }
			          },
			          {
			          	field:'password',title:'<font color="black" size="2px">密　码</font>',width:40,align:'center',sortable:true,
			          	formatter : function(value,row,index){
					        return '<font color="black" size="2px" >'+value+'</font>';
					      }
			          }
			         
			          ]],
			          rownumbers:true,
			          pagination:true,
			          pagePosition:'bottom'
		});
		var page = $('#zhglgrid').datagrid('getPager');
		$(page).pagination({
			pageNumber:1,
			beforePageText: '<font color="black" size="2px" >第</font>',//页数文本框前显示的汉字
			afterPageText: '<font color="black" size="2px" >页    共 {pages} 页</font>',
			displayMsg: '<font color="black" size="2px" >当前显示 {from} - {to} 条记录   共 {total} 条记录</font>',
		});
	},
	reload:function(){//重新加载，保持在当前页
		$('#zhglgrid').datagrid('reload');
	}
};

