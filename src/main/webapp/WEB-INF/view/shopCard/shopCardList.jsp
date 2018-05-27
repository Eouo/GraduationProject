<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>

<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
 <link href="${pageContext.request.contextPath}/resources/css/product.css" rel="stylesheet" />

<jsp:include page="../include/header.jsp"></jsp:include>
<title>水果买卖平台</title>
<style type="text/css">
table tr td span{
     display: inline-block;
     cursor:pointer;
     width: 28px;
     height: 24px;
     line-height: 24px;
     text-align: center;
     font-size: 15px;
     border: 1px solid #e6e6e6;
 } 
 table tr td input{
 margin-top: 7px;
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
						<i class="icon-th-list"></i> 购物车
					</h1>

					<div class="right-content">
                         
							<div id="toolbar" class="btn-group">
								<input type="button" class="btn btn-primary" value="删除" onclick="delMore()" />
							</div>
							<div class="pre-scrollable">
							<table data-search="true"  class="table table-bordered"
								id="shopCardTable">
							</table>
						    </div>
						    <div >
								<input class="btn btn-primary" type="button"  value="  结算    " onclick="payBill()" />
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
 
	
	<!-- edit Modal -->
	<div class="modal hide fade" id="editModal" tabindex="-1" role="dialog">
		<div class="modal-header">
			<button class="close" type="button" data-dismiss="modal">×</button>
			<h3>修改信息</h3>
		</div>
		<div class="modal-body">
			<jsp:include page="editShopCard.jsp"></jsp:include>
		</div>
	</div>
	<!-- edit Modal end -->

<div class="modal hide fade" id="shopPayBillModal" tabindex="-1" role="dialog">
		<div class="modal-header">
			<button class="close" type="button" onclick="location.reload()" data-dismiss="modal">×</button>
			<h3>支付信息</h3>
		</div>
		<div class="modal-body">
			<jsp:include page="payBill.jsp"></jsp:include>
		</div>
	</div>
	
	<!--查看大图Modal start -->
	<div class="modal hide fade" id="photoModal" tabindex="-1" role="dialog">
		<div class="modal-header">
			<button class="close" type="button" data-dismiss="modal">×</button>
			<h3>图片</h3>
		</div>
		<div id="divImg" class="modal-body">
 		</div>
	</div>
	<!-- 查看大图Modal end -->
	
	<jsp:include page="../include/footer.jsp"></jsp:include>
 	<script src="${pageContext.request.contextPath}/resources/js/product.js"></script>
	
	<script>
$(document).ready(function() {
	var li = document.getElementById('shopcard-active');
	li.setAttribute("class", "active");
	var path = "${ctx}"+ "/ShopCardController/shopCardList";
	$('#shopCardTable').bootstrapTable(
					{
						url : path,
						dataType : "json",
						toolbar : '#toolbar', //工具按钮用哪个容器
						striped : true,
						cache : false, //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
						sortable : true, //是否启用排序
						sortOrder : "asc", //排序方式
						showRefresh : true,//刷新功能  
						search : true,//搜索功能 
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
									field : 'shopCardId',
									title : '序号'
								},{
									field: 'imgUrl',
									title:"",
									formatter: function (value, row, index) {  
					                    return '<img width="50" src="/img?imgName='+value+'">';  
					                },
					                width:60,
					                align:'center' 
					            },{
									field : 'productName',
									title : '产品名称'
								},{
									field : 'price',
									title : '价格'
								},
 
								{
									field : 'count',
									title : '数量',
									align:'center' ,
									formatter: function (value, row, index) {  
										
										var spanFront='<span id="tableDecreaseCssById'+index+'"  onclick="decreaseCount(\'tableCount'+index+'\'\,\'tableDecreaseCssById'+index+'\'\,\'tableAddCssById'+index+'\')">—</span>';
										var inputCount='<input style="width:40px;" type="text" value=" '+value+' " name="tableCount" id="tableCount'+index+'" onkeyup=\'this.value=this.value.replace(\/\\D\/gi\,"")\'>';
										var spanlast='<span id="tableAddCssById'+index+'" onclick="addCount(\'tableCount'+index+'\'\,\'tableDecreaseCssById'+index+'\'\,\'tableAddCssById'+index+'\'\,\' '+
										row.allCount+'\')">+</span>';

										return spanFront+inputCount+spanlast;  
					                }
								},{
									field : 'allCount',
									title : '可买数量'
								},{
									field : 'type',
									title : '状态',
									formatter:function(value, row,index){
										if(value=="1"){
											return '<p style="color:black" >可购买</>';
									    }else{
									    	return '<p style="color:gray" >已失效</>';
									    }
									}
								},{
									title : '操作',
									field : 'doSomething',
									align : 'center',
									formatter : function(value, row, index) {
                                         
										   var bb = '<a href="#" onclick="saveInfo(\''
												+ row.shopCardId+'\'\,\''
												+ row.allCount+'\'\,\''
												+ index+ 
										        '\')">保存</a> ';
										   var d = '<a href="#"  onclick="del(\'' + row.shopCardId+ '\')">删除</a> ';
											
                                                 if(row.imgUrl!=null){
                                 					var p= '<a href="#" onclick="photo(\''
                                 						+ row.imgUrl+
                                 				'\')">查看图片</a> ';
                                 	                return p+bb+d;
                                 				}
                                 				
										return  bb+ d;
									}
								} ]
					});
	$('#shopCardTable').bootstrapTable('hideColumn', 'shopCardId');
          });
		
		//保存数量
		function saveInfo(id,count,index) {  
			//向模态框中传值  
			var maxCount=parseInt(count);
 		    var tableCount= parseInt($("#tableCount"+index).val());  
 		   if($("#tableCount"+index).val()==null||$("#tableCount"+index).val()==""){
 				alert("数量不能为空！！");
 				$("#tableCount"+index).val(1)
 				return false;
 			}
 	      if(tableCount<=0){
 	    	  alert("数量有误！请重新选择！");
 	    	 $("#tableCount"+index).val(1);
 	    	  return false;
 	      }else if(tableCount>maxCount){
 	    	 alert(maxCount+"数量不能大于库存！请重新选择！"+tableCount);
 	    	$("#tableCount"+index).val(maxCount);
	    	  return false;
 	      }else{
 	    $.ajax({  
 	        type: "post",  
 	        url:  "${ctx}" + "/ShopCardController/editShopCard?shopCardId="+id+"&&count="+tableCount,
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
 				location.reload();
 			}
 	    }); 
 	    return false;} 
 	      
 		}
		
		
		function delMore() {
			var row=$.map($('#shopCardTable').bootstrapTable('getSelections'), function (row) {
		        return row.shopCardId;
		    });
			if(row.length>0){

				$.ajax({
					url : "${ctx}" + "/ShopCardController/delShopCard?shopCardId="+row,
					data : {"shopCardId" : row},
					type : "post",
					dataType : "json",
					contentType: "application/x-www-form-urlencoded",
					beforeSend : function() {
						if (window.confirm('你确定要删除吗？')) {
 							return true;
						} else {
							alert(row)
 							return false;
						}
					},
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
					},
				});
			}else{ 
				alert("请至少选择一条数据");
				return false;
		   }
		}
		
