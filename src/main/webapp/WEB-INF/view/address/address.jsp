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
						<i class="icon-th-list"></i> 地址管理
					</h1>

					<div class="right-content">
                         
								 
							<div id="toolbar" class="btn-group">
								<input type="button" class="btn btn-primary" value="新增地址" data-toggle="modal" data-target="#addModal" />
							    <input type="button" class="btn btn-primary" value="删除" onclick="del(null)" />
							</div>
							<div class="pre-scrollable">
							<table  class="table table-bordered" id="addressTable">
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
	<!-- 新增 Modal start -->
	<div class="modal hide fade" id="addModal" tabindex="-1" role="dialog">
		<div class="modal-header">
			<button class="close" type="button" data-dismiss="modal">×</button>
			<h3>新增地址</h3>
		</div>
		<div class="modal-body">
			<jsp:include page="addAddress.jsp"></jsp:include>
		</div>
	</div>
	<!-- 新增 Modal end -->
	
	<!-- edit Modal -->
	<div class="modal hide fade" id="editModal" tabindex="-1" role="dialog">
		<div class="modal-header">
			<button class="close" type="button" data-dismiss="modal">×</button>
			<h3>修改信息</h3>
		</div>
		<div class="modal-body">
			<jsp:include page="editAddress.jsp"></jsp:include>
		</div>
	</div>
	<!-- edit Modal end -->
	
	
	<jsp:include page="../include/footer.jsp"></jsp:include>
	<script>
	
	 
	$(function(){ 
				var li = document.getElementById('address-active');
				li.setAttribute("class", "active");
				var path = "${ctx}"
						+ "/UserController/addresslist";
				$('#addressTable').bootstrapTable({
				url : path,
				dataType : "json",
				contentType: "application/x-www-form-urlencoded",
				toolbar : '#toolbar', //工具按钮用哪个容器
				striped : true,
				cache : false, //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
				sortable : true, //是否启用排序
				sortOrder : "asc", //排序方式
				singleSelect : false,
				pagination : true, //分页
				pageNumber : 1,
				clickToSelect : true,
				pageSize : 7, //每页的记录行数（*）
				sidePagination : "client", //客户端处理分页
				formatNoMatches: function () {  //没有匹配的结果
				    return '无符合条件的记录';
				  },
				columns : [{
	                        checkbox: true
                        },
						{
							field : 'addressId',
							title : '序号'
						}, {
							field : 'userId',
							title : 'user序号'
						},
						{
							field : 'addressName',
							title : '收件人'
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
						} ,
						{
							field : 'type'
						} ,
						{
							title : '操作',
							field : 'doSomething',
							align : 'center',
							width:150,
							formatter : function(value, row,index) {
								var dA;
								 if(row.type=="1"){
									 dA='<p style="color:orange;font-size:16px;" >默认地址</>';
								 }else{
									 dA= '<a href="#" onclick="defaultAddress(\'' + row.addressId+
									'\')">设为默认</a> ';
								 }
							  
							var e = '<a href="#" onclick="editInfo(\''
								+ row.addressId+'\'\,\''
								+ row.addressName+'\'\,\''
								+ row.addressDetail+'\'\,\''
								+ row.addressPhone+
						'\')">编辑</a> ';
									var d = '<a href="#"  onclick="del(\''
										+ row.addressId
										+ '\')">删除</a> ';
								return dA+e+d;
							}
						} ]
			});
				
				$('#addressTable').bootstrapTable('hideColumn', 'addressId');
				$('#addressTable').bootstrapTable('hideColumn', 'type');
				$('#addressTable').bootstrapTable('hideColumn', 'userId');
				var space="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
				 $('#updateForm').bootstrapValidator({
				    	fields: {
				    		addressName: {
				          		message: '用户名验证失败',
				          		validators: {
				            		notEmpty: {
				              			message: space+'用户名不能为空'
				            		},
				            		 regexp: {
				                            regexp: /^[\u4e00-\u9fa5_a-zA-Z0-9]+$/,
				                            message: space+'用户名只能包含中英文和数字'
				                        },
				                    stringLength: {
				                         min: 2,
				                         max: 20,
				                         message: space+'用户名长度必须在2到20之间'
				                     },
				          		}
				        	}, addressPhone:{
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
				        	},
				        	province:{
				        		validators: {
				            		notEmpty: {
				              			message: space+'省份不能为空'
				            		},
				            	}
				        	},
				        	city:{
				        		validators: {
				            		notEmpty: {
				              			message: space+'市区不能为空'
				            		},
				            	}
				        	},
				        	district:{
				        		validators: {
				            		notEmpty: {
				              			message: space+'区域不能为空'
				            		},
				            	}
				        	},
				        	addressDetail:{
				        		validators: {
				            		notEmpty: {
				              			message: space+'详细街道不能为空'
				            		},
				            	}
				        	},
				      	}
				    });  
				 $('#addForm').bootstrapValidator({
				    	fields: {
				    		addressName: {
				          		message: '用户名验证失败',
				          		validators: {
				            		notEmpty: {
				              			message: space+'用户名不能为空'
				            		},
				            		 regexp: {
				                            regexp: /^[\u4e00-\u9fa5_a-zA-Z0-9]+$/,
				                            message: space+'用户名只能包含大小写和数字'
				                        },
				                    stringLength: {
				                         min: 2,
				                         max: 20,
				                         message: space+'用户名长度必须在2到20之间'
				                     },
				          		}
				        	}, addressPhone:{
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
				        	},
				        	province:{
				        		validators: {
				            		notEmpty: {
				              			message: space+'省份不能为空'
				            		},
				            	}
				        	},
				        	city:{
				        		validators: {
				            		notEmpty: {
				              			message: space+'市区不能为空'
				            		},
				            	}
				        	},
				        	district:{
				        		validators: {
				            		notEmpty: {
				              			message: space+'区域不能为空'
				            		},
				            	}
				        	},
				        	addressDetail:{
				        		validators: {
				            		notEmpty: {
				              			message: space+'详细街道不能为空'
				            		},
				            	}
				        	},
				      	}
				    }); 
				 
			}); 
	 
		  // 回填表单
		function editInfo(id,addressName,addressDetail,addressPhone) {  
			//向模态框中传值  
		    $("#editAddressId").val(id);  
			$("#editAddressName").val(addressName);  
		    $("#editAddressDetail").val(addressDetail);  
		    $("#editAddressPhone").val(addressPhone);  
		    
		    /* var selectProvince = document.getElementById("editProvince"); 
		    
		   
		    for(var i=0; i<selectProvince.options.length; i++){  
		        if(addressDetail.indexOf(selectProvince.options[i].innerHTML) >= 0){  
		        	selectProvince.options[i].selected = true;  
		            break;  
		        }  
		    }  */ 
		    
		    
		    
	  
		    $('#editModal').modal('show');  
		}  
		  
		function del(id) {
			var addressId;
			if(id==null||id==""){
				addressId=$.map($('#addressTable').bootstrapTable('getSelections'), function (row) {
			        return row.addressId;
			    });
			}else{
				addressId=id;
			}
 			if(addressId.length>0){
		 	$.ajax({
			url : "${ctx}" + "/UserController/delAddress?addressId="+addressId,
			data : {
				"addressId" : addressId
			},
			type : "post",
			beforeSend : function() {
				if (window.confirm('你确定要删除吗？')) {
					//alert("确定");
					return true;
				} else {
					//alert("取消");
					return false;
				}
			},
			success : function(data) {
				if (data!=null) {
					alert('操作成功:' + data);

					location.reload();
				} else {
					alert('操作失败' + data);
				}
			},
			error : function() {
				alert('请求出错');
			} 
		});
         }else{ 
				alert("请至少选择一条数据");
				return false;
		   }
		}
		
		
		function defaultAddress(addressId){
			$.ajax({
				url : "${ctx}" + "/UserController/defaultAddress",
				data : {"addressId" : addressId},
				type : "post",
				success : function(data) {
					if (data > 0) {
						alert('操作成功:' + data);
                        location.reload();
					} else {
						alert('操作失败' + data);
					}
				},
				error : function() {
					alert('请求出错');
				} 
			});
			return false;
		}
		
		function closeM(){
			//$('#editModal').modal('hide');
			location.reload();
			
		}
		
	</script>
</body>
</html>
