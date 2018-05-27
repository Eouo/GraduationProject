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
		        <jsp:include page="include/admin_menu.jsp"></jsp:include>
		         <div class="span9">
				
				<h1 class="page-title">
					<i class="icon-th-list"></i>
					产品管理					
				</h1>
	  	        <div class="pre-scrollable">
	  
				 <table  data-search="true" class="table table-bordered" id="productTable">
				 </table>
				 </div>
 			</div> <!-- /span9 -->
			
	      </div> <!-- /row -->
		
	 </div> <!-- /container -->
	
    </div> <!-- /content -->
    
    
    
     
	 <!-- picture Modal start -->
	<div class="modal hide fade" id="productPictureModal" tabindex="-1" role="dialog">
			<div class="modal-header">
				<button class="close" type="button" data-dismiss="modal" >×</button>
				<h3>更换图片</h3>
			</div>
 	   <div class="modal-body">
			<jsp:include page="product/changeProductPicture.jsp"></jsp:include>
		</div>
	</div>
	<!-- picture Modal end -->
	
	
	
   <!-- 新增 Modal start -->
	<div class="modal hide fade" id="addModal" tabindex="-1" role="dialog">
		<div class="modal-body">
			<jsp:include page="product/addProduct.jsp"></jsp:include>
		</div>
	</div>
	<!-- 新增 Modal end -->
	
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
    cache: false,   //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
    sortable: true,   //是否启用排序
    sortOrder: "asc",   //排序方式
    showRefresh: true,//刷新功能  
    search: true,//搜索功能 
    singleSelect: false,
    pagination: true, //分页
    pageNumber:1,
    clickToSelect: true,
    pageSize: 7,                       //每页的记录行数（*）
    pageList: [7, 14,21],
    showColumns: false,
    sidePagination: "client", //客户端处理分页
    formatNoMatches: function () {  //没有匹配的结果
	    return '无符合条件的记录';
	  },
          columns: [{  
              title: '序号',
              formatter: function (value, row, index) {  
                  return index+1;  
              },
              width:60,
              align:'center' 
       },{
			field: 'imgUrl',
			title:"",
			formatter: function (value, row, index) {  
                return '<img width="50"  src="/img?imgName='+value+'">';    
            },
            width:60,
            align:'center' 
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
            	  
            	  var p = '<a href="#" onclick="changeProductPicture(\''
						+ row.productId+'\'\,\''
						+ row.productName+'\'\,\''
						+ row.imgUrl+
		'\')">更换图片</a> ';
            	  var d = '<a href="#"  onclick="downShop(\''
						+ row.productId
						+ '\')">下架</a> ';
				  return p+d;  
            }}
      ]
      });
    $('#productTable').bootstrapTable('hideColumn', 'productId');
    });
    function downShop(id) {
		if (!id) {
			alert('Error！');
			return false;
		}
		// var form_data = new Array();

		$.ajax({
			url : "${ctx}" + "/ProductController/upOrDownShopProduct",
			data : {"productId" : id,"type" : "0"},
			type : "post",
			beforeSend : function() {
				if (window.confirm('你确定要下架吗？')) {
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
	
	
    </script>
	</body>
</html>
