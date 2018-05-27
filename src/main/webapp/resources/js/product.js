//sort:第几页（1开始）
//页数 sort-1(0开始)
//totalCount:总页数
   
   function firstPage(){
	   
	   var  totalCount=parseInt($("#totalCount").val());//总页数
	 	  var num= parseInt($("#num").val());
	 	  document.getElementById("sort").innerText="1";//当前页数
	 	  if(num==0){
	 		  alert("已是首页！");
	 		  return false;
	 	  }
		  $("#num").val(0); 
		  ajaxFuction();
   }
   function lastestPage(){
	   var  totalCount=parseInt($("#totalCount").val());
	 	  var num= parseInt($("#num").val());
	 	  if(num==totalCount){
	 		  alert("已是最后一页！");
	 		  return false;
	 	  }
	 	  document.getElementById("sort").innerText=totalCount+1;
		  $("#num").val(totalCount); 
		  ajaxFuction();
   }
   function upPage(){
	   var  totalCount=parseInt($("#totalCount").val());
	 	  var num= parseInt($("#num").val());
	 	  if(num==0){
	 		  alert("已是首页！");
	 		  return false;
	 	  }
		  document.getElementById("sort").innerText=num;

		  $("#num").val(num-1); 
		  ajaxFuction();
   }
   function nextPage(){
	  var  totalCount=parseInt($("#totalCount").val());
 	  var num= parseInt($("#num").val());
 	 document.getElementById("sort").innerText=num+2;
 	  if(num>=totalCount){
 		  alert("已是最后一页！");
 		  return false;
 	  }
	  $("#num").val(num+1);//向input加1
	  ajaxFuction();
  }
  
 

   
   
   
/*	
	
	//减的效果
	$("#decreaseCount").click(function(){
	var n=$(this).next().val();
	if(parseInt(n)<=1){
		$("#decreaseCount").attr("class","classSpan");
		return false;
	}
	$("#addCount").removeClass("classSpan");
	$("#decreaseCount").removeClass("classSpan");
	var num=parseInt(n)-1;
	$(this).next().val(num);
	});
	
	
	$("#addCount").click(function(){
 		var n=$(this).prev().val();
		if(parseInt(n)>=parseInt($("#maxDetailCount").val())){
			$("#addCount").attr("class","classSpan");
 			return false;
		}
		$("#decreaseCount").removeClass("classSpan");
		$("#addCount").removeClass("classSpan");
		var num=parseInt(n)+1;
		$(this).prev().val(num);
		});*/
	
	
	//购物车数量减的效果
	function decreaseCount(inputId,decreaseId,addId){

		var n=$("#"+inputId).val();
		if(n==null||n==""){
			alert("数量不能为空！！");
			$("#"+inputId).val(1);
			return false;
		}
		if(parseInt(n)<=1){
		$("#"+decreaseId).attr("class","classSpan");
 		return false;
	}
	$("#"+addId).removeClass("classSpan");
	$("#"+decreaseId).removeClass("classSpan");
	var num=parseInt(n)-1;
	$("#"+inputId).val(num)
		}
	
	//购物车数量加的效果
	function addCount(inputId,decreaseId,addId,macCount){
		var n=$("#"+inputId).val();
		if(n==null||n==""){
			alert("数量不能为空！！");
			$("#"+inputId).val(1);
			return false;
		}
		if(parseInt(n)>=parseInt($("#"+macCount).val())){
			$("#"+addId).attr("class","classSpan");
 			return false;
		}
		$("#"+addId).removeClass("classSpan");
		$("#"+decreaseId).removeClass("classSpan");
		var num=parseInt(n)+1;
		$("#"+inputId).val(num)
		}
	
	
	//提交购物车
	function addshopCard(Count,maxCount,Form){  
 	      var detailCount=$("#"+Count).val();
	      var maxCount=parseInt($("#"+maxCount).val());
	      if(parseInt(detailCount)>maxCount||parseInt(detailCount)<=0||detailCount==""){
	    	  alert("数量有误！请重新选择！");
	    	  return false;
	      }
	    $.ajax({  
	        type: "post",  
	        url:   "ShopCardController/addShopCard",
	        data:$('#'+Form).serialize(),
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
	    return false; 
	}	
	

	
    
    function closeModal(decreaseId,addId){
		 $("#detailCount").val("1");
		 $("#shopCount").val("1");
		 $('#shopModal').modal('hide');
		 $('#detailModal').modal('hide');
		 $("#"+decreaseId).removeClass("classSpan");
		 $("#"+addId).removeClass("classSpan");
		 
	}