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
	function saveNewQuestionnaire(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length==0){
			$.messager.alert("系统提示","请选择要添加的试题！");
			return;
		}
		var questionnaireName = $("#questionTitleId").val();
		if($.trim(questionnaireName)==''){
			$.messager.alert("系统提示","请输入问卷标题");
		}
		
		
		var strCodes=[];
		for(var i=0;i<selectedRows.length;i++){
			strCodes.push(selectedRows[i].code);
		}
		var codes=strCodes.join(",");
			 $.ajax({
				url : "/stu-system-web/sysCreateQuestionAction/saveCreateQuestion.do",
				type : "POST",
				data: {"questionName": questionnaireName , "codes": codes },
				dataType : "json",
				contentType : 'application/x-www-form-urlencoded; charset=UTF-8',//防止乱码
				success : function(data) {					
					if(data.success){
						$("#dg").datagrid("reload");
						$.messager.alert("系统提示","问卷创建成功");
					}else{
						$.messager.alert("系统提示","问卷创建失败");
					}									   			  			  
				}
			});				  
		};
		
		
</script>
</head>
<body style="margin:1px;">    
	<table id="dg"  class="easyui-datagrid"
	 fitColumns="true"  pagination="true"  rownumbers="true"
	 url="${pageContext.request.contextPath}/sysQuestionLibraryAction/selectAllQuestions.do" fit="false" toolbar="#tb">
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
			&nbsp;问卷标题：&nbsp;<input type="text" id="questionTitleId" size="20" onkeydown="if(event.keyCode==13) searchUser()"/>	
		</div>
		<div>
			&nbsp;请从一下题库中选择要加入的题目&nbsp;
		</div>
	</div>
	<br>
	<div style = " width: 100%  ; text-align:center"><a href="javascript:saveNewQuestionnaire()" class="easyui-linkbutton" iconCls="icon-ok">提交</a></div>
	
</body>
</html>