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
	   /* 在页面加载的时候从数据库中获得该老师布置过的所有作业  */
	   getAllAasignmentInformation();	   
   })
    function getAllAasignmentInformation(){
	   $.ajax({
			url : "/stu-system-web/sysAssignmentConditionAction/getAssignmentCondition.do",
			type : "POST",
			dataType : "json",
			contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
			success : function(dataResult) {	
				$("#dg").datagrid({data:dataResult}); 
				}				
			});
       }
   
  function selfEvaluation() {	
	  $("#dlg").dialog("open").dialog("setTitle","自我评分");
	  getDictionaryStatus(4);	  
  }    
  var code ; 
  function addatag(value,row,index){
	  code = row.code;	 
	  return '<a href=\"javascript:selfEvaluation()\" class=\"easyui-linkbutton\" iconCls=\"icon-add\" plain=\"true\" style=\"margin-left:50px\">自我评分</a>'
  }
    function getDictionaryStatus(type){
	   $.ajax({
			url : "/stu-system-web/sysDictionaryAction/getDictionary.do?type=" + type,
			type : "POST",
			dataType : "json",
			contentType : 'application/x-www-form-urlencoded; charset=UTF-8',//防止乱码
			success : function(data) {
				var evaluationGradeJson =  [{
					name: '请选择评级...',
					code: ''
				}];
				for(var i = 0;i<data.length;i++){
					var evaluationStatus = data[i];
					evaluationGradeJson.push({code:evaluationStatus.code,name:evaluationStatus.name})
				}				
				setComboxValue( evaluationGradeJson ,   "evaluationId" , "code" , "name");							  			  
			}
		});
   }    	
	
	
	function saveAssignmentConditionRecord(){	 	
		
		var oneselfScore = $("#oneselfScoreId").textbox("getText");
		    if($.trim(oneselfScore)==''){
		    	$.messager.alert("系统提示","分数不能为空");
		    	return false;
		    }
	    
        var evaluationGrade = $("#evaluationId" ).combobox("getValue")
			if(evaluationGrade==""){
				$.messager.alert("系统提示","评分等级不能为空");
				return false;
			}       
		 $.ajax({
				url : "/stu-system-web/sysAssignmentConditionAction/saveAssignmentCondition.do",
				type : "POST",
				data: {"assignmentCode": code , "oneselfScore": oneselfScore , "oneselfGrade":evaluationGrade },
				dataType : "json",
				contentType : 'application/x-www-form-urlencoded; charset=UTF-8',//防止乱码
				success : function(data) {					
					if(data.success){						
						$.messager.alert("系统提示","评价成功");
						getAllAasignmentInformation();	
						
					}else{
						$.messager.alert("系统提示","评价失败");
					}									   			  			  
				}
			});				  
	}	
	
	/* 关闭对话框  */
	function closeDialog(){
		$("#dlg").dialog("close");
		
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
	 	    <th data-options="field:'time',width:20,align:'center'">时间</th>
		    <th data-options="field:'homeworkName',width:20,align:'center'">作业题目</th>
			<th data-options="field:'gradeStandard',width:20,align:'center'">评分标准</th>
			<th data-options="field:'type',width:20,align:'center'">作业类型</th> 	
			<th data-options="field:'oneself_score',width:20,align:'center'">分数</th>
			<th data-options="field:'oneself_grade',width:20,align:'center'">等级</th>
			<th data-options="field:'descr',width:20,align:'center'">备注</th> 				
	 	    <th data-options="field:'selfEvaluation',width:20,align:'center',formatter: addatag">操作</th> 	 	    
	 </tr>
	 </thead>
	</table>	
	<div id="tb" style="width:100%">
		<div>
		     <!-- &nbsp选择日期：<input  id="dateboxId"  type= "text" class= "easyui-datebox" required ="required" > </input> 		
		    <a href="javascript:openUserAttendenceInformation()" class="easyui-linkbutton" iconCls="icon-add" plain="true" style="margin-left:50px">录入作业</a> -->		
		</div>
	</div>
	
	<div id="dlg" class="easyui-dialog" style="width: 620px;height:250px;padding: 10px 20px"
	  closed="true" buttons="#dlg-buttons">
	 	<form id="fm" method="post">	 	
	 	   <table cellspacing="8px">
	 			<tr>
	 				<td>分数：</td>
	 				<td><input type="text" id="oneselfScoreId" name="" class="easyui-textbox"  required="true"/>&nbsp;<font color="red">*</font></td>
	 				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	 				<td>评级：</td>	 				
	 			    <td> <select class="easyui-combobox" id="evaluationId" name="classCode"  required="true" style="width: 154px;" editable="false" panelHeight="auto">	 						
	 					</select>&nbsp;<font color="red">*</font>
	 				</td>				 			
	 			</tr>
	 		</table> 
	 	</form>
	</div>	
	<div id="dlg-buttons">
		<a href="javascript:saveAssignmentConditionRecord()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
		<a href="javascript:closeDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
	
</body>
</html>