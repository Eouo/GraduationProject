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
	<form id="shopForm"  method="post" class="form-horizontal" novalidate="novalidate">
		 
				<input style="display:none"  type="text" name="productId" id="shopProductId" >
			 
		<div class="control-group">
			<label class="control-label">产品名称:</label>
			<div class="controls">
				<input   type="text" name="productName" id="shopProductName" readonly>
			</div>
		</div>
		 <div   style="margin-left:110px;margin-bottom:20px;">
 		     
 		     
		      
		                 数量: <span  id="decreaseShopCssById"  onclick="decreaseCount('shopCount','decreaseShopCssById','addShopCssById')">--</span>
		                 <input style="width:80px;margin-bottom:4px;" type="text" value="1" name="count" id="shopCount" onkeyup='this.value=this.value.replace(/\D/gi,"")'>
		            <span id="addShopCssById" onclick="addCount('shopCount','decreaseShopCssById','addShopCssById','maxShopCount')">+</span>
		            库存：<input type="text" style="boder:none;width:40px;"  id="maxShopCount" readonly />
 		    </div>
		<div class="control-group">
			<label class="control-label">价格:</label>
			<div class="controls">
				<input   type="text" name="price" id="shopPrice" readonly>
			</div>
		</div>
		 

		<div class="form-actions" style="padding-left: 170px;">

			<button type="button" onclick="addshopCard('shopCount','maxShopCount','shopForm')" class="btn btn-primary">
				<i class="icon-ok icon-white"></i>加入购物车
			</button>
			&nbsp;&nbsp;
			<button type="button" onclick="closeModal('decreaseShopCssById','addShopCssById');" class="btn btn-primary cancelBtn" >
				<i class="icon-remove icon-white"></i>取消
			</button>
		</div>
	</form>
	<script>
	 
	</script>
</body>
</html>
