<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
 
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
	    <meta charset="utf-8">
	    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	    <meta name="viewport" content="width=device-width, initial-scale=1">
	    
		<jsp:include page="include/header.jsp"></jsp:include>
		<title>水果买卖平台</title>

	</head>

	<body>
	
	<jsp:include page="include/top.jsp"></jsp:include>
	
	<div id="content">
	
	  <div class="container">
		
	    	<div class="row">
		        <jsp:include page="include/user_menu.jsp"></jsp:include>
		         <div class="span9">
				
				<h1 class="page-title">
					<i class="icon-th-list"></i>
					购买产品					
				</h1>
	 
				<div class="right-content">
				<div class="panel panel-default">
								<div class="panel-heading" >查询条件</div>
								<div class="panel-body">
								
								<form class="form-inline" role="form">
									<div class="form-group">
									    <label  for="productName">名称</label> 
										<input style="height: 25px"  class="form-control" name="productName" id="productName" placeholder="请输入水果名称">
									   <label  for="startMoney">价格区间</label> 
										<input style="height: 25px"  class="form-control" name="startMoney" id="startMoney" placeholder="请输入最低价">
								       —— <input style="height: 25px"  class="form-control" name="endMoney" id="endMoney" placeholder="请输入最高价">
									   
										<button type="button" style="margin-right: 20px"
											id="btn_query" onclick="searchProduct();" class="btn btn-primary">查询</button>
								   
									</div>
								 	
									</form>
									
								</div>
							</div>
                 <div class="pre-scrollable">
				   <table   class="table table-bordered" id="productTable">
				 </table>
				 </div>
				</div>
			</div> <!-- /span9 -->
			
	      </div> <!-- /row -->
		
	 </div> <!-- /container -->
	
    </div> <!-- /content -->
  <!-- 加入购物车Modal start -->
	<div class="modal hide fade" id="shopModal" tabindex="-1" role="dialog">
		<div class="modal-header">
			<button class="close" type="button" data-dismiss="modal">×</button>
			<h3>加入购物车</h3>
		</div>
		<div class="modal-body">
			<jsp:include page="shopCard/addShopCard.jsp"></jsp:include>
		</div>
	</div>
	<!-- 加入购物车Modal end -->
	
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
	
<jsp:include page="include/footer.jsp"></jsp:include>
   <script >
  
    $(document).ready(function(){
    var li=document.getElementById('product-active');
    li.setAttribute("class","active");
    var path="${ctx}"+"/ProductController/productlist";
    $('#productTable').bootstrapTable({
    url: path, 
    dataType: "json",
    toolbar: '#toolbar',                //工具按钮用哪个容器
    striped: true, 
    showToggle:true,                    //是否显示详细视图和列表视图的切换按钮
    cache: false,   //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
    sortable: true,   //是否启用排序
    sortOrder: "asc",   //排序方式
    queryParamsType: "limit", //参数格式,发送标准的RESTFul类型的参数请求  
	queryParams: function (params) {
			return {
	    	    rows: this.pageSize,
	            page: this.pageNumber,
	            productName:$("input[name='productName']").val(),
	            startMoney:$("#startMoney").val(),
	            endMoney:$("#endMoney").val()
	        };
	    },
    singleSelect: false,
    pagination: true, //分页
    pageNumber:1, 
    clickToSelect: true,
    pageSize: 10,                       //每页的记录行数（*）
    pageList: [10, 25, 50, 100],        //可供选择的每页的行数（*）
    sidePagination: "client", //客户端处理分页
    formatNoMatches: function () {  //没有匹配的结果
	    return '无符合条件的记录';
	  },
          columns: [ {
				field: 'imgUrl',
                title: '',
                align: 'center' ,
                width:60,
                formatter: function (value, row, index) {  
                	 return '<img  src="${pageContext.request.contextPath}/resources/img/'+value+'">'
                }
               
                 
            },{
              field: 'productId',
              title: '序号'
          }, {
              field: 'productName',
              title: '产品名称'
          }, {
              field: 'price',
              title: '价格'
          }, {
              field: 'count',
              title: '可拍数量'
          },
          {
              title: '操作',
              field: 'doSomething',
              align: 'center',
              formatter:function(value,row,index){  
            	  var e = '<a href="#" onclick="shop(\''
						+ row.productId+'\'\,\''
						+ row.productName+'\'\,\''
						+ row.price+'\'\,\''
						+ row.count+
				'\')">加入购物车</a> ';
				if(row.imgUrl!=null){
					var p= '<a href="#" onclick="photo(\''
						+ row.imgUrl+
				'\')">查看图片</a> ';
	                return p+e;
				}
				
                return e;  
            }}
      ]
      });
    $('#productTable').bootstrapTable('hideColumn', 'productId');
    });
    function searchProduct(){
	   
    	var searchUrl="${ctx}"+ "/ProductController/productlist";
     	$('#productTable').bootstrapTable('refresh', {url: searchUrl});  
    	}
    
    // 回填购物车
	function shop(id,productName,price,count) {  
		//向模态框中传值  
	    $("#shopProductId").val(id);  
		$("#shopProductName").val(productName);  
	    $("#shopPrice").val(price); 
	    $("#maxCount").val(count);
	    
	    $("#shopProductId").prop("readonly","readonly");
	    $("#shopProductName").prop("readonly","readonly");
 	    $("#shopPrice").prop("readonly","readonly");
 	    $("#shopdetail").prop("readonly","readonly");
	    
	    $('#shopModal').modal('show');  
	}  
    
    
	function photo(imgUrl) {  
		//向模态框中传值  
		$("#divImg").empty();
	    var img='<img width="400"  src="${pageContext.request.contextPath}/resources/img/'+imgUrl+'">'
	    $('#divImg').append(img);
	    $('#photoModal').modal('show');  
	    
	}  

    </script>
	</body>
</html>
