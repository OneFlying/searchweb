//登录
var Login={
	login:function(){
		var username=$('#username').val();
		var password=$('#password').val();
		if(username!=""){
			if(password!=""){
				$.post(RESOUCE_SYSTEM_URL_JS+'/admin/login',{username:username,password:password},function(data){
					if(data.success==true){
						 if($('#remberpass:checked').length>0){  
					            $.cookie('username',username,{expires:30});  
					            $.cookie('password', password,{expires:30});  
					        }else{//清除cookie  
					            $.cookie('username','');  
					            $.cookie('password','');  
					        }
						location.href = RESOUCE_SYSTEM_URL_JS+data.url;
					}else{
						alert(data.msg,"warning");
						
					}
				});
			}else{
				alert("密码不能为空","warning");
			}
		}else{
			alert("用户名不能为空","warning");
		}
	},
	casLogin:function(){
				$.post(RESOUCE_SYSTEM_URL_JS+'/login/checkLogin',{},function(data){
					if(data.success==true){
						location.href = RESOUCE_SYSTEM_URL_JS+data.url;
					}else{
						alert(data.msg,"warning");
					}
				});
	}
};
//页面加载完成执行该方法，检验是否选中记住密码
$(function(){
	if($.cookie('username')!=""&& $.cookie('username')!=null){  
        $("#remberpass").attr("checked", true);  
    }else{  
        $("#remberpass").attr("checked", false);  
    }   
	if($('#remberpass:checked').length>0){ 
        $('#username').val($.cookie('username'));  
        $('#password').val($.cookie('password'));  
    } 
});
$(document).keydown(function(event) {
	if (event.keyCode == 13) { 
		Login.login(); 
	} 
});
