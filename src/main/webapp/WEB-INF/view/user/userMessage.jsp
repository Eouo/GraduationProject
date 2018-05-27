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
						<i class="icon-th-list"></i> 用户管理
					</h1>

					<div class="right-content">
							<div class="panel panel-default">
								<div class="panel-heading" >查询条件</div>
								<div class="panel-body">
								
								<form class="form-inline" role="form">
									<div class="form-group">
									    <label  for="userName">名称</label> 
										<input  class="form-control" name="userName" id="userName" placeholder="请输入用户名称">
									    <select id="sex" name="sex" class="form-control" >
													<option value="" >请选择性别</option>
													<option value="0" >女生</option>
													<option value="1">男生</option>
													
												</select>
										<button type="button" style="margin-right: 20px"
											id="btn_query" onclick="searchUser();" class="btn btn-primary">查询</button>
								   
									</div>
								 	
									</form>
									
								</div>
							</div>
 
							<div class="pre-scrollable">
								<table  class="table table-bordered"id="messageTable">
								</table>
							</div>
					</div>
				</div>
				<!-- /span9 -->

			</div>
			<!-- /row -->

		</div>
		<!-- /container -->

	</div>
	
	
	<div class="modal hide fade" id="userAddressModal" tabindex="-1" role="dialog">
		<div class="modal-header">
			<button class="close" type="button" onclick="location.reload()" data-dismiss="modal">×</button>
			<h3>地址详情</h3>
		</div>
		<div class="modal-body">
			<jsp:include page="userAddress.jsp"></jsp:include>
		</div>
	</div>
	
	
	
	
  <!-- detail Modal start -->
	<div class="modal hide fade" id="userDetail" tabindex="-1" role="dialog">
		<div class="modal-header">
			<button class="close" type="button" data-dismiss="modal">×</button>
			<h3>客户详情</h3>
		</div>
		<div class="modal-body">
			<jsp:include page="userDetail.jsp"></jsp:include>
		</div>
	</div>
	<!-- detailModal end -->
	
	 <!-- edit Modal start -->
	<div class="modal hide fade" id="editUser" tabindex="-1" role="dialog">
		<div class="modal-header">
			<button class="close" type="button" data-dismiss="modal">×</button>
			<h3>编辑用户</h3>
		</div>
		<div class="modal-body">
			<jsp:include page="editUser.jsp"></jsp:include>
		</div>
	</div>
	<!-- edit Modal end -->
	
		<jsp:include page="../include/footer.jsp"></jsp:include>
		<script>
	$(document).ready(
			function() {
				var li = document.getElementById('user-active');
				li.setAttribute("class", "active");
				var path = "${ctx}"+ "/UserController/userlist";
				$('#messageTable').bootstrapTable({
					url : path,
					dataType : "json",
				    method: 'post', //请求方式（*）
				    contentType: "application/x-www-form-urlencoded",
                    toolbar : '#toolbar', //工具按钮用哪个容器
					striped : true,
					cache : false, //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
					sortable : true, //是否启用排序
					sortOrder : "asc", //排序方式
				  	queryParamsType: "limit", //参数格式,发送标准的RESTFul类型的参数请求  
					queryParams: function (params) {
					    return {
					            rows: this.pageSize,
					            page: this.pageNumber,
					            userName:$("input[name='userName']").val(),
					            sex:$("#sex").val()
					        };
					    },
					singleSelect : false,
					pagination : true, //分页
					paginationPreText: "上一页",
				    paginationNextText: "下一页",
					pageNumber : 1,
					clickToSelect : true,
					pageSize : 7, //每页的记录行数（*）
 					sidePagination : "client", //客户端处理分页
				    formatNoMatches: function () {  //没有匹配的结果
						    return '无符合条件的记录';
						  },
					columns : [{  
	                        //field: 'Number',//可不加  
	                        title: '序号',//标题  可不加  
	                        formatter: function (value, row, index) {  
	                            return index+1;  
	                        },
	                        width:60,
	                        align:'center' 
	                    },{
								field : 'userId',
								title : '序号'
							},
							{
								field : 'userName',
								title : '名称',
								 align:'center'
							},
							{
								field : 'sex',
								title : '性别',
								width:70,
								align:'center',
								formatter:function(value, row,index){
									if(value=="0"){
										return '<p style="color:pink" >女生</>';
								    }else{
								    	return '<p style="color:gray" >男生</>';
								    }
								}
							},
							{
								field : 'age',
								title : '年龄',
								align:'center'
							},
							{
								field : 'phone',
								title : '电话'
							},
							{
								field : 'address',
								title : '地址'
							},
							{
								field : 'eMail',
								title : 'e-mail'
							},
							{
								field : 'type',
								title : '状态',
								align:'center',
								formatter:function(value, row,index){
									if(value=="11"){
										return '<p style="color:gray" >正常用户</>';
								    }else if(value=="0"){
								    	return '<p style="color:blue" >管理员</>';
								    }else{return '<p style="color:red" >拉黑中</>';}
								}
							},
							{
								title : '操作',
								field : 'doSomething',
								align : 'center',
								formatter : function(value,row,index) {
									var d = '<a href="#" onclick="detail(\''
										+ row.userId+'\'\,\''
										+ row.userName+'\'\,\''
										+ row.age+'\'\,\''
										+ row.sex+'\'\,\''
										+ row.phone+'\'\,\''
										+ row.address+'\'\,\''
										+ row.eMail+
								'\')">用户详情</a> ';
								var a = '<a href="#" onclick="address(\''
									+ row.userId+'\'\,\''
									+ row.userName+
							'\')">地址详情</a> ';
								
									var e = '<a href="#" onclick="edit(\''
										+ row.userId+'\'\,\''
										+ row.userName+'\'\,\''
										+ row.age+'\'\,\''
										+ row.sex+'\'\,\''
										+ row.phone+'\'\,\''
										+ row.address+'\'\,\''
										+ row.eMail+
										'\')">编辑</a> ';

									var t;
									if (row.type == "12") {
										t = '<a href="#"  onclick="editType(\''
											    + row.userId+'\'\,\''
												+ row.type
												+ '\')">拉白</a> ';
									} else if(row.type == "11"){
										t = '<a href="#" onclick="editType(\''
											+ row.userId+'\'\,\''
											+ row.type
												+ '\')">拉黑</a> ';
									}else{
										return d;
									}

									return d + a +t + e;
								}
							} ]
			});
		$('#messageTable').bootstrapTable('hideColumn', 'userId');
		$('#messageTable').bootstrapTable('hideColumn', 'phone');
		$('#messageTable').bootstrapTable('hideColumn', 'address');
		$('#messageTable').bootstrapTable('hideColumn', 'eMail');
		
		 var space="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
			 $('#updateForm').bootstrapValidator({
			    	fields: {
			    		userName: {
			          		message: '用户名验证失败',
			          		validators: {
			            		notEmpty: {
			              			message: space+'用户名不能为空'
			            		},regexp: {
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
		 
		 
	});

			function editType(id,t) {
				var type;
			    var message;
				if(t=='11'){
					type='12';
					message="拉黑";
				}else{
					type='11';
					message="撤销拉黑";
				}
				 
				$.ajax({
					url : "${ctx}" + "/UserController/editType",
					data : {"userId" : id,"type" :type},
					type : "post",
					beforeSend : function() {
						if (window.confirm('你确定要'+message+'?')) {
 							return true;
						} else {
 							return false;
						}
					},
					success : function(data) {
						if (data > 0) {
							alert('操作成功!');
                            location.reload();
						} else {
							alert('操作失败!');
						}
					},
					error : function() {
						alert('请求出错');
					} 
				});

				return false;  
			}
			
			function edit(userId,userName,age,sex,phone,address,eMail) {
				//向模态框中传值  
				//userId,userName,age,phone,address,eMail,type+
			    $("#userIdEdit").val(userId);  
			    $("#userNameEdit").val(userName);  
			    $("#ageEdit").val(age);  
			    $("#phoneEdit").val(phone); 
			    $("#sexEdit").val(sex);  
			    $("#addressEdit").val(address);
			    $("#eMailEdit").val(eMail);
			     
				$('#editUser').modal('show');
				
			}
			
			
			function detail(userId,userName,age,sex,phone,address,eMail) {
				//向模态框中传值  
				//userId,userName,age,phone,address,eMail,type+
			    $("#userId").val(userId);  
			    $("#userNameDetail").val(userName);  
			    $("#age").val(age);  
			    $("#phone").val(phone); 
			  
			    if(sex==1){
			    	$("#sexDetail").val("男");
			    }else{
			    	$("#sexDetail").val("女");
			    }
			     
			    $("#address").val(address);
			    $("#eMail").val(eMail);
			     
			    
				$('#userDetail').modal('show');
				
			}
			    function searchUser(){
			    	var searchUrl="${ctx}"+ "/UserController/userlist";
			    	//alert(searchUrl);
 			    	$('#messageTable').bootstrapTable('refresh', {url: searchUrl});  
			    	}
			    
	 function address(id,name){
		 
		 $("#addressUserId").val(id);
		 $("#addressUserName").val(name);
		 var addressPath = "${ctx}"+ "/UserController/addresslist?userId="+id;

		//该用户的地址信息表
			$('#userAddressTable').bootstrapTable({
						url : addressPath,
						dataType : "json",
						singleSelect : true,
						clickToSelect : true,
						columns : [ {
							field : 'addressId',
							title : '序号'
						},
						{
							field : 'addressName',
							title : '收件人' ,
							width:50,
			                align:'center'
						} ,
						{
							field : 'address',
							title : '地址'
						} ,
						{
							field : 'addressDetail',
							title : '详细街道'
						} ,
						{
							field : 'addressPhone',
							title : '联系电话'
						}  ]
					});
			$('#userAddressTable').bootstrapTable('hideColumn', 'addressId');
 			$('#userAddressModal').modal('show');
		}
	 
		</script>
</body>
</html>
