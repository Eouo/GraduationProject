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

	  <form id="addForm"  method="post" class="form-horizontal" >
				
				<div class="form-group">
					<label class="control-label">用户名:</label>
					<div class="controls">
						<input   class="form-control" type="text" name="userName" id="userName"   >
					</div>
				</div>
	<br>
	           <div class="form-group">
					<label class="control-label">密码:</label>
					<div class="controls">
						<input   class="form-control" type="password" name="password"  >
					</div>
				</div><br>
				<div class="form-group">
					<label class="control-label">重复密码:</label>
					<div class="controls">
						<input   class="form-control" type="password" name="repassword" >
					</div>
				</div>
				<br>
				<div class = "control-group"> 
				     <label class="control-label" for = "sex">性别</label> 
				     <div class="controls">
				     <select name="sex"   style="height: 25px;width:210px;"> 
				      <option value="0" >女生</option> 
				      <option value="1" >男生</option> 
				     </select> 
				     </div>
				 </div> 
				 
				<div class="form-group">
					<label class="control-label">年龄</label>
					<div class="controls">
						<input  class="form-control"  type="text" name="age"  >
					</div>
				</div>
				<br>
				<div class="form-group">
					<label class="control-label">电话:</label>
					<div class="controls">
						<input  class="form-control" type="text" name="phone" >
					
					</div>
				</div>
				 <br>
				<div class="form-group">
					<label class="control-label">E-mail</label>
					<div class="controls">
						<input class="form-control" type="text" name="eMail"  >
					
					</div>
				</div>
				<br>
		      <div class="form-group">
					<label class="control-label">地址:</label>
					<div class="controls">
						<input   type="text" name="address"  >
					
					</div>
				</div>
				 <br>
				 <div class="form-actions" style="padding-left: 170px;">

			<button type="submit" onclick="addUser();return false;" class="btn btn-primary">
				<i class="icon-ok icon-white"></i>保存
			</button>
			&nbsp;&nbsp;
			<button type="button" onclick="$('#addUser').modal('hide');location.reload();" class="btn btn-primary cancelBtn" >
				<i class="icon-remove icon-white"></i>取消
			</button>
		</div>
		
	</form>
	<jsp:include page="../include/footer.jsp"></jsp:include>
	<script>
	//提交更改  
	function addUser() {  
	      
	    $.ajax({  
	        type: "post",  
	        url:  "${ctx}" + "/UserController/addUser",
	        data:$('#addForm').serialize(),
	        
	        success : function(data) {
				if (data > 0) {
					alert('注册成功!');
					location.reload();
				} else {
					alert('用户名已存在!');
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
