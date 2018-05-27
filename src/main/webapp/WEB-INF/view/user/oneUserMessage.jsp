<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
 
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
	    <meta charset="utf-8">
	    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	    <meta name="viewport" content="width=device-width, initial-scale=1">
	    
		<jsp:include page="../include/header.jsp"></jsp:include>
		<title>水果买卖平台</title>

	</head>

	<body>

	<jsp:include page="../include/top.jsp"></jsp:include>
	
	<div id="content">
	
	  <div class="container">
		
	    	<div class="row">
	    	<c:choose>
			   <c:when test="${user.getType()=='0'}">  
			          <jsp:include page="../include/admin_menu.jsp"></jsp:include>
			   </c:when>
			   <c:otherwise> 
			       <jsp:include page="../include/user_menu.jsp"></jsp:include>
			   </c:otherwise>
			</c:choose>
		        
		         <div class="span9">
				
				<h1 class="page-title">
					<i class="icon-th-list"></i>
					个人信息管理					
				</h1>
	 
				<div class="right-content">
				
				 <form id="editForm"  method="post" class="form-horizontal" >
			    		<input style="display:none" type="text" name="userId" id="userId" >
							 
						<div class="form-group">
							<label class="control-label">用户名:</label>
							<div class="controls">
								<input class="form-control"  type="text" name="userName" id="userName" >
							</div>
						</div>
			
						<br>
						<div class = "control-group"> 
						     <label class="control-label" for = "sex">性别</label> 
						     <div class="controls">
						     <select name="sex" id = "sex" style="height: 25px;width:210px;"> 
						      <option value="0" selected>女生</option> 
						      <option value="1" >男生</option> 
						     </select> 
						     </div>
						 </div> 
					
						<div class="form-group">
							<label class="control-label">年龄</label>
							<div class="controls">
								<input class="form-control" type="text" name="age" id="age" onkeyup='this.value=this.value.replace(/\D/gi,"")'>
							</div>
						</div>
						<br>
						<div class="form-group">
							<label class="control-label">电话:</label>
							<div class="controls">
								<input  class="form-control"  type="text" name="phone" id="phone" onkeyup='this.value=this.value.replace(/\D/gi,"")'>
							
							</div>
						</div>
						 <br>
						<div class="form-group">
							<label class="control-label">E-mail</label>
							<div class="controls">
								<input  class="form-control" type="text" name="eMail" id="eMail" >
							
							</div>
						</div>
						<br>
				      <div class="form-group">
							<label class="control-label">地址:</label>
							<div class="controls">
								<input  class="form-control" type="text" name="address" id="address"  >
							
							</div>
						</div>
						<br>
						<div class="form-actions" style="padding-left: 170px;">
				
				        	<input type="button" class="btn btn-primary" value="修改密码" data-toggle="modal" data-target="#editPasswordModal" />
							<button type="submit" onclick="editOneUserMessage();return false;" class="btn btn-primary">
								<i class="icon-ok icon-white"></i>保存
							</button>
							&nbsp;&nbsp;
							<button type="button" onclick="location.reload()" class="btn btn-primary cancelBtn" >
								<i class="icon-remove icon-white"></i>取消
							</button>
						</div>
					</form>
			</div>  
			
	      </div> <!-- /span9 -->
		
	 </div> <!-- /container -->
	
    </div> <!-- /content -->
    
    
	<!-- edit Modal -->
	<div class="modal hide fade" id="editPasswordModal" tabindex="-1" role="dialog">
		<div class="modal-header">
			<button class="close" type="button" data-dismiss="modal">×</button>
			<h3>修改密码</h3>
		</div>
		<div class="modal-body">
			<jsp:include page="editPassword.jsp"></jsp:include>
		</div>
	</div>
	<!-- edit Modal end -->
	
	
 <!-- 新增 Modal start -->
	<div class="modal hide fade" id="addModal" tabindex="-1" role="dialog">
		<div class="modal-body">
			<jsp:include page="../product/addProduct.jsp"></jsp:include>
		</div>
	</div>
	<!-- 新增 Modal end -->
		
<jsp:include page="../include/footer.jsp"></jsp:include>
   <script >
  
   $(function(){
    var li=document.getElementById('oneUserMessage-active');
    li.setAttribute("class","active");
    var path="${ctx}"+"/UserController/oneUserMessage";
    $.ajax({
		url : path,
 		type : "post",
		success : function(data) {
 			 	$("#userId").val(data.userId);  
 			    $("#userName").val(data.userName);  
 			    $("#sex").val(data.sex);  
 			    $("#age").val(data.age); 
 			    $("#phone").val(data.phone); 
 			    $("#eMail").val(data.eMail); 
 			    $("#address").val(data.address); 
 			    $("#userId").prop("readonly","readonly");
  
		},
		error : function() {
			alert('请求出错!');
		}
	});
    
    var space="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
		 $('#editForm').bootstrapValidator({
		    	fields: {
		    		userName: {
		          		message: '用户名验证失败',
		          		validators: {
		            		notEmpty: {
		              			message: space+'用户名不能为空'
		            		},
		            		 regexp: {
		                            regexp: /^[a-zA-Z0-9]+$/,
		                            message: space+'用户名只能包含大小写和数字'
		                        },
		                    stringLength: {
		                         min: 2,
		                         max: 15,
		                         message: space+'用户名长度必须在2到20之间'
		                     },
		          		}   
		        	},phone:{
		        		validators: {
		            		notEmpty: {
		              			message: space+'电话不能为空'
		            		}, 
		            		stringLength: {
		                         min: 11,
		                         max: 11,
		                         message: space+'请输入11位手机号码'
		                     } ,
		            	}
		        	}, age:{
		        		validators: {
		            		stringLength: {
		                         min: 1,
		                         max: 3,
		                         message: space+'请输入正确的年龄'
		                     } ,
		            	}
		        	}, eMail:{
		        		validators: {
		            		notEmpty: {
		              			message: space+'邮箱不能为空'
		            		}, 
		            		 regexp: {
		                            regexp: /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/,
		                            message: space+'邮箱输入有误'
		                        },
		            	}
		        	}, 
		      	}
		    }); 
    
    $('#editPasswordForm').bootstrapValidator({
    	fields: { 
    		
    		newPassword:{
        		validators: {
            		notEmpty: {
              			message: space+'密码不能为空'
            		},
            		regexp: {//匹配规则
                         regexp: /^[a-zA-Z0-9]+$/,
                         message: space+'密码只能包含大小写和数字'
                     },
                    stringLength: {
                         min: 3,
                         max: 20,
                         message: space+'密码长度必须在3到20之间'
                     },
            	}
        	},
        	repassword:{
        		validators: {
            		notEmpty: {
              			message: space+'不能为空'
            		},
                    identical: {//相同
                         field: 'newPassword',
                         message: space+'两次密码不一致'
                     },
            	}
        	}, 
      	}
    }); 
     
    });
     
    function editOneUserMessage(){  
	       
	    $.ajax({  
	        type: "post",  
	        url:  "${ctx}" + "/UserController/updateOneUserMessage",
	        data:$('#editForm').serialize(),
	        
	        success : function(data) {
				if (data > 0) {
					alert('保存成功!');
					location.reload();
				} else {
					alert('保存失败!');
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
