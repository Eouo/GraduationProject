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
						<i class="icon-th-list"></i> 仓库管理
					</h1>

					<div class="right-content">
                         <div class="panel panel-default">
								<div class="panel-heading" >查询条件</div>
								<div class="panel-body">
								
								<form class="form-inline" role="form">
									<div class="form-group">
									    <label  for="productName">名称</label> 
										<input   class="form-control" name="productName" id="productName" placeholder="水果名字">
									    <select id="type" name="type" class="form-control" >
													<option value="" >请选择状态</option>
													<option value="1" >在售中</option>
													<option value="0">未上架</option>
													
												</select>
										<button type="button" style="margin-right: 20px"
											id="btn_query" onclick="searchProduct();" class="btn btn-primary">查询</button>
								   
									</div>
								 	
									</form>
									
								</div>
								<div  class="btn-group">
								<input type="button" class="btn btn-primary" value="新增" data-toggle="modal" data-target="#addModal" />
								<input type="button" class="btn btn-primary" value="删除" onclick="delMore()" />
							    </div>
							</div>
							
							<br/>
							<div class="pre-scrollable">
							<table class="table table-bordered " id="productTable">
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
	<!-- /content -->
	
	
	
	

	<!-- 新增 Modal start -->
	<div class="modal hide fade" id="addModal" tabindex="-1" role="dialog">
		<div class="modal-header">
			<button class="close" type="button" data-dismiss="modal">×</button>
			<h3>新增信息</h3>
		</div>
		<div class="modal-body">
			<jsp:include page="addProduct.jsp"></jsp:include>
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
			<jsp:include page="editProduct.jsp"></jsp:include>
		</div>
	</div>
	<!-- edit Modal end -->

	<jsp:include page="../include/footer.jsp"></jsp:include>
	<script>
		$(document).ready(
function() {
	var li = document.getElementById('repertory-active');
	li.setAttribute("class", "active");
	var path = "${ctx}"+ "/ProductController/repertoryList";
	$('#productTable').bootstrapTable({
			url : path,
			dataType : "json",
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
			            productName:$("input[name='productName']").val(),
			            type:$("#type").val()
			        };
			    },
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
            },{
						field: 'imgUrl',
						title:"",
						formatter: function (value, row, index) {  
			                return '<img width="50" src="/img?imgName='+value+'">';  
			            },
			            width:60,
			            align:'center' 
			        },
					{
						field : 'productId',
						title : '序号'
					},
					{
						field : 'productName',
						title : '产品名称',
						align: 'center'
					},
					{
						field : 'price',
						title : '价格'
					},
					{
						field : 'count',
						title : '库存量'
					},
					{
						field : 'type',
						title : '状态',
						formatter:function(value, row,index){
							if(value=="1"){
								return '<p style="color:gray" >在售中</>';
						    }else{
						    	return '<p style="color:blue" >未上架</>';
						    }
						}
					},
					{
						title : '操作',
						field : 'doSomething',
						align : 'center',
						formatter : function(value, row,index) {
						 
                            var u;
                            if(row.type=="0"){
                            	u = '<a href="#" '+'style="color:blue"'+'onclick="upShop(\''
								+ row.productId
								+ '\')">上架</a> ';
                            }else{
                                u = '<a href="#"  onclick="downShop(\''
								+ row.productId
								+ '\')">下架</a> ';
                                                      }
						
							var e = '<a href="#" onclick="editInfo(\''
									+ row.productId+'\'\,\''
									+ row.productName+'\'\,\''
									+ row.price+'\'\,\''
									+ row.count+
							'\')">编辑</a> ';
							
							
								var d = '<a href="#"  onclick="del(\''
									+ row.productId
									+ '\')">删除</a> ';
							return  u +e
									+ d;
						}
					} ]
		});
	$('#productTable').bootstrapTable('hideColumn', 'productId');
	
	 var space="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
		 $('#updateForm').bootstrapValidator({
		    	fields: {
		    		productName: {
		          		message: '验证失败',
		          		validators: {
		            		notEmpty: {
		              			message: space+'产品名不能为空'
		            		},
		            		 regexp: {
		                            regexp: /^[\u4e00-\u9fa5_a-zA-Z0-9]+$/,
		                            message: space+'产品名只能包含中英文和数字'
		                        },
		                    stringLength: {
		                         min: 2,
		                         max: 15,
		                         message: space+'用户名长度必须在2到20之间'
		                     },
		          		}   
		        	},count:{
		        		validators: {
		            		notEmpty: {
		              			message: space+'产品数量不能为空'
		            		}, 
		            		stringLength: {
		                         min: 1,
		                         max: 7,
		                         message: space+'请输百万以内的数量'
		                     } ,

		            		 regexp: {
		                            regexp: /^[0-9]*$/,
		                            message: space+'请输入正确的数量'
		                        },
		            	}
		        	}, price:{
		        		validators: {
		        			notEmpty: {
		              			message: space+'产品价格不能为空'
		            		},
		            		stringLength: {
		                         min: 1,
		                         max: 7,
		                         message: space+'请输入正确的价格'
		                     } ,

		            		 regexp: {
		                            regexp: /^[0-9]+(.[0-9]{2})?$/,
		                            message: space+'产品价格只能精确到分'
		                        },
		                     
		            	}
		        	} , 
		      	}
		    }); 
	 
	 $('#addForm').bootstrapValidator({
	    	fields: {
	    		productName: {
	          		message: '验证失败',
	          		validators: {
	            		notEmpty: {
	              			message: space+'产品名不能为空'
	            		},
	            		 regexp: {
	                            regexp: /^[\u4e00-\u9fa5_a-zA-Z0-9]+$/,
	                            message: space+'产品名只能包含中英文和数字'
	                        },
	                    stringLength: {
	                         min: 2,
	                         max: 15,
	                         message: space+'用户名长度必须在2到20之间'
	                     },
	          		}   
	        	},count:{
	        		validators: {
	            		notEmpty: {
	              			message: space+'产品数量不能为空'
	            		}, 
	            		stringLength: {
	                         min: 1,
	                         max: 7,
	                         message: space+'请输百万以内的数量'
	                     } ,

	            		 regexp: {
	                            regexp: /^[0-9]*$/,
	                            message: space+'请输入正确的数量'
	                        },
	            	}
	        	}, price:{
	        		validators: {
	        			notEmpty: {
	              			message: space+'产品价格不能为空'
	            		},
	            		stringLength: {
	                         min: 1,
	                         max: 7,
	                         message: space+'请输入正确的价格'
	                     } ,

	            		 regexp: {
	                            regexp: /^[0-9]+(.[0-9]{2})?$/,
	                            message: space+'产品价格只能精确到分'
	                        },
	                     
	            	}
	        	} , 
	      	}
	    }); 

});

		  function searchProduct(){
			    var b=$("#productName").val();
 		    	var searchUrl="${ctx}"+ "/ProductController/repertoryList";
 		    	$('#productTable').bootstrapTable('refresh', {url: searchUrl});  
		    	}
		function del(id) {
			 	$.ajax({
				url : "${ctx}" + "/ProductController/delProduct",
				data : {
					"productId" : id,
					"type" : "0"
				},
				type : "post",
				beforeSend : function() {
					if (window.confirm('你确定要删除吗？')) {
						return true;
					} else {
						return false;
					}
				},
				success : function(data) {
					if (data!=null) {
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
		
		function delMore() {
			var row=$.map($('#productTable').bootstrapTable('getSelections'), function (row) {
		        return row.productId;
		    });
			if(row.length>0){

				$.ajax({
					url : "${ctx}" + "/ProductController/delProduct?productId="+row,
					data : {"productId" : row},
					type : "post",
					beforeSend : function() {
						if (window.confirm('你确定要删除吗？')) {
 							return true;
						} else {
  							return false;
						}
					},
					success : function(data) {
						if (data > 0) {
							alert('成功删除' + data+'个产品信息');
                            location.reload();
						} else {
							alert('操作失败！' );
						}
					},
					error : function() {
						alert('请求出错');
					},
				});
			}else{ 
				alert("请至少选择一条数据");
				return false;
		   }
		}
		
		 
		
		function upShop(id) {
			 $.ajax({
				url : "${ctx}" + "/ProductController/upOrDownShopProduct",
				data : {"productId" : id,"type" : "1"},
				type : "post",
				beforeSend : function() {
					if (window.confirm('你确定要上架吗？')) {
						return true;
					} else {
						return false;
					}
				},
				success : function(data) {
					if (data > 0) {
						alert('操作上架' + data+'个产品');
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
		
		 function downShop(id) {
				 	$.ajax({
					url : "${ctx}" + "/ProductController/upOrDownShopProduct",
					data : {"productId" : id,"type" : "0"},
					type : "post",
					beforeSend : function() {
						if (window.confirm('你确定要下架吗？')) {
							//alert("确定");
							return true;
						} else {
							//alert("取消");
							return false;
						}
					},
					success : function(data) {
						if (data > 0) {
							alert('成功下架' + data+'个产品');
                            location.reload();
						} else {
							alert('操作失败!' );
						}
					},
					error : function() {
						alert('请求出错');
					} 
				});
				return false;
			}
		 
		
		    // 回填表单
			function editInfo(id,productName,price,count) {  
				//向模态框中传值  
			    $("#editProductId").val(id);  
 			    $("#editProductName").val(productName);  
			    $("#editPrice").val(price);  
			    $("#editCount").val(count);  
			   /* if (sex == '女') {  
			        document.getElementById('women').checked = true;  
			    } else {  
			        document.getElementById('man').checked = true;  
			    }  */
			    $('#editModal').modal('show');  
			}  
		   
	</script>
</body>
</html>
