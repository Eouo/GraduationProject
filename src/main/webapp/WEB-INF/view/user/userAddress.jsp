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
        <input type="hidden" name="UserId" id="addressUserId" />
        <div class="control-group">
			 用户名: <input type="text" name="productName" id="addressUserName" readonly>
 		</div>
	     <table class="table table-bordered" id="userAddressTable">
	     </table>
	        
	
	</form>
	 
	 
</body>
</html>
