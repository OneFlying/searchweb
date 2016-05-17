var ManagerUserLog = {
		del:function(){//删除日志
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
/*endEditing : function(){
	if (editIndex == undefined){return true;}

	if ($('#jbglgrid').datagrid('validateRow', editIndex)){
		$('#jbglgrid').datagrid('endEdit', editIndex);
		editIndex = undefined;
		return true;
	} else {
		return false;
	}
},
edit:function(){
	var rows = $('#jbglgrid').datagrid('getChecked');
	if(rows.length<=0 || rows.length>1){
		$.messager.alert('提示','请选择一个web服务进行编辑！','info');
		return;
	}
	$('#webservice_add_win').window('open');
	$('#webservice_add_win').panel({
		title:'修改web服务配置',
		onBeforeClose:function(){
			$('#webservice_add_form').form('reset');
		}
	});
	//$('#webservice_add_form').form('clear');
	$('#webservice_add_form').form('load',rows[0]);
	$("#tre").combotree('setValue',rows[0].webserviceVo.fayuanname);
	$('#webservice_submit').unbind('click');
	$('#webservice_submit').click(function(){
		$('#webservice_add_form').form('submit',{
			url:RESOUCE_SYSTEM_URL_JS+'/webservice/update',
			success:function(data){
				var dataJson = eval('(' + data + ')'); 
				if(dataJson.success == true){
					$('#webservice_add_win').window('close');
					WebserviceManager.reload();
				}else{
					$.messager.alert('提示','修改失败，请重新进行修改！','info');
				}
			}
		});
	});

},*/
/**
 * 加载表格数据
 */
loadgrid : function(){
	$('#jbglgrid').datagrid({
		queryParams:{//搜索条件
			type:-1,
			operatime:"",
			userRealName:"",
		},
		toolbar: [/*{
			text:'添加',
			iconCls: 'icon-add',
			handler: function(){
				$('#webservice_add_win').window('open');
				$('#webservice_add_win').panel({
					title:'添加web服务配置',
				});
				$('#webservice_submit').unbind('click');
				$('#webservice_add_form').form('reset');
				$('#webservice_submit').click(function(){
					addWebservice();
				});
			}
		},'-',{
			text:'删除',
			iconCls: 'icon-remove',
			handler: function(){
				//$('#device_delete_win').window('open');
				ManagerUserLog.del();
			}
		},/*'-',{
			text:'修改',
			iconCls: 'icon-edit',
			handler: function(){
				WebserviceManager.edit();
			}
		},*/'-','-',{
			text:'操作类型：<select id="ds_type"><option value="-1">所有</option><option value="0">登陆注销</option><option value="1">配置管理</option><option value="2">会议管理</option><option value="15">设备状态</option><option value="16">数据导入</option></select>',
		},{
			text:'操作时间：<input class="easyui-textbox" type="text" id="searchtime" value="" placeholder="请输入关键字"/>',
		},{
			text:'查询',
			iconCls: 'icon-search',
			handler: function(){
				var type = $('#ds_type').val();
				var operatime = $('#searchtime').val();
				$('#jbglgrid').datagrid('load',{type:type,operatime:operatime,userRealName:""});
			}
		},'-',{
			text:'操作用户姓名：<input class="easyui-textbox" type="text" id="searchname" value="" placeholder="请输入关键字"/>',
		},{
			text:'查询',
			iconCls: 'icon-search',
			handler: function(){
				var userRealName = $('#searchname').val();
				$('#jbglgrid').datagrid('load',{type:-1,operatime:"",userRealName:userRealName});
			}
		},{
			text:'返回',
			iconCls:'icon-back',
			handler:function(){
				$('#jbglgrid').datagrid('load',{type:-1,operatime:"",userRealName:""});
			}
		}/*,{
			text:'<a href = "/jkzx/userlog/toexcel" style ="color:white">导出日志</a>',
		}*/
		],
		singleSelect:false,
		selectOnCheck:true,
		fitColumns:true,
		autoRowHeight:true,
		pageSize:20,
		pageList:[5,10,15,20],
		striped:true,
		url:RESOUCE_SYSTEM_URL_JS+'/userlog/getpage',
		method:'GET',
		columns:[[
		          {field:'id',title:'id',checkbox:true},
		          {field:'type',title:'操作类型',width:30,align:'center',sortable:true,
		        	  formatter: function(value, row, index) {
		        		  if (value == 0) {
		        			  return '登陆注销';
		        		  } else if (value == 1) {
		        			  return '配置管理';
		        		  } else if (value == 2) {
		        			  return '会议管理';
		        		  } else if (value == 15) {
		        			  return '设备状态';
		        		  } else if (value == 16) {
		        			  return '导入数据';
		        		  } 
		        	  }
		          },
		          {
		        	  field:'userName',title:'操作用户名',align:'center',width:30,
		          },
		          {field:'deptName',title:'操作所属法院',width:70,align:'center',sortable:true,},
				  {field:'operaTime',title:'操作时间',width:60,align:'center',sortable:true,},
		          {field:'description',title:'操作描述',width:200,align:'center',sortable:true,},
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

