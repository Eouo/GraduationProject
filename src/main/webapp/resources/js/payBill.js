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