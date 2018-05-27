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
<style type="text/css">
.imgDiv{
float: left;
}
.formDiv{
 margin-left:230px;
}
.formDiv input{
border:none;
height: 25px;
width:120px;
}
.formDiv div{
margin-bottom:20px;
}
.buttonDiv{
margin-left:230px;
}
#decreaseCount{
 margin-left:10px;
}
#addCount{
 margin-right:10px;
}
</style>
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
 		    数量:<button type="button" onclick="decreaseCount()" class="btn btn-primary"value="-">
 		    </button>
		                 数量: <span id="decreaseCount">--</span>
		                 <input style="width:80px;" type="text" value="1" name="count" id="detailCount" onkeyup='this.value=this.value.replace(/\D/gi,"")'>
		            <span id="addCount">+</span>
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
		 
			<button type="button" onclick="shopCardDetail();"  class="btn btn-primary">
				<i class="icon-ok icon-white"></i>加入购物车
			</button>
			 
		</div>
	 
	 <script >
	 
	//提交购物车
		function shopCardDetail(){  
		      var detailCount=$("#detailCount").val();
		      var maxCount=parseInt($("#maxDetailCount").val());
		      if(parseInt(detailCount)>maxCount||parseInt(detailCount)<=0||detailCount==""){
		    	  alert("数量有误！请重新选择！");
		    	  return false;
		      }
		    $.ajax({  
		        type: "post",  
		        url:  "${ctx}" + "/ShopCardController/addShopCard",
		        data:$('#detailForm').serialize(),
		        
		        success : function(data) {
					if (data > 0) {
						alert('操作成功!' );
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
