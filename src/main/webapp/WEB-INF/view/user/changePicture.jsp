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
	
	
	        <div style="float: left;margin-left: 30px;" >
			 原头像： <br>
			 <img src="/img?imgName=${user.getImgUrl()}"   class="changeHeadPicture" />
			</div>
			<div  id="newPictureDiv" style="margin-left: 250px;">
			新头像：<br>
					<img id="divPreviewId"  class="changeHeadPicture" >
			</div>
	
	 <div id="changePictureDiv">
	     <form id="changePictureForm"  action="changeUserPicture" method="post"  enctype="multipart/form-data" >
            <div >
 					<input id="imgInput" name="file" type="file"  onchange="previewImage(this,'divPreviewId');" />
		    </div>
	 
 			<div>
				<button type="submit"   class="btn btn-primary">
	              <i class="icon-upload-alt"  ></i>保存
				</button>
				&nbsp;&nbsp;
				<button type="button" onclick="$('#pictureModal').modal('hide');" class="btn btn-primary cancelBtn" >
					<i class="icon-remove icon-white"></i>取消
				</button>
			</div>
 		</form>
	</div> 		
	
	 <script >
	 
	 function showChangePicture(){
			document.getElementById("divPreviewId").src="";
			document.getElementById("imgInput").value="";
			document.getElementById("newPictureDiv").style.display="none";
			$('#pictureModal').modal('show');
		}
	 function previewImage(fileObj, divPreviewId) {
	 	    var element = document.getElementById(divPreviewId);
		    if (fileObj.files) {//兼容chrome、火狐7+、360浏览器5.5+等，应该也兼容ie10，HTML5实现预览
		        var reader = new FileReader();
		        reader.onload = function (e) {
	 	            element.src = e.target.result;
		        }
		        reader.readAsDataURL(fileObj.files[0]);
		       document.getElementById("newPictureDiv").style.display="";
		       document.getElementById("newProductPictureDiv").style.display="";
		    }

		}
	 
	
    </script>
	 
</body>
</html>
