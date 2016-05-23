var WzglManager = {
		del:function(){
			var rows = $('#wzglgrid').datagrid('getChecked');
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
					$.get(RESOUCE_SYSTEM_URL_JS+'/article/delete',{ids:idArry},function(data){
						if(data.success){
							$.messager.alert('提示','删除成功','info');
							WzglManager.reload();
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
	$('#wzglgrid').datagrid({
		queryParams:{//搜索条件
			operatime:"",
			content:"",
		},
		toolbar: [
		{
				text:'删除',
				iconCls: 'icon-remove',
				handler: function(){
					//$('#device_delete_win').window('open');
					WzglManager.del();
				}

		},'-',
		{
			text:'文章标题：<input class="easyui-textbox" type="text" style="margin-top: -2px;" id="article-content" value="" placeholder="请输入关键字" style="line-height:15px"/>',
		},{
			text:'查询',
			iconCls: 'icon-search',
			handler: function(){
				var content = $('#article-content').val();
				$('#wzglgrid').datagrid('load',{title:content});
			}
		},'-',
		{
			text:'关键字：<input class="easyui-textbox" type="text" id="article-key" style="margin-top: -2px;" value="" placeholder="请输入关键字" style="line-height:15px"/>',
		},{
			text:'查询',
			iconCls: 'icon-search',
			handler: function(){
				var keywords = $('#article-key').val();
				$('#wzglgrid').datagrid('load',{keywords:keywords});
			}
		},'-',{
			text:'返回',
			iconCls:'icon-back',
			handler:function(){
				$('#wzglgrid').datagrid('load',{operatime:"",content:""});
			}
		}],
		singleSelect:false,
		selectOnCheck:true,
		fitColumns:true,
		autoRowHeight:true,
		pageSize:20,
		pageList:[5,10,15,20],
		striped:true,
		url:RESOUCE_SYSTEM_URL_JS+'/article/page',
		method:'GET',
		columns:[[
		          {
		          	field:'id',title:'id',checkbox:true
		          },
		          {
		          	field:'title',title:'<font color="black" size="2px">文章标题</font>',width:40,align:'center',sortable:true,
		          	 formatter : function(value,row,index){
				        return '<font color="black" size="2px" >'+value+'</font>';
				      }
		          },
		          {
		        	field:'keywords',title:'<font color="black" size="2px">关键字</font>',align:'center',width:40,
		        	 formatter : function(value,row,index){
				        return '<font color="black" size="2px" >'+value+'</font>';
				      }
		          },
		          {
		          	field:'website',title:'<font color="black" size="2px">链接网址</font>',width:30,align:'center',sortable:true,
		          	 formatter : function(value,row,index){
				        return '<font color="black" size="2px" >'+value+'</font>';
				      }
				  }
		          ]],
		          rownumbers:true,
		          pagination:true,
		          pagePosition:'bottom'
	});
	var page = $('#wzglgrid').datagrid('getPager');
		$(page).pagination({
		pageNumber:1,
		beforePageText: '<font color="black" size="2px" >第</font>',//页数文本框前显示的汉字 
		afterPageText: '<font color="black" size="2px" >页    共 {pages} 页</font>', 
		displayMsg: '<font color="black" size="2px" >当前显示 {from} - {to} 条记录   共 {total} 条记录</font>', 
	});
},
reload:function(){//重新加载，保持在当前页
	$('#wzglgrid').datagrid('reload');
}

};
