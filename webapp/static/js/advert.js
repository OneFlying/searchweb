var GgglManager = {
	edit:function(){
		var rows = $('#ggglgrid').datagrid('getChecked');
		if(rows.length<=0 || rows.length>1){
			$.messager.alert('提示','请选择一行数据进行编辑！','info');
			return;
		}
		$('#advert_add_win').window('open');
		$('#advert_add_win').panel({
			title:'修改广告信息',
		});
		$('#advert_add_form').form('clear');
		$('#advert_add_form').form('load',rows[0]);
		$('#advert_submit').unbind('click');
		$('#advert_submit').click(function(){

			$('#advert_add_form').form('submit',{
				url:RESOUCE_SYSTEM_URL_JS+'/advert/update',
				success:function(data){
					var dataJson = eval('(' + data + ')');
					if(dataJson.success == true){
						$('#advert_add_win').window('close');
						GgglManager.reload();
					}else{
						$.messager.alert('提示',dataJson.msg,'info');
					}
				}
			});

		});

	},

	del:function(){
		var rows = $('#ggglgrid').datagrid('getChecked');
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
				$.get(RESOUCE_SYSTEM_URL_JS+'/advert/del',{ids:idArry},function(data){
					if(data.success){
						$.messager.alert('提示','删除成功','info');
						GgglManager.reload();
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
	$('#ggglgrid').datagrid({
		queryParams:{//搜索条件
			desc:"",
			content:"",
		},
		toolbar: [
		{
        			text:'添加',
					iconCls: 'icon-add',
					handler: function(){
						//window.location.href = RESOUCE_SYSTEM_URL_JS + '/promotion/index'
						$('#advert_add_win').window('open');
						$('#advert_add_win').panel({
							title:'添加广告',
						});
						$('#advert_submit').unbind('click');
						$('#advert_add_form').form('reset');
						$('#advert_submit').click(function(){
							 //setImg();
                             addAdvert();
                             clearAddAdvert();
						});
					}
		},'-',
		{
				text:'修改',
				iconCls: 'icon-remove',
				handler: function(){
					//$('#device_delete_win').window('open');
					GgglManager.edit();
				}

		},'-',
		{
				text:'删除',
				iconCls: 'icon-remove',
				handler: function(){
					//$('#device_delete_win').window('open');
					GgglManager.del();
				}

		},'-',
		{
			text:'广告标题：<input class="easyui-textbox" type="text" style="margin-top: -2px;" id="advert-title" value="" placeholder="请输入关键字" style="line-height:15px"/>',
		},{
			text:'查询',
			iconCls: 'icon-search',
			handler: function(){
				var content = $('#advert-title').val();
				$('#ggglgrid').datagrid('load',{title:content});
			}
		},'-',
		{
			text:'广告描述：<input class="easyui-textbox" type="text" id="advert-desc" style="margin-top: -2px;" value="" placeholder="请输入关键字" style="line-height:15px"/>',
		},{
			text:'查询',
			iconCls: 'icon-search',
			handler: function(){
				var keywords = $('#advert-desc').val();
				$('#ggglgrid').datagrid('load',{desc:keywords});
			}
		},'-',{
			text:'返回',
			iconCls:'icon-back',
			handler:function(){
				$('#ggglgrid').datagrid('load',{operatime:"",content:""});
			}
		},'-',{
            text:'<input type="button" id="uploadpic" onclick="uploadpic()" style="height:27px;width:70px;font-size:12px;line-height:0px;margin-top:-7px;color:black" value="上传图片"/>'
        }],
		singleSelect:false,
		selectOnCheck:true,
		fitColumns:true,
		autoRowHeight:true,
		pageSize:20,
		pageList:[5,10,15,20],
		striped:true,
		url:RESOUCE_SYSTEM_URL_JS+'/advert/page',
		method:'GET',
		columns:[[
		          {
		          	field:'id',title:'id',checkbox:true
		          },
		          {
		          	field:'title',title:'<font color="black" size="2px">广告标题</font>',width:30,align:'center',sortable:true,
		          	 formatter : function(value,row,index){
				        return '<font color="black" size="2px" >'+value+'</font>';
				      }
		          },
		          {
		        	field:'desc',title:'<font color="black" size="2px">广告描述</font>',align:'center',width:30,
		        	 formatter : function(value,row,index){
				        return '<font color="black" size="2px" >'+value+'</font>';
				      }
		          },
                  {
		          	field:'price',title:'<font color="black" size="2px">广告价格</font>',width:30,align:'center',sortable:true,
		          	 formatter : function(value,row,index){
				        return '<font color="black" size="2px" >'+value+'</font>';
				      }
				  },
		          {
		          	field:'adurl',title:'<font color="black" size="2px">详情</font>',width:30,align:'center',sortable:true,
		          	 formatter : function(value,row,index){
				        //return '<font color="black" size="2px" >'+value+'</font>';
				        return "<a href='"+value+"' target='_blank'><font style='font-size:10px'>查看详情</font></a>";
				      }
				  }/*,  {
			          	field:'id',title:'<font color="black" size="2px">详情</font>',
			          	formatter : function(value,row,index){
			          		/*var id = 1+value; ;
			          		alert(id);*/
			          		//return "<a href='"+RESOUCE_SYSTEM_URL_JS+"/article/info?id="+value+"' target='_blank'><font style='font-size:10px'>查看详情</font></a>"
				        	//return '<input type="button" onclick="look('+id+')" style="height:27px;width:70px;font-size:12px;line-height:0px;margin-top:-7px;color:black" value="查看详情"/>';
				      	//}
			       //}*/
		          ]],
		          rownumbers:true,
		          pagination:true,
		          pagePosition:'bottom'
	});
	var page = $('#ggglgrid').datagrid('getPager');
		$(page).pagination({
		pageNumber:1,
		beforePageText: '<font color="black" size="2px" >第</font>',//页数文本框前显示的汉字
		afterPageText: '<font color="black" size="2px" >页    共 {pages} 页</font>',
		displayMsg: '<font color="black" size="2px" >当前显示 {from} - {to} 条记录   共 {total} 条记录</font>',
	});
},
reload:function(){//重新加载，保持在当前页
	$('#ggglgrid').datagrid('reload');
}

};

function uploadpic(){
    //alert('2345');
    $('#advertlogo_add_win').window('open');
}
