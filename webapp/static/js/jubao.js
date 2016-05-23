var JbglManager = {
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
			text:'举报时间：<input class="easyui-textbox" type="text" style="margin-top: -3px;" id="starttime" value="" placeholder="请输入关键字" style="line-height:15px"/>',
		},{
			text:'查询',
			iconCls: 'icon-search',
			handler: function(){
				var operatime = $('#starttime').val();
				$('#jbglgrid').datagrid('load',{operatime:operatime,content:""});
			}
		},'-',{
			text:'举报内容：<input class="easyui-textbox" type="text" id="jubaocotnet" style="margin-top: -3px;" value="" placeholder="请输入关键字" style="line-height:15px"/>',
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
		          	field:'articleid',title:'<font color="black" size="2px">举报标题</font>',width:40,align:'center',sortable:true,
		          	  	formatter : function(value,row,index){
				        	return '<font color="black" size="2px" >'+value+'</font>';
				      	}
		          },
		          {
		        	  field:'content',title:'<font color="black" size="2px">举报内容</font>',align:'center',width:90,
		        	  formatter : function(value,row,index){
				        return '<font color="black" size="2px" >'+value+'</font>';
				      }
		          },
		          {
		          	field:'datetime',title:'<font color="black" size="2px">举报时间</font>',width:30,align:'center',sortable:true,
		          	formatter : function(value,row,index){
				        return '<font color="black" size="2px" >'+value+'</font>';
				      }
		          }
		          ]],
		          rownumbers:true,
		          pagination:true,
		          pagePosition:'bottom'
	});
	var page = $('#jbglgrid').datagrid('getPager');
	$(page).pagination({
		pageNumber:1,
		beforePageText: '<font color="black" size="2px" >第</font>',//页数文本框前显示的汉字 
		afterPageText: '<font color="black" size="2px" >页    共 {pages} 页</font>', 
		displayMsg: '<font color="black" size="2px" >当前显示 {from} - {to} 条记录   共 {total} 条记录</font>', 
	});
},
reload:function(){//重新加载，保持在当前页
	$('#jbglgrid').datagrid('reload');
}

};

