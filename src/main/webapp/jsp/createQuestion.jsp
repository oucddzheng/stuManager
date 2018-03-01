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
      
    
	
	
	/* function searchQuestions(){
		$("#dg").datagrid('load',{
			"questionTitle":$("#questionTitleId").val()
		});
	} */
	
	/* function deleteQuestions(){
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
		
	}  */
	
	
	function openQuestionAddDialog(){
		window.location.href="${pageContext.request.contextPath}/jsp/newQuestionnaire.jsp"
	}
	
	
 
	
	 /* function openQuestionUpdateDialog(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要编辑的数据！");
			return;
		}
		var row=selectedRows[0];
		$("#dlg").dialog("open").dialog("setTitle","编辑用户信息");
		$('#fm').form('load',row);
		url="${pageContext.request.contextPath}/sysQuestionLibraryAction/updateQuestions.do?id="+row.id;
	}  */
	
	/*  function resetValue(){
		$("#questionTitleId").val("");
		$("#questionOptionId").val("");
		$("#questionAnswerId").val("");
		$("#descrId").val("");
	}  */
	
	/* function closeUserDialog(){
		$("#dlg").dialog("close");
		resetValue();
	}  */
	
	var code ; 
	  function addatagDetails(value,row,index){
		  code = row.code;	 
		  return '<a href=\"javascript:checkWorkCondition()\" class=\"easyui-linkbutton\" iconCls=\"icon-add\" plain=\"true\" style=\"margin-left:0px\">查看</a>'
	  }
	  function addatagAnalysis(value,row,index){
		 
		  var code = row.code;
		  var forword = 'questionnaireAnalysis';
		  var questionnaireName = row.questionnaireName;
		  return '<a href=\"/stu-system-web/sysCreateQuestionAction/dispacherForQuestionnaire.do?code='+code+'&forword='+forword+'&questionnaireName='+questionnaireName+'\">查看</a>'
	  
	  }
	  function addatagOperation(value,row,index){
		  code = row.code;	 
		  return '<a href=\"javascript:checkWorkCondition()\" class=\"easyui-linkbutton\" iconCls=\"icon-add\" plain=\"true\" style=\"margin-left:0px\">删除</a>'
	      
	  
	  
	  
	  }
	  
	
</script>
</head>
<body style="margin:1px;">
	<table id="dg"  class="easyui-datagrid"
	 fitColumns="true"  pagination="true"  rownumbers="true"
	 url="${pageContext.request.contextPath}/sysCreateQuestionAction/selectCreateQuestion.do" fit="true" toolbar="#tb">
	 <thead>
	 	<tr>
	 		<!-- <th field="cb" checkbox="true" align="center"></th>
	 		<th field="id" width="50" align="center">问卷序号</th> -->
	 		
	 		
	 		<th data-options="field:'cb',width:20,align:'center'" checkbox="true"></th> 
	 		<th data-options="field:'id',width:20,align:'center'">问卷序号</th> 
	 		<th data-options="field:'code',width:20,align:'center',hidden: 'true'"></th> 		
	 		<th data-options="field:'questionnaireName',width:20,align:'center'">问卷标题</th> 
	 		<th data-options="field:'questionnaireDetails',width:20,align:'center',formatter: addatagDetails">问卷详情</th> 
	 		<th data-options="field:'questionnaireAnalysis',width:20,align:'center',formatter: addatagAnalysis">问卷分析</th> 
	 		<th data-options="field:'operation',width:20,align:'center',formatter: addatagOperation">操作</th> 
	 		 			 		
	 	</tr>
	 </thead>
	</table>
	<div id="tb">
		<div>
			<a href="javascript:openQuestionAddDialog()" class="easyui-linkbutton" iconCls="icon-add" plain="true">创建问卷</a>		
		</div>
		<div>
			&nbsp;问卷名称：&nbsp;<input type="text" id="questionTitleId" size="20" onkeydown="if(event.keyCode==13) searchUser()"/>
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