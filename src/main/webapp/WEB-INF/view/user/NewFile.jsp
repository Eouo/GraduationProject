<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title><%=request.getParameter("title")%></title>
</head>

<body>
	<!-- 头部引入 -->
	<%@ include file="/jsp/public/header.jspf"%>
	<div class="main">
		<!-- 左侧菜单 -->
		<%@ include file="/jsp/public/menu.jsp"%>

		<div class="left-side">
			<div class="contrain">
				<div class="position">
					<a class="a2" href=""><span class="iconfont">&#xe600;</span></a> <span
						class="iconfont">&#xe601;</span> <span><%=request.getParameter("title")%></span>
				</div>
				<!-- 操作部分 -->
				<div class="bgroup text-right">
					<!-- <s:a action="dataRule_addUI" cssClass="button bPrimary"><i class="iconfont">&#xe611;</i>新增</s:a>
                    <a href="###" class="button bSuccess" onclick="editRule();"><i class="iconfont">&#xe60e;</i>编辑</a>
                    <a href="###" class="button bInfo" onclick="collectRule();"><i class="iconfont">&#xe610;</i>收藏</a>
                    <a href="###" class="button bDanger" onclick="delRule();" id="delRuleId"><i class="iconfont">&#xe612;</i>删除</a> -->
				</div>
				<div class="showMessage">
					<!-- 表单部分 -->
					<form class="form-inline" id="taskList_form">

						<div class="form-group">
							<c:set var="querywhere" value="state='1'" />
							<c:if test="${not empty param.pdKey}">
								<c:set var="querywhere" value="pdKey='${param.pdKey}'" />
							</c:if>
							流程名称：
							<OATag:select cssclass="form-control pdKey" name="pdKey"
								classname="ProcDefExtend" listkey="pdName"
								otherattr="${not empty param.pdKey?'disabled':''}"
								listvalue="pdKey" querywhere="${querywhere}"
								value="${param.pdKey}" auth="false" />
						</div>


						<div class="form-group">
							开单人：<input name="openUserName"
								onkeypress="if(event.keyCode==13)
                            {$('#bnt_search').click();return false;}"
								class="form-control" />
						</div>

						<div class="form-group pdate">
							<label for="date">送达时间：</label> <input
								class="form-control layer-date" id="start" placeholder="请选择开始日期"
								name="startDate" /> <i class="iconfont">&#xe613;</i>
						</div>

						<div class="form-group pdate">
							<label for="date">至</label> <input
								class="form-control layer-date" id="end" placeholder="请选择结束日期"
								name="endDate" /> <i class="iconfont">&#xe613;</i>
						</div>

						<%-- <div class="form-group">
                          <label for="keywords">关键词：</label>
                          <s:textfield type="text" cssClass="form-control" name="keyword" id="keywords" value="%{keyword}" placeholder="请输入关键词"/>
                        </div> --%>
						<div class="form-group">
							<a href="javascript:void(0);" class="button bPrimary"
								id="bnt_search" onclick="_search();"><i class="iconfont"></i>查询</a>
						</div>
					</form>
					<!-- 表格部分 -->
					<div class="content">
						<div class="table-responsive">
							<div id="toolbar">
								<a href="javascript:void(0);"
									onclick="batchSignTask('同意','ok');"><i
									class="icon iconfont">&#xe60d;</i>批量同意/提交</a>
							</div>
							<table id="taskList_table" class="table-striped table-hover"
								data-mobile-responsive="true"></table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
	var $table = $("#taskList_table");
	$table
			.bootstrapTable({
				url : '${ctx}/task_list.action', //请求后台的URL（*）
				method : 'post', //请求方式（*）
				toolbar : '#toolbar', //工具按钮用哪个容器
				striped : true, //是否显示行间隔色
				cache : false, //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
				pagination : true, //是否显示分页（*）
				contentType : "application/x-www-form-urlencoded",
				sidePagination : "server", //分页方式：client客户端分页，server服务端分页（*）
				pageNumber : 1,
				pageSize : 10,
				pageList : [ 10, 25, 50, 100, 'All' ],
				smartDisplay : false,//智能显示分页按钮
				paginationPreText : "上一页",
				paginationNextText : "下一页",
				queryParams : function(params) {
					return {
						rows : this.pageSize,
						page : this.pageNumber,
						webRequest : true,
						/* pdKey:"${not empty param.pdKey?param.pdKey:''}" */
						pdKey : $(".pdKey").val(),
						openUserName : $("input[name='openUserName']").val(),
						startDate : $("input[name='startDate']").val(),
						endDate : $("input[name='endDate']").val()
					};
				},
				search : false, //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
				strictSearch : true,
				showColumns : true, //是否显示所有的列
				showRefresh : true, //是否显示刷新按钮
				minimumCountColumns : 2, //最少允许的列数
				clickToSelect : true, //是否启用点击选中行
				showToggle : true, //是否显示详细视图和列表视图的切换按钮
				cardView : false, //是否显示详细视图
				detailView : false, //是否显示父子表
				idField : 'DBID_',
				sortName : 'CREATE_',
				sortOrder : 'desc',
				sortable : true, //是否启用排序
				columns : [ [
						{
							field : 'DBID_',
							checkbox : true
						},
						{
							field : 'flowImg',
							title : '签核图',
							width : 100,
							formatter : function(value, rowData, rowIndex) {
								return '<img src="/common/js/jquery-easyui-1.3.3/themes/icons/workflow.png" style="Cursor:pointer" title="流程图" alt="流程图" onclick="top.tabShow(\'流程图：'
										+ rowData.pdName
										+ '\',\'${ctx}/workflow/central!trackTask.action?proDbId='
										+ rowData.PROCINST_ + '\')"/>';
							}
						},
						{
							field : 'pdName',
							title : '流程名称',
							sortable : true,
							width : 180
						},
						{
							field : 'flowNo',
							title : '编号',
							width : 200,
							formatter : function(value, rowData, rowIndex) {
								var div = '<a href="#" onclick="top.tabShow(\''
										+ rowData.pdName
										+ '\',\'/workflow/central!showTaskForm.action?taskId='
										+ rowData.DBID_ + '\')">' + value
										+ '</a>';
								return div;
							}
						}, {
							field : 'ACTIVITY_NAME_',
							title : '关卡名称',
							width : 200
						}, {
							field : 'keyWord_',
							title : '主旨',
							width : 400
						}, {
							field : 'username',
							title : '开单人',
							width : 100
						}, {
							field : 'prevMemberName_',
							title : '送出人',
							width : 100
						}, {
							field : 'CREATE_',
							title : '送达时间',
							sortable : true,
							width : 200
						}, {
							field : 'TASKSTATE_',
							title : '状态',
							width : 200,
							formatter : function(value, rowData, rowIndex) {
								var div = '未读';
								if ("2" == value) {
									div = "已读";
								}
								return div;
							}
						} ] ]
			});
	//初次5分钟后执行
	window.setTimeout(_search, 1000 * 60 * 5);

	//-处理搜索功能------------------------------------

	//搜索按钮绑定回车事件
	document.onkeydown = function(event) {
		if (event.keyCode == 13) {
			event.cancelBubble = true;
			event.returnValue = false;
			_search();
		}
	}

	function _search() {
		$table.bootstrapTable('refresh', {
			url : '${ctx}/task_list.action'
		});
		/* var data = null;
		var pdKey = $(".pdKey").val();
		var openUserName=$("input[name='openUserName']").val();
		var startDate=$("input[name='startDate']").val();
		var endDate=$("input[name='endDate']").val();
		var pageSize = $(".page-size")[0].firstChild.data;
		var pageNumber = $(".page-number.active a").text();
		if(pdKey!=null){
		    data={rows:pageSize,page:pageNumber,pdKey:pdKey,openUserName:openUserName,startDate:startDate,endDate:endDate,webRequest: true};
		}else{
		    data={rows:pageSize,page:pageNumber,webRequest:true,pdKey:"${not empty param.pdKey?param.pdKey:''}"};
		}

		$.ajax({
		    url:'${ctx}/workflow/central!findTaskList.action',
		    type:'post',
		    dataType:'json',
		    data:data, 
		    success:function(json,textstatus){
		        $table.bootstrapTable('removeAll');
		        $table.bootstrapTable('load',json);
		    }
		}); */
	}

	/**
	 *批次操作表单
	 */
	function batchSignTask(signTypeLabel, signType) {
		var rows = $table.bootstrapTable('getSelections');
		if (rows.length > 0) {
			var taskId = "";
			for (var i = 0; i < rows.length; i++) {
				if (taskId != "") {
					taskId += ",";
				}
				taskId += rows[i].DBID_;
			}
			top.sy.dialogSimp({
				title : '签核视窗',
				queryParams : {
					'signTypeLabel' : signTypeLabel,
					'signType' : signType
				},
				href : '${ctx}/jsp/workflow/dialog/signCommentWin.jsp'
			},
					'${ctx}/workflow/central!signTask.action?batchSignTask=1&taskId='
							+ taskId, wf_tl_data);
		} else {
			Confirm.show('提示', '请选取要批次操作的数据行！');
		}
	}
</script>
<script type="text/javascript">
	// 日历控件处理
	var start = {
		elem : '#start',
		format : 'YYYY-MM-DD',
		/* min: laydate.now(), //设定最小日期为当前日期 */
		max : '2099-06-16', //最大日期
		istime : true,
		istoday : false,
		choose : function(datas) {
			end.min = datas; //开始日选好后，重置结束日的最小日期
			end.start = datas //将结束日的初始值设定为开始日
		}
	};
	var end = {
		elem : '#end',
		format : 'YYYY-MM-DD',
		/* min: laydate.now(), */
		max : '2099-06-16',
		istime : true,
		istoday : false,
		choose : function(datas) {
			start.max = datas; //结束日选好后，重置开始日的最大日期
		}
	};
	laydate(start);
	laydate(end);
	laydate.skin('molv');
</script>
</html>