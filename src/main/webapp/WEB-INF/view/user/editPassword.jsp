<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
 
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
	    <meta charset="utf-8">
	    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	    <meta name="viewport" content="width=device-width, initial-scale=1">

<style type="text/css">

#addForm input{
height: 18px;
width:200px;
} 
</style>

	</head>

	<body>

	  <form id="editPasswordForm"  method="post" class="form-horizontal" >
			 
	           <div class="form-group">
					<label class="control-label">旧密码:</label>
					<div class="controls">
						<input   class="form-control" type="password" name="oldPassword"  >
					</div>
				</div><br>
				<div class="form-group">
					<label class="control-label">新密码:</label>
					<div class="controls">
						<input   class="form-control" type="password" name="newPassword" >
					</div>
				</div>
				<br>
				<div class="form-group">
					<label class="control-label">重置密码:</label>
					<div class="controls">
						<input   class="form-control" type="password" name="repassword" >
					</div>
				</div>
				 
				 <br>
				 <div class="form-actions" style="padding-left: 170px;">

			<button type="submit" onclick="editPassword();return false;" class="btn btn-primary">
				<i class="icon-ok icon-white"></i>保存
			</button>
			&nbsp;&nbsp;
			<button type="button" onclick="$('#editPasswordModal').modal('hide');location.reload();" class="btn btn-primary cancelBtn" >
				<i class="icon-remove icon-white"></i>取消
			</button>
		</div>
		
	</form>
 	<script>
	//提交更改  
	function editPassword() {  
	      
	    $.ajax({  
	        type: "post",  
	        url:  "${ctx}" + "/UserController/editPassword",
	        data:$('#editPasswordForm').serialize(),
	        
	        success : function(data) {
				if (data > 0) {
					alert('修改成功！请重新登录！');
					location.href="${ctx}/login.jsp"
				} else if(data<0)  {
					alert('旧密码错误!');
				}else{
					alert('修改失败!');
				}
			},
	        error : function() {
				alert('请求出错');
				location.reload();
			}
	    });  
	    return false;
	}  
			
	</script>
  
	</body>
</html>
