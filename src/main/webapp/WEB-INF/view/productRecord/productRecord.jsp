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
<style type="text/css">
table td{
    vertical-align: middle !important;
}
  
</style>
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
						<i class="icon-th-list"></i> 订单管理
					</h1>

					<div class="right-content">
                         <div class="panel panel-default">
								<div class="panel-heading" >查询条件</div>
								<div class="panel-body">
								
								<form class="form-inline" role="form">
									<div class="form-group">
									    <label  for="productName">&nbsp;&nbsp;&nbsp;产品名称</label> 
										<input   class="form-control" name="productName" id="productName" placeholder="水果名字">
									    
									    
							 
				
				                        <label  for="state">&nbsp;&nbsp;&nbsp;订单类型</label> 
									     <select  id="state" name="state" class="form-control">
													<option value="" >所有订单</option>
													<option value="2">失效订单</option>
													<option value="3">成功订单</option>
													<option value="4">退货订单</option>
													<option value="0">未配送订单</option>
													<option value="1">配送中订单</option>
													
										</select>
											 <br/>	
									   
									    <label  for="orderTime">&nbsp;&nbsp;&nbsp;下单时间</label> 
										<input    class="dateSearch" name="orderTime" id="orderTime" placeholder="请输入下单时间">
									   
								   <c:choose>
								<c:when test="${user.getType()=='0'}">
									<label  for="userName">&nbsp;&nbsp;&nbsp;用户名称</label> 
									<input   class="form-control" name="userName" id="userName" placeholder="请输入用户名称">
												   
								</c:when>
								
							</c:choose>
							 &nbsp;&nbsp;&nbsp;
										<button type="button" style="margin-right: 20px"
											id="btn_query" onclick="searchProductRecord();" class="btn btn-primary">查询</button>
								   
									</div>
								 	
									</form>
									
								</div>
							</div>
							
							<div class="pre-scrollable">
							<table  class="table table-bordered" id="orderTable">
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
	<div class="modal hide fade" id="recordDetail" tabindex="-1" role="dialog">
		<div class="modal-header">
			<button class="close" type="button" data-dismiss="modal">×</button>
			<h3>用户地址详情</h3>
		</div>
		<div class="modal-body">
			<jsp:include page="recordDetail.jsp"></jsp:include>
		</div>
	</div>
 	<!-- 新增 Modal end -->
 	
	<jsp:include page="../include/footer.jsp"></jsp:include>
	<script>
	 
	
	
	 $(".dateSearch").datetimepicker({
		 format: "yyyy-mm-dd",
		 autoclose: true,//当选择一个日期之后是否立即关闭此日期时间选择器
		 todayBtn: true,//日期时间选择器组件的底部显示一个 "Today" 按钮用以选择当前日期
		 todayHighlight: true,//如果为true, 高亮当前日期
		 pickerPosition: "bottom-right",
		 language: 'zh-CN',//中文，需要引用zh-CN.js包
		 endDate:new Date(),
		 startView: 2,//日期时间选择器打开之后首先显示的视图。 可接受的值：2==月视图
		 minView: 2//日期时间选择器所能够提供的最精确的时间选择视图
		 });
	 
		$(document).ready(
			function() {
				var li = document.getElementById('order-active');
				li.setAttribute("class", "active");
				var path = "${ctx}"
						+ "/ProductRecordController/productRecordList";
				$('#orderTable').bootstrapTable({
				url : path,
				dataType : "json",
				contentType: "application/x-www-form-urlencoded",
				toolbar : '#toolbar', //工具按钮用哪个容器
				striped : true,
				cache : false, //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
				sortable : true, //是否启用排序
				sortOrder : "asc", //排序方式
				queryParamsType: "limit", //参数格式,发送标准的RESTFul类型的参数请求  
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
							field : 'orderId',
							title : '序号'
						},
						{
							field : 'productId',
							title : '序号'
						},
						{
							field : 'productName',
							title : '产品名称',
							formatter: function (value, row, index) { 
								var productName;
								var strs= new Array(); //定义一数组 
								strs=value.split(","); //字符分割 
								for (i=0;i<strs.length ;i++ ) 
								{ 
									if(productName==null){
										if(strs[i]!=null&&strs[i]!=""){
											productName=strs[i];
										} 
				
									}else{
										productName=productName+"<br/>"+"<br/>"+strs[i]; //分割后的字符输出 

									}
								} 
			                    return   productName;
			                }
						},
						{
							field : 'userName',
							title : '买家'
						},
						{
							field : 'price',
							title : '价格' ,
							formatter: function (value, row, index) { 
								var productPrice;
								var strs= new Array(); //定义一数组 
								strs=value.split(","); //字符分割 
								for (i=0;i<strs.length ;i++ ) 
								{ 
									if(productPrice==null){
										if(strs[i]!=null&&strs[i]!=""){
											productPrice=strs[i];
										}
									}else{
										productPrice=productPrice+"<br/>"+"<br/>"+strs[i]; //分割后的字符输出 

									}
								} 
			                    return   productPrice;
			                }
						},
						{
							field : 'count',
							title : '数量' ,
							formatter: function (value, row, index) { 
								var productCount;
								var strs= new Array(); //定义一数组 
								strs=value.split(","); //字符分割 
								for (i=0;i<strs.length ;i++ ) 
								{ 
									if(productCount==null){
										if(strs[i]!=null&&strs[i]!=""){
											productCount=strs[i];
										}
									
									}else{
										productCount=productCount+"<br/>"+"<br/>"+strs[i]; //分割后的字符输出 

									}
								} 
			                    return   productCount;
			                }
						},
						{
							field : 'address' 
						},
						{
							field : 'type' 
						},
						{
							field : 'addressName' 
						},
						{
							field : 'addressPhone' 
						},
						{
							field : 'orderTime',
							title : '购买时间',
							formatter: function (value, row, index) {  
			                    return value.substring(0,19);  
			                }
						},{
							field : 'totalMoney',
							title : '总价'
						},
						{
							title : '操作',
							field : 'doSomething',
							align : 'center',
							formatter : function(value, row,index) {
								 var e = '<a href="#" onclick="detail(\''
									+ row.userName+'\'\,\''
									+ row.addressName+'\'\,\''
									+ row.addressPhone+'\'\,\''
									+ row.address+
							'\')">地址详情</a> ';  
							
								
 							var typeUser=${user.type};
 							var d='<a href="#"  onclick="del(\'' + row.orderId + '\')">删除</a> ';
 							var cancelDel = '<a href="#"  onclick="cancelDel(\''+ row.orderId+ '\')">撤销删除</a> ';
 							var loseRecord='<p style="color:gray;font-size:16px;" >失效订单 </> ';
 							var successRecord='<p style="color:gray;font-size:16px;" >成功订单 </> ';
 							var noWantRecord='<p style="color:gray;font-size:16px;" >退货订单 </> ';
 							var loading = '<p style="color:blue;font-size:16px;" >正在配送   </> ';
 							var orderRecord='<a href="#"  onclick="cancelOrDownRecord(\''+ row.orderId+ '\'\,\'1\')">安排配送 </a> ';
 							var cancelRecord='<a href="#"  onclick="cancelOrDownRecord(\''+ row.orderId+'\'\,\'2\'\,\''
								+ row.productId+'\'\,\''+ row.count+ '\'\)">取消订单 </a> ';
							var sure= '<a href="#"  onclick="cancelOrDownRecord(\''
									+ row.orderId + '\'\,\'3\')">确认送达</a> ';
							var userSure= '<a href="#"  onclick="cancelOrDownRecord(\''
										+ row.orderId + '\'\,\'3\')">确认收货</a> ';
							var noWant = '<a href="#"  onclick="cancelOrDownRecord(\''+ row.orderId+'\'\,\'2\'\,\''
								+ row.productId+'\'\,\''+ row.count+ '\'\)">确认退货 </a> ';
 							if(row.state=="0"){
									if(typeUser=="0"){
										return 	orderRecord+e;
									}else{
										return  cancelRecord+e;
									}
									
								}else if(row.state=="1"){
									if(typeUser=="0"){
										 return loading+sure+noWant+e;
										}else{
											return loading+e;
										}
								} else if(row.state=="2"){
									 if(typeUser=="0"){
										 if(row.type=="0"){
											 return loseRecord+cancelDel+d+e; 
										 }
										 return loseRecord+d+e;
									 }else{
										 return loseRecord+d+e;
									 }
									
								}else if(row.state=="3"){
									 if(typeUser=="0"){
										 if(row.type=="0"){
											 return successRecord+cancelDel+d+e; 
										 }
										 return successRecord+d+e;
									 }else{
										 return successRecord+d+e;
									 }
								
								}else if(row.state=="4"){
									 if(typeUser=="0"){
										 if(row.type=="0"){
											 return noWantRecord+cancelDel+d+e; 
										 }
										 return noWantRecord+d+e;
									 }else{
										 return noWantRecord+d+e;
									 }
								
								}
 							 
							}
						} ]
			});
				

			var typeUser=${user.type};
			if(typeUser!='0') {
				$('#orderTable').bootstrapTable('hideColumn', 'userName');
			}
			
			 
			    $('#orderTable').bootstrapTable('hideColumn', 'orderId');
			    $('#orderTable').bootstrapTable('hideColumn', 'productId');
			    $('#orderTable').bootstrapTable('hideColumn', 'type');
				$('#orderTable').bootstrapTable('hideColumn', 'address');
				$('#orderTable').bootstrapTable('hideColumn', 'addressName');
				$('#orderTable').bootstrapTable('hideColumn', 'addressPhone');
				
    });

		  function searchProductRecord(){
			    var userName=$("#userName").val();
	            var productName=$("#productName").val();
			    var orderTime=$("#orderTime").val();
			    var state=$("#state").val();
			    var searchUrl="${ctx}"+ "/ProductRecordController/productRecordList?orderTime="+orderTime+"&&productName="+productName+"&&state="+state;
 		    	$('#orderTable').bootstrapTable('refresh', {url: searchUrl});  
		    	}
		  
		function del(id) {
		 	$.ajax({
				url : "${ctx}" + "/ProductRecordController/delProductRecord",
				data : {"orderId" : id},
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
						alert('操作成功' );
						location.reload();
					} else {
						alert('操作失败' );
					}
				},
				error : function() {
					alert('请求出错');
				} 
			});

			return false;
		}
		
		function delMore() {
			var row=$.map($('#orderTable').bootstrapTable('getSelections'), function (row) {
		        return row.orderId;
		    });
			if(row.length>0){

				$.ajax({
					url : "${ctx}" + "/ProductRecordController/delProductRecord?orderId="+row,
					data : {"orderId" : row},
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
							alert('操作成功');
							location.reload();
						} else {
							alert('操作失败');
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
		function detail(userName,addressName,addressPhone,address) {
			//向模态框中传值  
		    $("#userNameDetail").val(userName);  
		    $("#addressNameDetail").val(addressName);  
		    $("#addressPhoneDetail").val(addressPhone);  
		    $("#addressDetail").val(address); 
		   
		     
		    
			$('#recordDetail').modal('show');
			
		}
		 
		  function cancelDel(id) {
				$.ajax({
					url : "${ctx}" + "/ProductRecordController/cancelDel",
					data : {"orderId" : id},
					type : "post",
					success : function(data) {
						if (data > 0) {
							alert('操作成功');
							location.reload();
						} else {
							alert('操作失败');
						}
					},
					error : function() {
						alert('请求出错');
					} 
				});

				return false;
			}
		  
		  function cancelOrDownRecord(orderId,state,productId,count) {
			  alert(state);
				$.ajax({
					url : "${ctx}" + "/ProductRecordController/cancelOrDownRecord",
					data : {
						"orderId" : orderId,
						"productId" : productId,
						"count":count,
				     	"state":state},
					type : "post",
					success : function(data) {
						if (data > 0) {
							alert('操作成功');
							location.reload();
						} else {
							alert('操作失败');
						}
					},
					error : function() {
						alert('请求出错');
					} 
				});

				return false;
			}
			
	</script>
</body>
</html>
