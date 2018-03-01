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
<script type="text/javascript" src="${pageContext.request.contextPath}/js/easyui-tool-functions.js"></script>
<script type="text/javascript">


   $(document).ready(function(){	
	  getQuestionForStuAnswer(); 	
	  var questionnaireName = '${questionnaireName}'
	  $("#questionnaireNameId").text(questionnaireName );
   })
    function getQuestionForStuAnswer(){
	   var questionnaireCode = '${questionnaireCode}';
	   $.ajax({
			url : "/stu-system-web/sysStudentAnswerAction/selectQuestionnaireAnswer.do?questionnaireCode=" + questionnaireCode,
			type : "POST",
			dataType : "json",
			contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
			success : function(dataResult) {	
				$("#dg").datagrid({data:dataResult}); 
				}				
			});
       }
   
   
</script>
</head>
<body style="margin:1px;">  
	<table id="dg"  class="easyui-datagrid" data-options="	                                       
											border:false,
											fit:false,
											striped:true,
											checkOnSelect:false,
											fitColumns:true,
											toolbar:'#tb',"																					
											>
	
	 <thead>
      <tr>	 	
	 	   <!--  <th data-options="field:'cb',width:20,align:'center'"  checkbox="true" ></th> -->
	 	    <th data-options="field:'id',width:20,align:'center'">编号</th>
	 	    <th data-options="field:'code',width:20,align:'center',hidden: 'true'"></th>
	 	    <th data-options="field:'questionTitle',width:20,align:'center'">题目</th>
			<th data-options="field:'questionOption',width:20,align:'center'">选项</th> 
	 	    <th data-options="field:'answer',width:20,align:'center'">已选答案</th> 
	 </tr>
	 </thead>
	</table>	
	
	
	<div id="tb" style="width:100%">
		<p id = "questionnaireNameId"></p>
	</div>
	
	
</body>
</html>