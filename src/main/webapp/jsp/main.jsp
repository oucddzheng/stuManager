<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored = "false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>考勤问卷信息管理系统</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.5.3/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jquery-easyui-1.5.3/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jquery-easyui-1.5.3/demo/demo.css">
	<link rel="stylesheet" type= "text/css" href="/stu-system-web/css/main.css" >	
	<script type="text/javascript" src="<%=request.getContextPath()%>/jquery-easyui-1.5.3/jquery.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/jquery-easyui-1.5.3/jquery.easyui.min.js"></script>		
	<script type="text/javascript" >
	
		var url;	
		function openTab(text,url,iconCls){
			  if($("#center-tabsid").tabs("exists",text)){
				$("#center-tabsid").tabs("select",text);
			 }else{
				var content="<iframe frameborder=0 scrolling='auto' style='width:100%;height:100%' src='${pageContext.request.contextPath}/jsp/"+url+"'></iframe>";
				$("#center-tabsid").tabs("add",{
					title:text,
					iconCls:iconCls,
					closable:true,
					content:content
				});
			}  
		}
		$(document).ready(function(){
			var roleCode = '${currentUser.roleCode}';			
			$.ajax({
				url : "/stu-system-web/sysRolePermissionRelationAction/getPermissionInMain.do",
				type : "POST",
				data:{roleCode: roleCode} ,
				dataType : "json",
				contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
				success : function(dataResult) {	
					addAccordion(dataResult);
					}				
				});
			
			 
			
			
		})
		function addAccordion(dataResult){
			var length = dataResult.length;
			for( var i=0 ; i < length; i++ ){
				 var str = '';
				 var aStr = '';
				 var aLength =  (dataResult[i].secondPermission).length;
				 for(var j = 0 ; j < aLength ; j++){
					 var aObject = (dataResult[i].secondPermission)[j]
					 aStr += '<a class="easyui-linkbutton" href="javascript:openTab(\''+aObject.secondPermissionName+'\',\''+aObject.url+'\',\'icon-user\')"  data-options="plain:true,iconCls:\'icon-user\'" style="width: 130px;">'+aObject.secondPermissionName+'</a>'
				 }
				 str += '<div title="" data-options="iconCls:\'icon-students\'" style="padding:10px;">'
			            + aStr
				        +'</div>'				
				  $('#accordionId').accordion('add', {
						title: dataResult[i].firstPermissionName, 
						content: str,
						selected: false
					}); 
			}			
		}
		
		
	</script>