function del(id) {
			 
			$.ajax({
				url : "${ctx}" + "/ShopCardController/delShopCard",
				data : {
					"shopCardId" : id,
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
		

function photo(imgUrl) {  
	//向模态框中传值  
	$("#divImg").empty();
    var img='<img width="400"  src="/img?imgName='+imgUrl+'">'
    $('#divImg').append(img);
    $('#photoModal').modal('show');  
    
}  

function payBill() {
    
    //勾选的产品的状态
	var type=$.map($('#shopCardTable').bootstrapTable('getSelections'), function (row) {
        return row.type;
    });
	//勾选的产品购物车Id
	var shopCardId=$.map($('#shopCardTable').bootstrapTable('getSelections'), function (row) {
        return row.shopCardId;
    });
	
	//判断结算数量是否大于库存
	var row=$('#shopCardTable').bootstrapTable('getSelections');
		for(var i=0;i<row.length;i++){
		if(parseInt(row[i].count)>parseInt(row[i].allCount)){
			alert(row[i].count+"--"+row[i].productName+"购买数量不能超过"+row[i].allCount+"!!");
			return false;
		}
	}
	
	if(type.indexOf('0')!=-1){
		alert('失效产品不能结算，请重新勾选！！');
		return  false;
	}else if(type.indexOf('1')<0){
		alert('请选择产品！');
		return false;
	}
	
	$("#testList").val(shopCardId);
	var allMoney=0;
	var typeAdd=0;
	var typtCount=0;
	var path = "${ctx}"+ "/ShopCardController/shopCardListSelective?shopCardIdMore="+shopCardId;
	var addressPath = "${ctx}"+ "/UserController/addresslist";
	
	//结算产品的信息表
	$('#shopCardPayListTable').bootstrapTable({
						url : path,
						dataType : "json",
						columns : [{
									field : 'shopCardId',
									title : '序号'
								},{
									field : 'productName',
									title : '产品名称'
								},{
									field : 'price',
									title : '价格'
								},{
									field : 'count',
									title : '数量'
								},{
									field : '',
									title : '总价',
									formatter:function(value, row,index){
										var perMoney=row.count*row.price;
										allMoney=allMoney+perMoney;
											document.getElementById ("allMoney").innerText=allMoney;
											return perMoney;
									}
								}]
					});
	
	//该用户的地址信息表
	$('#payAddressTable').bootstrapTable({
				url : addressPath,
				dataType : "json",
				singleSelect : true,
				clickToSelect : true,
				columns : [{
                    checkbox: true,
                    width:10,
                    formatter:function(value, row,index){
						if(row.type=="1"){
							return true;
						}
						}
                }, {
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
				},
				{
					field : 'type' 
				} ]
			});
	$('#payAddressTable').bootstrapTable('hideColumn', 'addressId');
	$('#payAddressTable').bootstrapTable('hideColumn', 'type');
	    $('#shopPayBillModal').modal('show');
}


	</script>
</body>
</html>
