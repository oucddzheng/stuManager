<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored= "false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.5.3/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.5.3/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.5.3/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.5.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.5.3/locale/easyui-lang-zh_CN.js"></script>

<script type="text/javascript">

function leaveApplicationStatus(statusStr , status){
	var selectedRows=$("#dg").datagrid('getSelections');
	if(selectedRows.length==0){
		$.messager.alert("系统提示","请选择要" + statusStr + "的记录！");
		return;
	}
	var strIds=[];
	for(var i=0;i<selectedRows.length;i++){
		strIds.push(selectedRows[i].id);
	}
	var ids=strIds.join(",");
	$.messager.confirm("系统提示","您确认要"+statusStr+"这<font color=red>"+selectedRows.length+"</font>位同学的请假申请吗？",function(r){
		if(r){
			$.post("${pageContext.request.contextPath}/sysLeaveAction/updateLeavelStatus.do?status="+status,{ids:ids},function(result){
				if(result.success){
					 $.messager.alert("系统提示","请假审批完成！");
					 $("#dg").datagrid("reload"); 
				}else{
					/* $.messager.alert("系统提示","数据删除失败！"); */
				}
			},"json");
		}
	});
	
}
function selectLeaveRecord(){
	
	window.location.href = "leavelRecordForEducation.jsp";
}


</script>
<style>
   *{
      padding:0px;
      margin:0px;
   }
</style>

</head>
<body style="margin:1px;">
	<table id="dg" title="请假情况" class="easyui-datagrid" fitColumns="true"  pagination="true"  rownumbers="true"
	 url="${pageContext.request.contextPath}/sysLeaveAction/getLeaveInformationByEducational.do" fit="true" toolbar="#tb">
	 <thead>
	 	<tr>
	 		<th field="cb" checkbox="true" align="center"></th>
	 		<th field="id" width="50" align="center" hidden = "true"></th>
	 		<th field="userTrueName" width="50" align="center">学生</th>
	 		<th field="why" width="100" align="center">事由</th>
	 		<th field="createTime" width="100" align="center">申请时间</th>
	 		<th field="beginTime" width="100" align="center">开始时间</th>	 		
	 		<th field="endTime" width="100" align="center">截至时间</th>
	 		<th field="descr" width="80" align="center">备注</th>
	 	</tr>
	 </thead>
	</table>
	<div id="tb">
		<div style = "">
			<a href="javascript:leaveApplicationStatus( '同意' , 8)" class="easyui-linkbutton" iconCls="icon-add" plain="true">同意</a>
			<a href="javascript:leaveApplicationStatus( '驳回' , 7)" class="easyui-linkbutton" iconCls="icon-edit" plain="true">驳回</a>
			<a href="javascript:selectLeaveRecord()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">查看学生请假记录</a>
		</div>
	</div>
</body>
</html>