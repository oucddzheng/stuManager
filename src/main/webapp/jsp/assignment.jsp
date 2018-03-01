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
			url : "/stu-system-web/sysAasignmentAction/getAasignmentInformation.do",
			type : "POST",
			dataType : "json",
			contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
			success : function(dataResult) {	
				$("#dg").datagrid({data:dataResult}); 
				}				
			});
       }
    function getAttendenceStatus(){
	   $.ajax({
			url : "/stu-system-web/sysDictionaryAction/getDictionary.do?type=3",
			type : "POST",
			dataType : "json",
			contentType : 'application/x-www-form-urlencoded; charset=UTF-8',//防止乱码
			success : function(data) {	
				var attendenceStatusJson =  [{
					name: '请选择作业类型...',
					code: ''
				}];
				for(var i = 0;i<data.length;i++){
					var attendenceStatus = data[i];
					attendenceStatusJson.push({code:attendenceStatus.code,name:attendenceStatus.name})
				}				
				setComboxValue( attendenceStatusJson ,   "typeId" , "code" , "name");							  			  
			}
		});
   }    	
	
	function closeUserDialog(){
		$("#dlg").dialog("close");
		
	}	
	function openUserAttendenceInformation(){
		var time = $("#dateboxId").datebox("getValue");
		if(time ==""){
			$.messager.alert("系统提示","请选择日期");
			return false;
		} 		 
		$("#dlg").dialog("open").dialog("setTitle","录入家庭作业");
		getAttendenceStatus()
		
	}	
	function saveAttendenceRecord(){
		var time = $("#dateboxId").datebox("getValue");
		if(time ==""){
			$.messager.alert("系统提示","请选择日期");
			return false;
		} 		 	
		
		var homeworkName = $("#homeworkId").textbox("getText");
		    if($.trim(homeworkName)==''){
		    	$.messager.alert("系统提示","作业题目不能为空");
		    	return false;
		    }
        var homeworkType = $("#typeId" ).combobox("getValue")
			if(homeworkType==""){
				$.messager.alert("系统提示","请输入作业类型");
				return false;
			}
        
        var gradeStandard = $("#gradeStandardId").textbox("getValue");
            if($.trim(gradeStandard) == ''){
            	$.messager.alert("系统提示","作业评分标准不能为空");
            }
		 $.ajax({
				url : "/stu-system-web/sysAasignmentAction/saveAasignment.do",
				type : "POST",
				data: {"time": time , "homeworkName": homeworkName , "type": homeworkType , "gradeStandard":gradeStandard },
				dataType : "json",
				contentType : 'application/x-www-form-urlencoded; charset=UTF-8',//防止乱码
				success : function(data) {					
					if(data.success){
						$("#dg").datagrid("reload");
						$.messager.alert("系统提示","作业发布成功");
					}else{
						$.messager.alert("系统提示","作业发布失败");
					}									   			  			  
				}
			});				 
	}	
	
	var code ; 
	  function addatag(value,row,index){
		  code = row.code;	 
		  return '<a href=\"javascript:checkWorkCondition()\" class=\"easyui-linkbutton\" iconCls=\"icon-add\" plain=\"true\" style=\"margin-left:50px\">查看答题情况</a>'
	  }
	  
    function checkWorkCondition(){
	    $("#dlgOfCheckAssignmentConditionId").dialog("open").dialog("setTitle","该题的完成情况");
	    $.ajax({
			url : "/stu-system-web/sysAssignmentConditionAction/getAasignmentConditionCheck.do",
			type : "POST",
			data: {"code": code },
			dataType : "json",
			contentType : 'application/x-www-form-urlencoded; charset=UTF-8',//防止乱码
			success : function(dataResult) {					
				$("#dgCheckId").datagrid({data:dataResult}); 					   			  			  
			}
		});				 	
			
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
	 	    <th data-options="field:'checkWorkCondition',width:20,align:'center',formatter: addatag">操作</th> 
	 	    
	 	    
	 	</tr>
	 </thead>
	</table>
	
    
	
	<div id="tb" style="width:100%">
		<div>
		     &nbsp选择日期：<input  id="dateboxId"  type= "text" class= "easyui-datebox" required ="required" > </input> 		
		    <a href="javascript:openUserAttendenceInformation()" class="easyui-linkbutton" iconCls="icon-add" plain="true" style="margin-left:50px">录入作业</a>
		
		</div>
	</div>
	
	<div id="dlg" class="easyui-dialog" style="width: 620px;height:250px;padding: 10px 20px"
	  closed="true" buttons="#dlg-buttons">
	 	<form id="fm" method="post">	 	
	 	   <table cellspacing="8px">
	 			<tr>
	 				<td>作业题目：</td>
	 				<td><input type="text" id="homeworkId" name="userAccount" class="easyui-textbox"  required="true"/>&nbsp;<font color="red">*</font></td>
	 				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	 				<td>作业类型：</td>	 				
	 			    <td> <select class="easyui-combobox" id="typeId" name="classCode"  required="true" style="width: 154px;" editable="false" panelHeight="auto">	 						
	 					</select>&nbsp;<font color="red">*</font>
	 				</td>			
	 			
	 			</tr>
	 			<tr>
	 			    <td>评分标准：</td>
	 			   <td><input type="text" id="gradeStandardId" name="descr" required="false" class="easyui-textbox" data-options="multiline:true" />&nbsp;</td> 	  				
	 			</tr>
	 		</table> 
	 	</form>
	</div>
	
	
	<div id="dlgOfCheckAssignmentConditionId" class="easyui-dialog" style="width: 620px;height:250px;padding: 10px 20px" closed="true" >
	 	
	 	<table id="dgCheckId"  class="easyui-datagrid" data-options="	                                       
											border:false,
											fit:true,
											striped:true,
											checkOnSelect:false,
											fitColumns:true,"																					
											>
	
	 <thead>
      <tr>	 		 	    
	 	    <th data-options="field:'trueName',width:20,align:'center'">姓名</th>
			<th data-options="field:'oneself_score',width:20,align:'center'">分数</th>
			<th data-options="field:'oneself_grade',width:20,align:'center'">等级</th>				 	    
	 </tr>
	 </thead>
	</table>	
	 	
	 	
	</div>
	
	
	
	<div id="dlg-buttons">
		<a href="javascript:saveAttendenceRecord()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
		<a href="javascript:closeUserDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
	
</body>
</html>