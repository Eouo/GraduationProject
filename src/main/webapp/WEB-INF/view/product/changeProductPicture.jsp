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

.changeHeadPicture{
height: 150px;
width:150px;
}
#changePictureForm{
 padding-left:250px;
 padding-top:50px;
}
</style>
</head>
<body style="padding: 20px;">
	
	  
     	<div class="control-group">
			 产品名称: <input type="text" name="productName" id="productNamePicture" readonly>
 		</div>
		
	        <div style="float: left;margin-left: 30px;" >
			 原图片： <br>
			 <img id="productOldPicture"  class="changeHeadPicture" />
			</div>
			<div  id="newProductPictureDiv" style="margin-left: 250px;">
			新图片：<br>
					<img id="productNewPicture"  class="changeHeadPicture" >
			</div>
	
	 <div id="changePictureDiv">
	     <form id="changePictureForm"  action="changeProductPicture" method="post"  enctype="multipart/form-data" >
	      <input type="text" name="productId" id="productIdPicture"style="display:none">
            <div >
 					<input id="imgInput" name="file" type="file"  onchange="previewImage(this,'productNewPicture');" />
		    </div>
	 
 			<div>
				<button type="submit"   class="btn btn-primary">
	              <i class="icon-upload-alt"  ></i>保存
				</button>
				&nbsp;&nbsp;
				<button type="button" onclick="$('#productPictureModal').modal('hide');" class="btn btn-primary cancelBtn" >
					<i class="icon-remove icon-white"></i>取消
				</button>
			</div>
 		</form>
	</div> 		
	
	 <script >
	 
	 function changeProductPicture(id,productName,url){
		    $('#productIdPicture').val(id);
		    $('#productNamePicture').val(productName);
		    document.getElementById('productOldPicture').src="/img?imgName="+url;
			document.getElementById("productNewPicture").src="";
			document.getElementById("imgInput").value="";
			document.getElementById("newProductPictureDiv").style.display="none";
			$('#productPictureModal').modal('show');
		}

	 
	
    </script>
	 
</body>
</html>
