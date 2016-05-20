var JbglManager = {
		del:function(){
			var rows = $('#jbglgrid').datagrid('getChecked');
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
	$('#jbglgrid').datagrid({
		queryParams:{//搜索条件
			operatime:"",
			content:"",
		},
		toolbar: [{
			text:'举报时间：<input class="easyui-textbox" type="text" id="starttime" value="" placeholder="请输入关键字" style="line-height:15px"/>',
		},{
			text:'查询',
			iconCls: 'icon-search',
			handler: function(){
				var operatime = $('#starttime').val();
				$('#jbglgrid').datagrid('load',{operatime:operatime,content:""});
			}
		},'-',{
			text:'举报内容：<input class="easyui-textbox" type="text" id="jubaocotnet" value="" placeholder="请输入关键字" style="line-height:15px"/>',
		},{
			text:'查询',
			iconCls: 'icon-search',
			handler: function(){
				var content = $('#jubaocotnet').val();
				$('#jbglgrid').datagrid('load',{operatime:"",content:content});
			}
		},/*'-',{
			text:'文章标题：<input class="easyui-textbox" type="text" id="searchname" value="" placeholder="请输入关键字"/>',
		},{
			text:'查询',
			iconCls: 'icon-search',
			handler: function(){
				var title = $('#searchname').val();
				$('#jbglgrid').datagrid('load',{operatime:"",content:"",title:title});
		},*/{
			text:'返回',
			iconCls:'icon-back',
			handler:function(){
				$('#jbglgrid').datagrid('load',{operatime:"",content:""});
			}
		}],
		singleSelect:false,
		selectOnCheck:true,
		fitColumns:true,
		autoRowHeight:true,
		pageSize:20,
		pageList:[5,10,15,20],
		striped:true,
		url:RESOUCE_SYSTEM_URL_JS+'/jubao/page',
		method:'GET',
		columns:[[
		          {
		          	field:'id',title:'id',checkbox:true
		          },
		          {
		          	field:'articleid',title:'举报标题',width:40,align:'center',sortable:true
		          },
		          {
		        	  field:'content',title:'举报内容',align:'center',width:90,
		          },
		          {
		          	field:'datetime',title:'举报时间',width:30,align:'center',sortable:true
		          }
		          ]],
		          rownumbers:true,
		          pagination:true,
		          pagePosition:'bottom'
	});
	var page = $('#jbglgrid').datagrid('getPager');
	$(page).pagination({
		pageNumber:1,
		beforePageText: '第',//页数文本框前显示的汉字 
		afterPageText: '页    共 {pages} 页', 
		displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录', 
	});
},
reload:function(){//重新加载，保持在当前页
	$('#jbglgrid').datagrid('reload');
}

};

