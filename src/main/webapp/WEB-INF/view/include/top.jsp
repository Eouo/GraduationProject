<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
      	
<div class="navbar navbar-fixed-top">
	
	<div class="navbar-inner">
		
		<div class="container">		
			
			<a class="brand" href="./">Welcome</a>
		
		</div> 
		
	</div> 
	
</div>
 <!-- picture Modal start -->
	<div class="modal hide fade" id="pictureModal" tabindex="-1" role="dialog">
			<div class="modal-header">
				<button class="close" type="button" data-dismiss="modal" >×</button>
				<h3>换头像</h3>
			</div>
 	   <div class="modal-body">
			<jsp:include page="../user/changePicture.jsp"></jsp:include>
		</div>
	</div>
	<!-- picture Modal end -->