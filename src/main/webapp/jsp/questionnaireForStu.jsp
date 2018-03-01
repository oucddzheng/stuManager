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
	  getCreateQuestionForStu();	   
   })
    function getCreateQuestionForStu(){
	   $.ajax({
			url : "/stu-system-web/sysCreateQuestionAction/selectCreateQuestionForStu.do",
			type : "POST",
			dataType : "json",
			contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
			success : function(dataResult) {	
				$("#dg").datagrid({data:dataResult}); 
				}				
			});
       }
   
 
 
  function addatag(value,row,index){
	  var operationStatus = row.operation;
	  if(operationStatus=='0'){
		  var code = row.code;
		  var forword = 'answerQuestionByStu';
		  var questionnaireName = row.questionnaireName;
		  return '<a href=\"/stu-system-web/sysCreateQuestionAction/dispacherForQuestionnaire.do?code='+code+'&forword='+forword+'&questionnaireName='+questionnaireName+'\">开始回答</a>'
	  }
	  if(operationStatus=='1'){
		  var code = row.code;
		  var forword = 'showAnswer';
		  var questionnaireName = row.questionnaireName;
		  return '<a href=\"/stu-system-web/sysCreateQuestionAction/dispacherForQuestionnaire.do?code='+code+'&forword='+forword+'&questionnaireName='+questionnaireName+'\">已答，查看答题结果</a>'
	  }
	  
  }
	
</script>
</head>
<body style="margin:1px;">  
	<table id="dg"  class="easyui-datagrid" data-options="	                                       
											border:false,
											fit:true,
											striped:true,
											checkOnSelect:false,
											fitColumns:true,
											toolbar:'#tb',"																					
											>
	
	 <thead>
      <tr>	 	
	 	    <th data-options="field:'cb',width:20,align:'center'"  checkbox="true" ></th>
	 	    <th data-options="field:'id',width:20,align:'center'">编号</th>
	 	    <th data-options="field:'code',width:20,align:'center',hidden: 'true'"></th>
	 	    <th data-options="field:'questionnaireName',width:20,align:'center'">问卷标题</th>
			<th data-options="field:'descr',width:20,align:'center'">备注</th> 				
	 	    <th data-options="field:'operation',width:20,align:'center',formatter: addatag">操作</th> 	 	    
	 </tr>
	 </thead>
	</table>	
	<div id="tb" style="width:100%">
		
	</div>
	
</body>
</html>