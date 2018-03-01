<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored = "false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.5.3/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.5.3/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.5.3/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.5.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.5.3/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">
  
    $(document).ready(function(){
    	 
    })
      
    
	var url;  //url用来保存请求的地址
	
	function searchQuestions(){
		$("#dg").datagrid('load',{
			"questionTitle":$("#questionTitleId").val()
		});
	}
	
	function deleteQuestions(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length==0){
			$.messager.alert("系统提示","请选择要删除的数据！");
			return;
		}
		var strIds=[];
		for(var i=0;i<selectedRows.length;i++){
			strIds.push(selectedRows[i].id);
		}
		var ids=strIds.join(",");
		$.messager.confirm("系统提示","您确认要删除这<font color=red>"+selectedRows.length+"</font>条数据吗？",function(r){
			if(r){
				$.post("${pageContext.request.contextPath}/sysQuestionLibraryAction/deleteByUpdate.do",{ids:ids},function(result){
					if(result.success){
						$.messager.alert("系统提示","数据已成功删除！");
						$("#dg").datagrid("reload");
					}else{
						$.messager.alert("系统提示","数据删除失败！");
					}
				},"json");
			}
		});
		
	} 
	
	
	function openQuestionAddDialog(){
		$("#dlg").dialog("open").dialog("setTitle","添加问题");
	    url="${pageContext.request.contextPath}/sysQuestionLibraryAction/saveQuestion.do";
	}
	
	
	function saveQuestion(){
	
		$("#fm").form("submit",{
			url:url,
			onSubmit:function(){				
				return $(this).form("validate");/* 这个方法是用来做表单验证的，当所有字段都有效时返回true */
			},
			success:function(result){
				var result=eval('('+result+')');
				if(result.success){
					$.messager.alert("系统提示","保存成功");
					 resetValue();
					$("#dlg").dialog("close");
				    $("#dg").datagrid("reload");  
				}else{
					$.messager.alert("系统提示","保存失败");
					return;
				}
			}
		});
	}
	
	 function openQuestionUpdateDialog(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要编辑的数据！");
			return;
		}
		var row=selectedRows[0];
		$("#dlg").dialog("open").dialog("setTitle","编辑用户信息");
		$('#fm').form('load',row);
		url="${pageContext.request.contextPath}/sysQuestionLibraryAction/updateQuestions.do?id="+row.id;
	} 
	
	 function resetValue(){
		$("#questionTitleId").val("");
		$("#questionOptionId").val("");
		$("#questionAnswerId").val("");
		$("#descrId").val("");
	} 
	
	function closeUserDialog(){
		$("#dlg").dialog("close");
		resetValue();
	}
</script>
</head>
<body style="margin:1px;">
	<table id="dg"  class="easyui-datagrid"
	 fitColumns="true"  pagination="true"  rownumbers="true"
	 url="${pageContext.request.contextPath}/sysQuestionLibraryAction/selectAllQuestions.do" fit="true" toolbar="#tb">
	 <thead>
	 	<tr>
	 		<th field="cb" checkbox="true" align="center"></th>
	 		<th field="id" width="50" align="center">题号</th>
	 		<th data-options="field:'code',width:20,align:'center',hidden: 'true'"></th>
	 		<th field="questionTitle" width="100" align="center">题目</th>
	 		<th field="questionOption" width="100" align="center">选项</th>
	 		<th field="questionAnswer" width="100" align="center">答案</th>	 		
	 		<th field="descr" width="80" align="center">备注</th>
	 	</tr>
	 </thead>
	</table>
	<div id="tb">
		<div>
			<a href="javascript:openQuestionAddDialog()" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a>
			<a href="javascript:openQuestionUpdateDialog()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
			<a href="javascript:deleteQuestions()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
		
		</div>
		<div>
			&nbsp;题目：&nbsp;<input type="text" id="questionTitleId" size="20" onkeydown="if(event.keyCode==13) searchUser()"/>
			<a href="javascript:searchQuestions()" class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索</a>
		</div>
	</div>
	
	<div id="dlg" class="easyui-dialog" style="width: 620px;height:250px;padding: 10px 20px"
	  closed="true" buttons="#dlg-buttons">
	 	<form id="fm" method="post">	 	
	 	   <table cellspacing="8px">
	 			<tr>
	 			    
	 				<td>题目：</td>
	 				<td><input type="text" id="questionTitleId" name="questionTitle" class="easyui-validatebox" required="true"/>&nbsp;<font color="red">*</font></td>
	 				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	 				<td>选项：</td>
	 				<td><input type="text" id="questionOptionId" name="questionOption" class="easyui-validatebox" required="true"/>&nbsp;<font color="red">*</font></td>
	 			</tr>
	 			<tr>
	 				<td>答案：</td>
	 				<td><input type="text" id="questionAnswerId" name="questionAnswer" class="easyui-validatebox" required="true"/>&nbsp;<font color="red">*</font></td>
	 				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	 				<td>备&nbsp注：</td>
	 			    <td><input type="text" id="descrId" name="descr" required="false" class="easyui-textbox" />&nbsp;</td> 
	 			</tr>
	 			
	 		</table> 
	 	</form>
	</div>
	
	<div id="dlg-buttons">
		<a href="javascript:saveQuestion()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
		<a href="javascript:closeUserDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
</body>
</html>