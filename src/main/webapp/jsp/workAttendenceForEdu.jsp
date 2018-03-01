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
	function searchAttendence(){
		var time = $("#dateboxId").datebox("getValue");
		if(time ==""){
			$.messager.alert("系统提示","请选择日期");
			return false;
		} 		 
				
		var dataParameter = {"time":time}
		$.ajax({
			url : "/stu-system-web/sysWorkAttendanceAction/selectAttendenceINFForEDU.do",
			type : "POST",
			data: dataParameter,
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
		    <a href="javascript:searchAttendence()" class="easyui-linkbutton" iconCls="icon-search" plain="true">查看考勤</a>
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
</body>
</html>