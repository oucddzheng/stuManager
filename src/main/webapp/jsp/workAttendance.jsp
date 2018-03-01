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
    	 /* getRoles(); *//* 该函数在加载页面的时候从库中获得角色分类别 */
    	/*  getClasses(); *//* 在页面加载的时候从库中获得班级的名称 */
    })
    function getAttendenceStatus(){
	   $.ajax({
			url : "/stu-system-web/sysDictionaryAction/getDictionary.do?type=2",
			type : "POST",
			dataType : "json",
			contentType : 'application/x-www-form-urlencoded; charset=UTF-8',//防止乱码
			success : function(data) {	
				var attendenceStatusJson =  [{
					name: '请选择考勤状态...',
					code: ''
				}];
				for(var i = 0;i<data.length;i++){
					var attendenceStatus = data[i];
					attendenceStatusJson.push({code:attendenceStatus.code,name:attendenceStatus.name})
				}					
				setComboxValue( attendenceStatusJson ,  "checkOne" , "code" , "name");
				setComboxValue( attendenceStatusJson ,  "checkTwo", "code" , "name");
				setComboxValue( attendenceStatusJson ,  "checkThree", "code" , "name");
				setComboxValue( attendenceStatusJson  , "checkFour", "code" , "name");
				setComboxValue(attendenceStatusJson   , "checkFive", "code" , "name");
				setComboxValue(attendenceStatusJson   , "checkSix", "code" , "name");			  			  
			}
		});
   }    
	
	function searchAttendence(){
		var time = $("#dateboxId").datebox("getValue");
		if(time ==""){
			$.messager.alert("系统提示","请选择日期");
			return false;
		} 		 
				
		var dataParameter = {"time":time}
		var userName = $("#s_userName").val();
		if(userName!= null && $.trim(userName) != ''){
			dataParameter["userTrueName"] = userName
		}
		$.ajax({
			url : "/stu-system-web/sysWorkAttendanceAction/selectAttendenceInformation.do",
			type : "POST",
			data: dataParameter,
			dataType : "json",
			contentType : 'application/x-www-form-urlencoded; charset=UTF-8',			
			success : function(dataResult) {						
				 $("#dg").datagrid({data:dataResult}); 
				
			}
		});		 	
		
	}
	
	
	
	
	
	
	function resetValue(){
		$("#userName").val("");
		$("#password").val("");
		$("#trueName").val("");
		$("#email").val("");
		$("#phone").val("");
		$("#descrId").val("");
		$("#roleName").combobox("setValue","");
	}
	
	function closeUserDialog(){
		$("#dlg").dialog("close");
		resetValue();
	}
	
	function getStudentsInformation(){		
		 if($("#dateboxId").datebox("getValue") ==""){
			$.messager.alert("系统提示","请选择日期");
			return false;
		} 		 
		 $.ajax({
				url : "/stu-system-web/sysUserAction/getUserInformationForAttendence.do",
				type : "POST",
				dataType : "json",
				contentType : 'application/x-www-form-urlencoded; charset=UTF-8',			
				success : function(dataResult) {						
					$("#dg").datagrid({data:dataResult});
					
				}
			});		 		
	}
	
	var saveOrUpdate;
	
	function openUserAttendenceInformation(){
		
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length==0){
			$.messager.alert("系统提示","请选择要登记考勤的学生！");
			return;
		}
		
		$("#dlg").dialog("open").dialog("setTitle","录入学生考勤信息");
		getAttendenceStatus()
		saveOrUpdate = "save";
	}	
	function openUpdateUserAttendenceInformation(){
		
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length==0){
			$.messager.alert("系统提示","请选择要修改考勤的学生！");
			return;
		}
		$("#dlg").dialog("open").dialog("setTitle","修改学生考勤信息");
		getAttendenceStatus()
		saveOrUpdate = "update";
	}	
	
	function save(){
		if(saveOrUpdate=="save"){
			saveAttendenceRecord();
		}
		if(saveOrUpdate=="update"){
			updateUserAttendence();
		}
	}
	function saveAttendenceRecord(){
		var time = $("#dateboxId").datebox("getValue");
		if(time ==""){
			$.messager.alert("系统提示","请选择日期");
			return false;
		} 		 
		
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length==0){
			$.messager.alert("系统提示","请选择要登记考勤的学生！");
			return;
		}
		var strUserCodes=[];
		for(var i=0;i<selectedRows.length;i++){
			strUserCodes.push(selectedRows[i].code);
		}
		var userCodes =strUserCodes.join(",");			
		var checkOne = checkStatus("checkOne");
		var checkTwo = checkStatus("checkTwo");		
		var checkThree = checkStatus("checkThree");
		var checkFour = checkStatus("checkFour");
		var checkFive = checkStatus("checkFive");
		var checkSix = checkStatus("checkSix");
		
		 $.ajax({
				url : "/stu-system-web/sysWorkAttendanceAction/saveAttendenceRecord.do",
				type : "POST",
				data: {"time": time , "oneCheck": checkOne , "twoCheck": checkOne , "threeCheck":checkThree , "fourCheck" :checkFour ,
					    "fiveCheck": checkFive , "sixCheck" : checkSix , "userCodes":userCodes},
				dataType : "json",
				contentType : 'application/x-www-form-urlencoded; charset=UTF-8',//防止乱码
				success : function(data) {					
					if(data.success){
						$.messager.alert("系统提示","考勤录入成功");
					}else{
						$.messager.alert("系统提示","考勤录入失败");
					}									   			  			  
				}
			});				
	}	
	function checkStatus(time){
		var status = $("#" + time).combobox("getValue")
		if(status==""){
			$.messager.alert("系统提示","考勤记录不全");
			return false;
		}else{
			return status;
		}			
	}
