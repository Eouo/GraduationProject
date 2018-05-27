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
	<form id="addForm"  method="post" class="form-horizontal"  novalidate="novalidate">
		 <input style="display:none"  type="text" name="productId" id="shopProductId" >
		<div class="form-group">
			<label class="control-label">产品名称:</label>
			<div class="controls">
				<input  class="form-control"  type="text" name="productName" id="productName" >
			</div>
		</div>
		<br>
		<div class="form-group">
			<label class="control-label">数量:</label>
			<div class="controls">
				<input  class="form-control" type="text" name="count" id="count"  >
			</div>
		</div>
		<br>
		<div class="form-group">
			<label class="control-label">价格:</label>
			<div class="controls">
				<input  class="form-control" type="text" name="price" id="price" >
			</div>
		</div>
		<br>
		<div class="control-group">
			<label class="control-label">详情:</label>
			<div class="controls">
				<input  type="text" name="detail" id="detail">
			</div>
		</div>

		<div class="form-actions" style="padding-left: 170px;">

			<button type="submit" onclick="addProduct();return false;" class="btn btn-primary">
				<i class="icon-ok icon-white"></i>保存
			</button>
			&nbsp;&nbsp;
			<button type="button" onclick="$('#addModal').modal('hide');" class="btn btn-primary cancelBtn" >
				<i class="icon-remove icon-white"></i>取消
			</button>
		</div>
	</form>
	<script>
	//提交更改  
	function addProduct() {  
	      
	    $.ajax({  
	        type: "post",  
	        url:  "${ctx}" + "/ProductController/addProduct",
	        data:$('#addForm').serialize(),
	        
	        success : function(data) {
				if (data > 0) {
					alert('操作成功!');
					location.reload();
				} else {
					alert('操作失败!');
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
