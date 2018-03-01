<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored= "false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.5.3/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.5.3/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.5.3/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.5.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.5.3/locale/easyui-lang-zh_CN.js"></script>
<style>
   *{
      padding:0px;
      margin:0px;
   }
</style>
 <script>
 
 $(document).ready(function(){
	 
	 getLeaveInformation();
	 
 })
    function getLeaveInformation(){
	 $.ajax({
			url : "/stu-system-web/sysLeaveAction/getLeaveInformation.do",
			type : "POST",
			dataType : "json",
			contentType : 'application/x-www-form-urlencoded; charset=UTF-8',//防止乱码
			success : function(data) {
				 showReminder(data);
			     showDataInDatagrid(data); 			    
			}
		});
 }
     function showDataInDatagrid(dataResult){   	 
    	 $("#dg").datagrid({data:dataResult});
     }
     function showReminder(dataResult){
    	 var status = dataResult[0].status
    	 if(status==3){
    		 $("#myLeavelApplicationId").text("我的申请");
    		 $("#myLeavelApplicationId").css({background:"green"})
    		 $("#teacherExaminationId").css({background:"yellow"});   
    		 return false;
    	 }
    	 if(status==4){
    		 $("#myLeavelApplicationId").text("我的申请");
    		 $("#myLeavelApplicationId").css({background:"green"});
    		 $("#teacherExaminationId").text("班主任驳回了你的请假申请");
    		 $("#teacherExaminationId").css({background:"red"}); 
    		 return false;
    	 }
    	 
    	 
    	 if(status==6){
    		 $("#myLeavelApplicationId").text("我的申请");
    		 $("#myLeavelApplicationId").css({background:"green"});
    		 $("#teacherExaminationId").text("班主任同意了你的请假申请");
    		 $("#teacherExaminationId").css({background:"green"});  
    		 $("#educationalExaminationId").css({background:"yellow"})
    		 return false;
    	 }
    	 if(status==7){
    		 $("#myLeavelApplicationId").text("我的申请");
    		 $("#myLeavelApplicationId").css({background:"green"});
    		 $("#teacherExaminationId").text("班主任同意了你的请假申请");
    		 $("#teacherExaminationId").css({background:"green"}); 
    		 $("#educationalExaminationId").text("教务驳回了你的请假申请");
    		 $("#educationalExaminationId").css({background:"red"})
    		 return false;
    	 }
    	 if(status==8){
    		 $("#myLeavelApplicationId").text("我的申请");
    		 $("#myLeavelApplicationId").css({background:"green"});
    		 $("#teacherExaminationId").text("班主任同意了你的请假申请");
    		 $("#teacherExaminationId").css({background:"green"}); 
    		 $("#educationalExaminationId").text("教务同意了你的请假申请");
    		 $("#educationalExaminationId").css({background:"green"});
    		 $("#leavelApplicationSuccessId").css({background:"green"});
    		 return false;
    	 }
    	 
     }
    var url;
    function addNewLeave(){
    	$("#dlg").dialog("open").dialog("setTitle","学生请假申请");
	    url="${pageContext.request.contextPath}/sysLeaveAction/addLeave.do";    	
    }
    
   
 
    function saveLeave(){
    	
		$("#fm").form("submit",{
			url:url,
			onSubmit:function(){
				if($("#beginTimeId").datetimebox("getValue") ==""){
					$.messager.alert("系统提示","请选择请假的开始时间");
					return false;
				}
				if($("#stopTimeId").datetimebox("getValue")==""){
					$.messager.alert("系统提示","请选择请假的结束时间");
					return false;
				}
				if($("#reasonId").textbox("getValue")==""){
					$.messager.alert("系统提示","请填写请假原因");
					return false;
				}
				return $(this).form("validate");
			},
			success:function(result){
				var result=eval('('+result+')');
				if(result.success){
					$.messager.alert("系统提示","保存成功");
					/* resetValue(); */
					$("#dlg").dialog("close");
				   /*  $("#dg").datagrid("reload");  */
				}else{
					$.messager.alert("系统提示","保存失败");
					return;
				}
			}
		});
		
	}
    
 function logoff(){
	
	 var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length==0){
			$.messager.alert("系统提示","请选择要注销的请假记录！");
			return;
		}
		var strId = selectedRows[0].id;
		
		
		 $.messager.confirm("系统提示","您确认要注销这条请假记录吗",function(r){
			if(r){
				$.post("${pageContext.request.contextPath}/sysLeaveAction/logOffLeavel.do",{id:strId},function(result){
					if(result.success){
						$.messager.alert("系统提示","请假已经成功注销！");
						window.location.href="leave.jsp";
						
					}else{
						$.messager.alert("系统提示","请假注销失败！");
					}
				},"json");
			}
		}); 
	 	 
	 
    }
    
    
    
    function closeLeaveDialog(){    	
		$("#dlg").dialog("close");
	}
     
    function selectLeaveRecord(){
    	
    	window.location.href = "leaveRecordForStu.jsp";
    }
    
    
    
 </script>


