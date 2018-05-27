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
	<form id="updateForm"  method="post"   class="form-horizontal">
		 
				<input style="display:none"  type="text" name="addressId" id="editAddressId" >
			 
		<div class="form-group">
			<label class="control-label">收件人:</label>
			<div class="controls">
				<input   type="text" name="addressName" id="editAddressName" class="form-control" >
			</div>
		</div>
		<br>
		<div class="form-group">
			<label class="control-label">联系电话:</label>
			<div class="controls">
				<input  class="form-control" type="text" name="addressPhone" id="editAddressPhone" onkeyup='this.value=this.value.replace(/\D/gi,"")'>
			</div>
		</div>
		<br>
		<div   class="control-group" data-toggle="distpicker">
		<label class="control-label">地址:</label>
		<div class="controls" >
		  <select style="width: 210px" id="editProvince" name="province" data-province="---- 选择省 ----"></select>
		  <select style="width: 210px" id="editCity" name="city" data-city="---- 选择市 ----"></select>
		  <select style="width: 210px" id="editDistrict" name="district" data-district="---- 选择区 ----"></select>
		</div>
		 </div>
		 
		<div class="control-group">
			<label class="control-label">详细街道:</label>
			<div class="controls">
				<input  type="text" name="addressDetail" id="editAddressDetail">
			</div>
		</div>
		
		 
		<div class="form-actions" style="padding-left: 170px;">
 			<button type="button" onclick="updateAddress()" class="btn btn-primary">
				<i class="icon-ok icon-white"></i>保存
			</button>
			&nbsp;&nbsp;
			<button type="button" onclick="closeM()" class="btn btn-primary cancelBtn" >
				<i class="icon-remove icon-white"></i>取消
			</button>
		</div>
	</form>
	<script>
	//提交更改  
	function updateAddress() {  
	      
	    $.ajax({  
	        type: "post",  
	        url:  "${ctx}" + "/UserController/addAddress",
	        data:$('#updateForm').serialize(),
	        
	        success : function(data) {
				if (data > 0) {
					alert('操作成功:' + data);
					location.reload();
				} else {
					alert('操作失败' + data);
				}
			},
	        error : function() {
				alert('请求出错');
				location.reload();
			},
			complete : function() {
				// $('#tips').hide();
			}
	    });  
	    return false;
	}  
			
	</script>
</body>
</html>
