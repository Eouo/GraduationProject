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
		<jsp:include page="include/header.jsp"></jsp:include>
		<title>水果买卖平台</title>

	</head>

	<body>
	
	<jsp:include page="include/top.jsp"></jsp:include>
	 <div class="bg bg-blur"></div>
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
					   <div id="productDiv">
							 <input type="hidden" id="num" value="0">
							 <input type="hidden" id="totalCount" >  
					  </div>
					 
					 </div>
					 
					 <div class="pageDiv">
					  	 
		    			总共<a id="all" href="#" ></a> 页&nbsp;&nbsp;当前第<a id="sort" href="#" ></a>页&nbsp;&nbsp;
		    			    <a  href="#" onclick="firstPage();">首页</a>&nbsp;
		    				<a href="#" onclick="upPage();">上页</a>&nbsp;
		    			    <a href="#" onclick="nextPage();">下页</a>&nbsp;
		    				<a href="#" onclick="lastestPage();">尾页</a>&nbsp;
	 						 
					  </div>
				</div>
			</div> <!-- /span9 -->
			
	      </div> <!-- /row -->
		
	 </div> <!-- /container -->
	
    </div> <!-- /content -->
    
   
	
	 <!-- detail Modal start -->
	<div class="modal hide fade" id="detailModal" tabindex="-1" role="dialog">
		<div class="modal-header">
			<button class="close" type="button" data-dismiss="modal" onclick="closeModal('decreaseCssById','addCssById');">×</button>
			<h3>产品详情</h3>
		</div>
		<div class="modal-body">
			<jsp:include page="product/detailProduct.jsp"></jsp:include>
		</div>
	</div>
	<!-- detail Modal end -->
	
	
  <!-- 加入购物车Modal start -->
	<div class="modal hide fade" id="shopModal" tabindex="-1" role="dialog">
		<div class="modal-header">
			<button class="close" type="button" data-dismiss="modal" onclick="closeModal('decreaseShopCssById','addShopCssById');">×</button>
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
<script src="${pageContext.request.contextPath}/resources/js/product.js"></script>
   <script >
   
   $(document).ready(function(){
   	
	    var li=document.getElementById('product-active');
	    li.setAttribute("class","active");
	    var path="${ctx}"+"/ProductController/productlist?num=0";
		    $.ajax({  
		        type: "post",  
		        url:  path,
		        success : function(data){
	 	        	if(data.length>0){
	 	        		 var totalCount=Math.floor(parseInt(data[0].total)/10);
	 	        	     $("#totalCount").val(totalCount);
	 	        		 document.getElementById("all").innerText=totalCount+1;
	 	        		 document.getElementById("sort").innerText="1";
		        		 shopProduct(data);
		        	}
		        },
		        error : function() {
					alert('请求出错');
					location.reload();
				}
		    });  
	    });
   
   function shopProduct(data) {
		  
	 	  var div=document.getElementById("productDiv");
	 	  $('#ulId').remove();
	 	
	 	  var ul=document.createElement('ul');
	 	  ul.setAttribute("id", "ulId");
	      ul.setAttribute("class", "tabContent");
	     // var json = eval(data); //数组  
	      var totalCount= $("#totalCount").val();
	         
	      $("#totalyCount").val(num+1); 
	       $.each(data, function (index, item) {  
	          //循环获取数据    
	          var productId = data[index].productId; 
	          var productName = data[index].productName; 
	          var price = data[index].price; 
	          var count = data[index].count;
	          var detailMessage = data[index].detail;
	          var imgUrl = data[index].imgUrl; 
				
	          var li = document.createElement('li');
	          var aDetail = document.createElement('a');
	          aDetail.addEventListener("click",function(){
	        	  detail(productId,productName,price,count,detailMessage,imgUrl);
	          });
	          var img = document.createElement("img");
	          img.src="/img?imgName="+imgUrl;
	           var spanName=document.createElement('span');
	          var spanPrice=document.createElement('span');
	          spanName.innerHTML="商品："+productName+"<br/>";
	         // spanName.appendChild("br/");
	          spanPrice.innerHTML="价格："+price+"<br/>";
	          spanPrice.setAttribute("class","price");
	          
	          var aShopCard = document.createElement('a');
	          aShopCard.innerText="加入购物车";
	          aShopCard.addEventListener("click",function(){
	        	  shop(productId,productName,price,count,imgUrl);
	          });
	          aDetail.appendChild(img);
	          li.appendChild(aDetail);
	          li.appendChild(spanName);
	          li.appendChild(spanPrice);
	          li.appendChild(aShopCard);
	          ul.appendChild(li);
	      });   
	      div.appendChild(ul);
		}
   
   
    // 回填购物车
	function shop(id,productName,price,count,imgUrl) {  
		//向模态框中传值  
	    $("#shopProductId").val(id);  
		$("#shopProductName").val(productName);  
	    $("#shopPrice").val(price); 
	    $("#maxShopCount").val(count);
 
	    $('#shopModal').modal('show');  
	}  
    
    
    
	 // 商品详情
	function detail(id,productName,price,count,detailMessage,imgUrl) {  
		//向模态框中传值  
	    $("#detailProductId").val(id);  
		$("#detailProductName").val(productName);  
	    $("#detailPrice").val(price); 
	    $("#detailMessage").val(detailMessage); 
	    $("#maxDetailCount").val(count);
 	    $("#imgDetail").attr("src","/img?imgName="+imgUrl);
	   
	    $('#detailModal').modal('show');  
	}  
	function photo(imgUrl) {  
		//向模态框中传值  
		$("#divImg").empty();
	    var img='<img width="400"  src="/img?imgName='+imgUrl+'">'
	    $('#divImg').append(img);
	    $('#photoModal').modal('show');  
	    
	}  

	 function searchProduct(){
	      $("#num").val(0);
	      var numstart= $("#num").val();//向input加1
	      alert(numstart);
	      var productName=$("#productName").val();
	  	  var startMoney=$("#startMoney").val();
	  	  var endMoney=$("#endMoney").val();
	  	  
	  	  var path="${ctx}"+"/ProductController/productlist";
	  	    $.ajax({  
	  	        type: "post",
	  	        dataType:"json",
	  	        url:  path,
	  	        data:{
	  	        	"num" :numstart,
	  	        	"productName":productName,
	  	        	"startMoney":startMoney,
	  	        	"endMoney":endMoney
	  	        },
	  	        success : function(data){
	  	        	if(data.length>0){
	  	        		var totalCount=Math.floor(parseInt(data[0].total)/10);
		        	     $("#totalCount").val(totalCount);
		        		 document.getElementById("all").innerText=totalCount+1;
		        		 document.getElementById("sort").innerText="1";
		        		shopProduct(data);
		        	}
	   	        },
	  	        error : function() {
	  				alert('请求出错');
	  				location.reload();
	  			}
	  	    });
	    	}
	    
	 function ajaxFuction(){
		  
	      var numstart=$("#num").val();
		  var productName=$("#productName").val();
		  var startMoney=$("#startMoney").val();
		  var endMoney=$("#endMoney").val();
		  var path="${ctx}"+"/ProductController/productlist";
		    $.ajax({  
		        type: "post",
		        dataType:"json",
		        url:  path,
		        data:{
		        	"num" :numstart,
		        	"productName":productName,
		        	"startMoney":startMoney,
		        	"endMoney":endMoney
		        },
		        success : function(data){
		        	shopProduct(data);
		        },
		        error : function() {
					alert('请求出错1');
					location.reload();
				}
		    });
  }
    </script>
	</body>
</html>
