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
	<div class="imgDiv">
	<img width="200" id="imgDetail">
	</div>
	<div class="formDiv">
	
	   <form id="detailForm"  method="post" class="form-horizontal" novalidate="novalidate">
			<input style="display:none" type="text" name="productId" id="detailProductId" >
			<div>
			        名称:<input  type="text"  id="detailProductName" readonly>
			</div>
  		    <div>
 		  
		                 数量: <span id="decreaseCssById"  onclick="decreaseCount('detailCount','decreaseCssById','addCssById')">--</span>
		                 <input style="width:80px;margin-bottom:4px;" type="text" value="1" name="count" id="detailCount" onkeyup='this.value=this.value.replace(/\D/gi,"")'>
		            <span id="addCssById" onclick="addCount('detailCount','decreaseCssById','addCssById','maxDetailCount')">+</span>
		            库存：<input type="text" style="boder:none;width:40px;"  id="maxDetailCount" readonly/>
 		    </div>
			<div>
			       价格: <input  type="text" name="price" id="detailPrice" readonly>
			</div>
			 <div>
			       详情: <input  type="text" name="detail" id="detailMessage" readonly>
			</div>
		</form>
	</div>
	

		<div class="buttonDiv"  >
		 
			<button type="button" onclick="addshopCard('detailCount','maxDetailCount','detailForm');"  class="btn btn-primary">
				<i class="icon-ok icon-white"></i>加入购物车
			</button>
			 &nbsp;&nbsp;
			<button type="button" onclick="closeModal('decreaseCssById','addCssById');" class="btn btn-primary cancelBtn" >
				<i class="icon-remove icon-white"></i>取消
			</button>
		</div>
	 
	 
</body>
</html>
