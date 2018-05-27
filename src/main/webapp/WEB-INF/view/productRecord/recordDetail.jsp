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
input{
border:none;
 }
 
</style>
	</head>

	<body  style="padding: 20px;">

				 <form  method="post" class="form-horizontal" novalidate="novalidate">
					 
						<div class="control-group">
							<label class="control-label">用户名:</label>
							<div class="controls">
								<input disabled type="text"  id="userNameDetail" readonly >
							</div>
						</div>
			
						<div class="control-group">
							<label class="control-label">收件人:</label>
							<div class="controls">
								<input disabled type="text" id="addressNameDetail" readonly>
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">电话:</label>
							<div class="controls">
								<input disabled type="text" id="addressPhoneDetail" readonly >
							
							</div>
						</div>
						 
						<div class="control-group">
													  
							<label class="control-label">地址</label> 
							<div class="controls">
 					        <textarea id="addressDetail" rows="3"readonly></textarea>
						 </div>
						</div>
 					</form>
 
	</body>
</html>