</head>
<body style=  "margin:5px">

   <div id = "leaveHeaderId" class = "" styel = "  height:20px ;" >
     <span style = " display:block; margin-top:20px ; text-align:center ; font-size:20px; background: ;color:red ">学生请假申请</span>    
   </div>
   <div id = leaveNavId class = ""  style = "">
       <span id = "myLeavelApplicationId" style="display:inline-block; background:">我的申请</span>
       <span>—></span>
       <span id = "teacherExaminationId" style="display:inline-block;background:">等待班主任审批</span>
       <span>—></span>
       <span id = "educationalExaminationId" style="display:inline-block;background:">等待教务审批</span>
       <span>—></span>
       <span id = "leavelApplicationSuccessId" style="display:inline-block;background:">申请已经通过</span>
       
       <a href="javascript:selectLeaveRecord()" class="easyui-linkbutton" style="font-size:20px ; float:right" iconCls="icon-add" plain="true">查看请假记录</a>
       
       <a href="javascript:logoff()" class="easyui-linkbutton" style="font-size:20px ; float:right" iconCls="icon-add" plain="true">销假</a>
       <a href="javascript:addNewLeave()" class="easyui-linkbutton" style="font-size:20px ; float:right" iconCls="icon-add" plain="true">新的申请</a>
       
   </div>
   <br>
   <br>
   <table id="dg" 
     class="easyui-datagrid"
	 fitColumns="true"  pagination="false"  rownumbers="true"
	  fit="false" toolbar="#tb" >	 	 
	 <thead>
	 	<tr>
	 		<th field="cb" checkbox="true" align="center"></th>
	 		
	 		<th field="id" width="50" align="center" hidden = "true">id</th>
	 		<th field="code" width="50" align="center" hidden = "true">code</th>
	 		<th field="userTrueName" width="50" align="center" >学生</th>
	 		<th field="why" width="100" align="center">事由</th>
	 		<th field="createTime" width="100" align="center">申请时间</th>
	 		<th field="beginTime" width="100" align="center">开始时间</th>	 		
	 		<th field="endTime" width="100" align="center">截至时间</th>
	 		<th field="descr" width="80" align="center">备注</th>
	 	</tr>
	 </thead>
	</table>
     
   <div id="dlg" class="easyui-dialog" style="width: 620px;height:300px;padding: 10px 20px"
	  closed="true" buttons="#dlg-buttons">
	 	<form id="fm" method="post">
	 	    <span>开始日期：&nbsp</span>
	 	    <input id = "beginTimeId" class="easyui-datetimebox" name = "beginTime" required = "true" value="" style="width:200px">
	 	    <br> <br>	 	   
	 	    <span>结束日期：&nbsp</span>
	 	    <input id =  "stopTimeId" class="easyui-datetimebox" name = "endTime" required="true" value="" style="width:200px">
	 	    <br> <br>	 	   
	 	    <span>请假理由：&nbsp</span>
	 	    <input id = "reasonId"  class="easyui-textbox" name = "why" required="true" data-options="multiline:true" value="" style="width:200px;height:50px">
	 		<br><br>
	 		<span>&nbsp备&nbsp&nbsp注：&nbsp&nbsp</span>
	 		<input id = "descr" type="text" id="descrId" name="descr" class="easyui-textbox" style="width:200px" />
	 	</form>
	 	</div>
    <div id="dlg-buttons">
		<a href="javascript:saveLeave()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
		<a href="javascript:closeUserDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
    
</body>
</html>