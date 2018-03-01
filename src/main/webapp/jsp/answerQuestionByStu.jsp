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
			url : "/stu-system-web/sysCreateQuestionAction/selectQuestionForAnswerOfStu.do?code=" + questionnaireCode,
			type : "POST",
			dataType : "json",
			contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
			success : function(dataResult) {	
				$("#dg").datagrid({data:dataResult}); 
				}				
			});
       }

   function addAnswerChecks(value,row,index){
	   
	   var code = row.code
	   var str =( "<div id ='"+code+"'>"
			       + "<span>"
				      +"<input id = '"+"answerA"+code+"' value = 'A'  name='checkboxforcheck' onchange='singleChoice(\""+code+"\",\"answerA\")' type = 'checkbox'>"
					  +"<span>A</span>"
				    +"</span>&nbsp&nbsp"
				    + "<span>"
				      +"<input id = '"+"answerB"+code+"' value = 'B' name='checkboxforcheck' onchange='singleChoice(\""+code+"\",\"answerB\")' type = 'checkbox'>"
					  +"<span>B</span>"
				    +"</span>&nbsp&nbsp"
				    + "<span>"
				      +"<input id = '"+"answerC"+code+"' value = 'C' name='checkboxforcheck' onchange='singleChoice(\""+code+"\",\"answerC\")' type = 'checkbox'>"
					  +"<span>C</span>"
				    +"</span>&nbsp&nbsp"
			       +"</div>"
	                );
	   return str;		  
	  }
   /* 下面这段代码实现了选择答案时的单选功能 */
   function  singleChoice(code , answerOption){		
	      $("div[id='"+code+"'] input[name='checkboxforcheck']").each(function(){
			 $(this).prop("checked",false) 
		}) 
		 $("#"+answerOption+code).prop("checked",true)  
	}
   function saveQuestionAnswer(){
	   var rows = $("#dg").datagrid("getRows"); //这段代码是获取当前页的所有行。
	   var questionCodeAndAnswer='';
	   for(var i=0;i<rows.length;i++)
	   {
	      var code = rows[i].code;
	      $("div[id='"+code+"'] input[name='checkboxforcheck']").each(function(){
 	    	  if($(this).is(":checked")){	    		   
 	    		 questionCodeAndAnswer += (code+$(this).val()+",")
 	    	  }	    	
	      }); 	      
	   }
	   var questionnaireCode = '${questionnaireCode}';
	     $.ajax({
			url : "/stu-system-web/sysStudentAnswerAction/saveStuQuestionnaireRelAndAnswer.do",
			type : "POST",
			data : {"qestionnaireCode" : questionnaireCode , "questionCodeAndAnswer" : questionCodeAndAnswer},
			dataType : "json",
			contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
			success : function(data) {	
				if(data.result){
					$.messager.alert("系统提示","问卷已经成功提交！");
				}else{
					$.messager.alert("系统提示","问卷提交失败！")
				}
			},   
       }) ; 
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
	 	    <th data-options="field:'operation',width:20,align:'center',formatter: addAnswerChecks">选择答案</th> 
	 </tr>
	 </thead>
	</table>	
	
	
	<div id="tb" style="width:100%">
		<p id = "questionnaireNameId"></p>
	</div>
	<br>
	<div style = " width: 100%  ; text-align:center"><a href="javascript:saveQuestionAnswer()" class="easyui-linkbutton" iconCls="icon-ok">提交</a></div>
	
	
</body>
</html>