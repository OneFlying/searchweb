var TgglManager = {
		del:function(){
			var rows = $('#tgglgrid').datagrid('getChecked');
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
					$.get(RESOUCE_SYSTEM_URL_JS+'/promotion/delete',{ids:idArry},function(data){
						if(data.success){
							$.messager.alert('提示','删除成功','info');
							TgglManager.reload();
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
	$('#tgglgrid').datagrid({
		queryParams:{//搜索条件
			price:"",	
		},
		toolbar: [{
			text:'添加',
					iconCls: 'icon-add',
					handler: function(){
						window.open(RESOUCE_SYSTEM_URL_JS + '/promotion/index');
						//window.location.href = RESOUCE_SYSTEM_URL_JS + '/promotion/index'
						/*$('#promotion_add_win').window('open');
						$('#promotion_add_win').panel({
							title:'添加推广',
						});
						$('#promotion_submit').unbind('click');
						$('#form').form('reset');
						$('#promotion_submit').click(function(){
							 setImg();
							 $('#promotion_add_win').window('close');
						});*/
					}
			},'-',{
					text:'删除',
					iconCls: 'icon-remove',
					handler: function(){
						TgglManager.del();
					}
				},'-',{
			text:'价格：<input class="easyui-textbox" type="text" style="margin-top: -3px;" id="starttime" value="" placeholder="请输入关键字" style="line-height:15px"/>',
			},'-',{
				text:'查询',
				iconCls: 'icon-search',
				handler: function(){
					var price = $('#starttime').val();
					$('#tgglgrid').datagrid('load',{price:price});
				}
			},'-',/*'-',{
			text:'文章标题：<input class="easyui-textbox" type="text" id="searchname" value="" placeholder="请输入关键字"/>',
		},{
			text:'查询',
			iconCls: 'icon-search',
			handler: function(){
				var title = $('#searchname').val();
				$('#tgglgrid').datagrid('load',{operatime:"",content:"",title:title});
		},*/{
			text:'返回',
			iconCls:'icon-back',
			handler:function(){
				$('#tgglgrid').datagrid('load',{price:""});
			}
		}],
		singleSelect:false,
		selectOnCheck:true,
		fitColumns:true,
		autoRowHeight:true,
		pageSize:20,
		pageList:[5,10,15,20],
		striped:true,
		url:RESOUCE_SYSTEM_URL_JS+'/promotion/page',
		method:'GET',
		columns:[[
		         {
		          	field:'id',title:'id',checkbox:true
		          },
		          {
		          	field:'title',title:'<font color="black" size="2px">标题</font>',width:40,align:'center',sortable:true,
		          	  	formatter : function(value,row,index){
				        	return '<font color="black" size="2px" >'+value+'</font>';
				      	}
		          },
		          {
		          	field:'price',title:'<font color="black" size="2px">价格</font>',width:40,align:'center',sortable:true,
		          	  	formatter : function(value,row,index){
				        	return '<font color="black" size="2px" >'+value+'</font>';
				      	}
		          },
		          {
		        	  field:'url',title:'<font color="black" size="2px">url地址</font>',align:'center',width:90,
		        	  formatter : function(value,row,index){
				        return '<font color="black" size="2px" >'+value+'</font>';
				      }
		          },
		          {
		          	field:'usecount',title:'<font color="black" size="2px">点击量</font>',width:30,align:'center',sortable:true,
		          	formatter : function(value,row,index){
				        return '<font color="black" size="2px" >'+value+'</font>';
				      }
		          },
		          {
			          	field:'sb',title:'<font color="black" size="2px">详情</font>',
			          	formatter : function(value,row,index){
			          		var id = row.id ;
			          		//alert(id);*/
			          		return "<a href='"+RESOUCE_SYSTEM_URL_JS+"/article/info?id="+id+"' target='_blank'><font style='font-size:10px'>查看详情</font></a>"
				        	//return '<input type="button" onclick="look('+id+')" style="height:27px;width:70px;font-size:12px;line-height:0px;margin-top:-7px;color:black" value="查看详情"/>';
				      	}
			       }
		          ]],
		          rownumbers:true,
		          pagination:true,
		          pagePosition:'bottom'
	});
	var page = $('#tgglgrid').datagrid('getPager');
	$(page).pagination({
		pageNumber:1,
		beforePageText: '<font color="black" size="2px" >第</font>',//页数文本框前显示的汉字 
		afterPageText: '<font color="black" size="2px" >页    共 {pages} 页</font>', 
		displayMsg: '<font color="black" size="2px" >当前显示 {from} - {to} 条记录   共 {total} 条记录</font>', 
	});
},
reload:function(){//重新加载，保持在当前页
	$('#tgglgrid').datagrid('reload');
}
};

/*function look(id){
	alert(id);
}*/