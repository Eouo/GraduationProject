<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>

<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title></title>
</head>
<body style="padding: 20px;">
	<form id="addForm" method="post" class="form-horizontal" >
		<div class="form-group">
			<label class="control-label">收件人:</label>
			<div class="controls">
				<input class="form-control" type="text" id="addressName"name="addressName">
			</div>
		</div>
		<br> 
		<div class="form-group">
			<label class="control-label">联系电话:</label>
			<div class="controls">
				<input  class="form-control" type="text" id="addressPhone" name="addressPhone" onkeyup='this.value=this.value.replace(/\D/gi,"")'>
			</div>
		</div>
		<br>
		<div   class="form-group" data-toggle="distpicker">
		<label class="control-label">地址:</label>
		<div class="controls" >
		  <select class="form-control" style="width: 210px" id="province" name="province" data-province="---- 选择省 ----"></select>
		  <select class="form-control" style="width: 210px" id="city" name="city" data-city="---- 选择市 ----"></select>
		  <select class="form-control" style="width: 210px" id="district" name="district" data-district="---- 选择区 ----"></select>
		</div>
		 </div>
		 <br>
		<div class="form-group">
			<label class="control-label">详细街道:</label>
			<div class="controls">
				<input type="text" name="addressDetail" id="addressDetail">
			</div>
		</div>
		
		<div class="form-actions" style="padding-left: 135px;">
			
			<button type="submit" onclick="addAddress();return false;"  class="btn btn-primary">
				<i class="icon-ok icon-white"></i>保存
			</button>
			&nbsp;&nbsp;
			<button type="button"  onclick="closeM()" class="btn btn-primary cancelBtn">
				<i class="icon-remove icon-white"></i>取消
			</button>
		</div>
	</form>
	 <script >
	 
	 function addAddress() { 
		 
		 
		 if($("#detail").val()==""){
			 alert("详细街道不能为空！");
			 return false;
		 }
		 var p=$("#province").val();
		 var c=$("#city").val();
		 var d=$("#district").val();
 		 if($("#province").val()==""){
			 alert("province地址不能为空！");
			 return false;
		 }
		 if($("#city").val()==""){
			 alert("city地址不能为空！");
			 return false;
		 }
		 if($("#district").val()==""){
			 alert("district地址不能为空！");
			 return false;
		 }
 		    $.ajax({  
		        type: "post",  
		        url:  "${ctx}" + "/UserController/addAddress",
		        data:$('#addForm').serialize(),
		        
		        success : function(data) {
					if (data > 0) {
						alert('添加成功:' + data);
						location.reload();
					} else {
						alert('添加失败' + data);
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