</head>
<body id = "bodyId" style = "margin:0px;padding:0px">
	<div class="easyui-layout" style="width:100%;height:605px">
		
		<div region="north" style="height: 78px;background-color: #E0ECFF">
			<table style="padding: 5px" width="100%">
				<tr>
					<td width="50%">
						<img src="<%=request.getContextPath()%>/images/logo.png"/>
					</td>
					<td valign="bottom" align="right" width="50%">
						<font size="3">&nbsp;&nbsp;<strong>欢迎：</strong>${currentUser.userAccount }</font>【${currentUser.userTrueName}】【${currentUser.sysRoleModel.roleName }】
					</td>
				</tr>
			</table>
		</div>
		
		
		
		
		<div id="p" data-options="region:'west'" title="导航菜单" style="width:170px; padding:">
			<div id = "accordionId" class="easyui-accordion" fit="true" style="width:100%;height:300px;border:0px">
				
				<!-- <div title="系统" data-options="iconCls:'icon-students'" style="padding:10px;">
				   
				    <a class="easyui-linkbutton" href="javascript:openTab('用户信息管理','permissionManager.jsp','icon-user')"  data-options="plain:true,iconCls:'icon-user'" style="width: 130px;">权限管理</a>
					<a class="easyui-linkbutton" href="javascript:openTab('处理学生请假','leaveExaminationByEducational.jsp','icon-ok')" data-options="plain:true,iconCls:'icon-user'" style="width: 130px;">查看学生请假</a>
				    <a class="easyui-linkbutton" href="javascript:openTab('查看学生考勤','workAttendenceForEdu.jsp','icon-user')"  data-options="plain:true,iconCls:'icon-user'" style="width: 130px;">查看学生考勤</a>
			        <a class="easyui-linkbutton" href="javascript:openTab('题库管理','questionLibrary.jsp','icon-user')"  data-options="plain:true,iconCls:'icon-user'" style="width: 130px;">题库管理</a>	
				    <a class="easyui-linkbutton" href="javascript:openTab('问卷管理','createQuestion.jsp','icon-user')"  data-options="plain:true,iconCls:'icon-user'" style="width: 130px;">问卷管理</a>	
				    <a class="easyui-linkbutton" href="javascript:openTab('数据字典管理','dataDicManage.jsp','icon-sjzdgl')"  data-options="plain:true,iconCls:'icon-sjzdgl'" style="width: 130px">数据字典管理</a>	
				    <a class="easyui-linkbutton" href="javascript:openTab('用户信息管理','userManage.jsp','icon-user')"  data-options="plain:true,iconCls:'icon-user'" style="width: 130px;">用户信息管理</a>
				</div>	
				
				<div title="考勤" data-options="iconCls:'icon-students'" style="padding:10px;">
				      <a class="easyui-linkbutton" href="javascript:openTab('用户信息管理','userManage.jsp','icon-user')"  data-options="plain:true,iconCls:'icon-user'" style="width: 130px;">权限管理</a>
				     <a class="easyui-linkbutton" href="javascript:openTab('处理学生请假','leaveExaminationByEducational.jsp','icon-ok')" data-options="plain:true,iconCls:'icon-user'" style="width: 130px;">查看学生请假</a>
				     <a class="easyui-linkbutton" href="javascript:openTab('查看学生考勤','workAttendenceForEdu.jsp','icon-user')"  data-options="plain:true,iconCls:'icon-user'" style="width: 130px;">查看学生考勤</a>
				      <a class="easyui-linkbutton" href="javascript:openTab('题库管理','questionLibrary.jsp','icon-user')"  data-options="plain:true,iconCls:'icon-user'" style="width: 130px;">题库管理</a>	
				     <a class="easyui-linkbutton" href="javascript:openTab('问卷管理','createQuestion.jsp','icon-user')"  data-options="plain:true,iconCls:'icon-user'" style="width: 130px;">问卷管理</a>	
				     <a class="easyui-linkbutton" href="javascript:openTab('数据字典管理','dataDicManage.jsp','icon-sjzdgl')"  data-options="plain:true,iconCls:'icon-sjzdgl'" style="width: 130px">数据字典管理</a>	
				     <a class="easyui-linkbutton" href="javascript:openTab('用户信息管理','userManage.jsp','icon-user')"  data-options="plain:true,iconCls:'icon-user'" style="width: 130px;">用户信息管理</a>
				</div>	

               <div title="作业" data-options="iconCls:'icon-students'" style="padding:10px;">
				     <a class="easyui-linkbutton" href="javascript:openTab('用户信息管理','userManage.jsp','icon-user')"  data-options="plain:true,iconCls:'icon-user'" style="width: 130px;">权限管理</a>
					 <a class="easyui-linkbutton" href="javascript:openTab('处理学生请假','leaveExaminationByEducational.jsp','icon-ok')" data-options="plain:true,iconCls:'icon-user'" style="width: 130px;">查看学生请假</a>
				     <a class="easyui-linkbutton" href="javascript:openTab('查看学生考勤','workAttendenceForEdu.jsp','icon-user')"  data-options="plain:true,iconCls:'icon-user'" style="width: 130px;">查看学生考勤</a>
				     <a class="easyui-linkbutton" href="javascript:openTab('题库管理','questionLibrary.jsp','icon-user')"  data-options="plain:true,iconCls:'icon-user'" style="width: 130px;">题库管理</a>	
				     <a class="easyui-linkbutton" href="javascript:openTab('问卷管理','createQuestion.jsp','icon-user')"  data-options="plain:true,iconCls:'icon-user'" style="width: 130px;">问卷管理</a>	
				     <a class="easyui-linkbutton" href="javascript:openTab('数据字典管理','dataDicManage.jsp','icon-sjzdgl')"  data-options="plain:true,iconCls:'icon-sjzdgl'" style="width: 130px">数据字典管理</a>	
				     <a class="easyui-linkbutton" href="javascript:openTab('用户信息管理','userManage.jsp','icon-user')"  data-options="plain:true,iconCls:'icon-user'" style="width: 130px;">用户信息管理</a>
				</div>	
				
				<div title="问卷" data-options="iconCls:'icon-students'" style="padding:10px;">
				     <a class="easyui-linkbutton" href="javascript:openTab('用户信息管理','userManage.jsp','icon-user')"  data-options="plain:true,iconCls:'icon-user'" style="width: 130px;">权限管理</a>
					 <a class="easyui-linkbutton" href="javascript:openTab('处理学生请假','leaveExaminationByEducational.jsp','icon-ok')" data-options="plain:true,iconCls:'icon-user'" style="width: 130px;">查看学生请假</a>
				     <a class="easyui-linkbutton" href="javascript:openTab('查看学生考勤','workAttendenceForEdu.jsp','icon-user')"  data-options="plain:true,iconCls:'icon-user'" style="width: 130px;">查看学生考勤</a>
				     <a class="easyui-linkbutton" href="javascript:openTab('题库管理','questionLibrary.jsp','icon-user')"  data-options="plain:true,iconCls:'icon-user'" style="width: 130px;">题库管理</a>	
				     <a class="easyui-linkbutton" href="javascript:openTab('问卷管理','createQuestion.jsp','icon-user')"  data-options="plain:true,iconCls:'icon-user'" style="width: 130px;">问卷管理</a>	
				     <a class="easyui-linkbutton" href="javascript:openTab('数据字典管理','dataDicManage.jsp','icon-sjzdgl')"  data-options="plain:true,iconCls:'icon-sjzdgl'" style="width: 130px">数据字典管理</a>	
				     <a class="easyui-linkbutton" href="javascript:openTab('用户信息管理','userManage.jsp','icon-user')"  data-options="plain:true,iconCls:'icon-user'" style="width: 130px;">用户信息管理</a>
				</div>	
				 -->
				
				
				
				
			 <!-- <div title="教务" data-options="iconCls:'icon-students'" style="padding:10px;">
				     <a class="easyui-linkbutton" href="javascript:openTab('权限管理','permissionManager.jsp','icon-user')"  data-options="plain:true,iconCls:'icon-user'" style="width: 130px;">权限管理</a>
					 <a class="easyui-linkbutton" href="javascript:openTab('用户信息管理','userManage.jsp','icon-user')"  data-options="plain:true,iconCls:'icon-user'" style="width: 130px;">用户信息管理</a>					
					 <a class="easyui-linkbutton" href="javascript:openTab('处理学生请假','leaveExaminationByEducational.jsp','icon-ok')" data-options="plain:true,iconCls:'icon-user'" style="width: 130px;">查看学生请假</a>
				     <a class="easyui-linkbutton" href="javascript:openTab('查看学生考勤','workAttendenceForEdu.jsp','icon-user')"  data-options="plain:true,iconCls:'icon-user'" style="width: 130px;">查看学生考勤</a>
				     <a class="easyui-linkbutton" href="javascript:openTab('题库管理','questionLibrary.jsp','icon-user')"  data-options="plain:true,iconCls:'icon-user'" style="width: 130px;">题库管理</a>	
				     <a class="easyui-linkbutton" href="javascript:openTab('问卷管理','createQuestion.jsp','icon-user')"  data-options="plain:true,iconCls:'icon-user'" style="width: 130px;">问卷管理</a>	
				     <a class="easyui-linkbutton" href="javascript:openTab('数据字典管理','dataDicManage.jsp','icon-sjzdgl')"  data-options="plain:true,iconCls:'icon-sjzdgl'" style="width: 130px">数据字典管理</a>	
				</div>			    
				
			
			    <div id = "studentsInformationId" title="学生信息" data-options="iconCls:'icon-students' " style="overflow:auto;padding:10px; ">			
				   <a class="easyui-linkbutton" href="javascript:openTab('请假申请','leave.jsp','icon-ok')"  data-options="plain:true,iconCls:'icon-user'" style="width: 130px;">请假申请</a>				
				   <a class="easyui-linkbutton" href="javascript:openTab('查看个人考勤','workAttendenceForStu.jsp','icon-user')"  data-options="plain:true,iconCls:'icon-user'" style="width: 130px;">查看个人考勤</a>
				   <a class="easyui-linkbutton" href="javascript:openTab('家庭作业','assignmentForStu.jsp','icon-user')"  data-options="plain:true,iconCls:'icon-user'" style="width: 130px;">家庭作业</a>
				   <a class="easyui-linkbutton" href="javascript:openTab('回答问卷','questionnaireForStu.jsp','icon-user')"  data-options="plain:true,iconCls:'icon-user'" style="width: 130px;">回答问卷</a>				
				</div>				
		
				
				
				
				
				<div title="班主任" data-options="iconCls:'icon-help'" style="padding:10px;">	
			       <a class="easyui-linkbutton" href="javascript:openTab('处理学生请假','leaveExaminationByTeacher.jsp','icon-ok')" data-options="plain:true,iconCls:'icon-user'" style="width: 130px;" >查看学生请假</a>
			       <a class="easyui-linkbutton" href="javascript:openTab('学生考勤管理','workAttendance.jsp','icon-user')"  data-options="plain:true,iconCls:'icon-user'" style="width: 130px;">学生考勤管理</a>
			       <a class="easyui-linkbutton" href="javascript:openTab('家庭作业','assignment.jsp','icon-user')"  data-options="plain:true,iconCls:'icon-user'" style="width: 130px;">家庭作业</a>
				</div>   -->
				
			 </div> 
		</div>
		<div id  data-options="region:'center'" >
		  <div id="center-tabsid" class="easyui-tabs" fit="true" style="border: 0px">
				<div title="首页" style="padding: 20px; display: none;"></div>
	      </div>
		</div>
	</div>
</body>
</html>