function updateUserAttendence(){
	
	var selectedRows=$("#dg").datagrid('getSelections');
	if(selectedRows.length==0){
		$.messager.alert("系统提示","请选择要登记考勤的学生！");
		return;
	}
	var strAttendenceCodes=[];
	for(var i=0;i<selectedRows.length;i++){
		strAttendenceCodes.push(selectedRows[i].code);
	}
	var attendenceCodes =strAttendenceCodes.join(",");			
	var checkOne = checkStatus("checkOne");
	var checkTwo = checkStatus("checkTwo");		
	var checkThree = checkStatus("checkThree");
	var checkFour = checkStatus("checkFour");
	var checkFive = checkStatus("checkFive");
	var checkSix = checkStatus("checkSix");
	
	 $.ajax({
			url : "/stu-system-web/sysWorkAttendanceAction/updateUserAttendence.do",
			type : "POST",
			data: { "oneCheck": checkOne , "twoCheck": checkOne , "threeCheck":checkThree , "fourCheck" :checkFour ,
				    "fiveCheck": checkFive , "sixCheck" : checkSix , "attendenceCodes":attendenceCodes},
			dataType : "json",
			contentType : 'application/x-www-form-urlencoded; charset=UTF-8',//防止乱码
			success : function(data) {					
				if(data.success){
					$.messager.alert("系统提示","考勤修改成功");
				}else{
					$.messager.alert("系统提示","考勤修改失败");
				}									   			  			  
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
		    <th data-options="field:'userTrueName',width:20,align:'center'">姓名</th>
			<th data-options="field:'time',width:20,align:'center'">时间</th>
			<th data-options="field:'oneCheck',width:20,align:'center'">早晨</th> 
	 	    <th data-options="field:'twoCheck',width:20,align:'center'">午饭前</th> 
	 	    <th data-options="field:'threeCheck',width:20,align:'center'">午饭后</th>
	 	    <th data-options="field:'fourCheck',width:20,align:'center'">晚饭前</th>
	 	    <th data-options="field:'fiveCheck',width:20,align:'center'">晚饭后</th>  
	 	    <th data-options="field:'sixCheck',width:20,align:'center'">晚自习</th>  
	 	    
	 	</tr>
	 </thead>
	</table>
	
    
	
	<div id="tb" style="width:100%">
		<div>
		    <input  id="dateboxId"  type= "text" class= "easyui-datebox" required ="required" > </input> 
			<a href="javascript:getStudentsInformation()" class="easyui-linkbutton" iconCls="icon-add" plain="true">显示学生</a>
		</div>
		<div style = "margin: 0 auto">
		    &nbsp;姓名:<input type="text" id="s_userName" size="20" onkeydown=""/> <!-- if(event.keyCode==13) searchUser() -->
		    <a href="javascript:searchAttendence()" class="easyui-linkbutton" iconCls="icon-search" plain="true">查看考勤</a>
		    <a href="javascript:openUserAttendenceInformation()" class="easyui-linkbutton" iconCls="icon-add" plain="true" style="margin-left:50px">录入</a>
		    <a href="javascript:openUserAttendenceInformation()" class="easyui-linkbutton" iconCls="icon-add" plain="true" style="margin-left:50px">批量录入</a>
		    <a href="javascript:openUpdateUserAttendenceInformation()" class="easyui-linkbutton" iconCls="icon-remove" plain="true" style="margin-left:50px">修改</a>
		    <a href="javascript:openUpdateUserAttendenceInformation()" class="easyui-linkbutton" iconCls="icon-remove" plain="true" style="margin-left:50px">批量修改</a>
		</div>
	</div>
	
	<div id="dlg" class="easyui-dialog" style="width: 620px;height:250px;padding: 10px 20px"
	  closed="true" buttons="#dlg-buttons">
	 	<form id="fm" method="post">	 	
	 	   <table cellspacing="8px">
	 			<tr>
	 				<td>早晨：</td>
                    <td> <select class="easyui-combobox" id="checkOne" name="classCode"  class="easyui-validatebox" required="true" style="width: 154px;" editable="false" panelHeight="auto">
	 						
	 					</select>&nbsp;<font color="red">*</font>
	 				  </td>			 
	 				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	 				<td>午饭前：</td>
	 				<td> <select class="easyui-combobox" id="checkTwo" name="classCode"  class="easyui-validatebox" required="true" style="width: 154px;" editable="false" panelHeight="auto">	 						
	 					
	 					</select>&nbsp;<font color="red">*</font>
	 				  </td>			 
	 			</tr>
	 			<tr>
	 				<td>午饭后：</td>
	 				<td> <select class="easyui-combobox" id="checkThree" name="classCode"  class="easyui-validatebox" required="true" style="width: 154px;" editable="false" panelHeight="auto">
	 						
	 						
	 					</select>&nbsp;<font color="red">*</font>
	 				  </td>			 
	 				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	 				<td>晚饭前：</td>
	 				<td> <select class="easyui-combobox" id="checkFour" name="classCode"  class="easyui-validatebox" required="true" style="width: 154px;" editable="false" panelHeight="auto">
	 						
	 						
	 					</select>&nbsp;<font color="red">*</font>
	 				  </td>			  				
	 			</tr>
	 			<tr>
	 			    <td>晚饭后：</td>
	 				<td>
	 					<select class="easyui-combobox" id="checkFive" name="roleCode"  class="easyui-validatebox" required="true" style="width: 154px;" editable="false" panelHeight="auto">
	 						
	 					</select>&nbsp;<font color="red">*</font>
	 				</td>	 			    
	 				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	 				<td>晚自习：</td>
	 				    
	 				   <td> <select class="easyui-combobox" id="checkSix" name="classCode"  class="easyui-validatebox" required="true" style="width: 154px;" editable="false" panelHeight="auto">
	 						
	 						
	 					</select>&nbsp;<font color="red">*</font>
	 				  </td>			 				
	 			</tr>	 			
	 		</table> 
	 	</form>
	</div>
	
	<div id="dlg-buttons">
		<a href="javascript:save()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
		<a href="javascript:closeUserDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
	
</body>
</html>