<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
 
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
	    <meta charset="utf-8">
	    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	    <meta name="viewport" content="width=device-width, initial-scale=1">

	</head>

	<body  style="padding: 20px;">

				 <form id="detailForm"  method="post" class="form-horizontal" novalidate="novalidate">
						 
						 <input style="display:none" type="text"   id="userId" >
							 
						<div class="control-group">
							<label class="control-label">用户名:</label>
							<div class="controls">
								<input  type="text"   id="userNameDetail" readonly>
							</div>
						</div>
			
			
			           <div class="control-group">
							<label class="control-label">性别:</label>
							<div class="controls">
								<input  type="text"  id = "sexDetail"  readonly>
							</div>
						</div>
						 
						 
						<div class="control-group">
							<label class="control-label">年龄</label>
							<div class="controls">
								<input  type="text"  id="age" readonly >
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">电话:</label>
							<div class="controls">
								<input   type="text"  id="phone"  readonly>
							
							</div>
						</div>
						 
						<div class="control-group">
							<label class="control-label">E-mail</label>
							<div class="controls">
								<input  type="text" id="eMail" readonly>
							
							</div>
						</div>
				      <div class="control-group">
							<label class="control-label">地址:</label>
							<div class="controls">
								<input  type="text"  id="address" readonly >
							
							</div>
						</div>
						 
					</form>
			
    </div> <!-- /content -->    
	</body>
</html>
