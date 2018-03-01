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
    	 getRoles();/* 该函数在加载页面的时候从库中获得角色分类别 */
    	 getClasses();/* 在页面加载的时候从库中获得班级的名称 */
    })
    function getRoles(){
	   $.ajax({
			url : "/stu-system-web/sysRoleAction/getRoles.do",
			type : "POST",
			dataType : "json",
			contentType : 'application/x-www-form-urlencoded; charset=UTF-8',//防止乱码
			success : function(data) {	
				var roleJson =  [{
					roleName: '请选择角色...',
					code: ''
				}];
				for(var i = 0;i<data.length;i++){
					var role = data[i];
					roleJson.push({code:role.code,roleName:role.roleName})
				}
			   $('#roleName').combobox({    
				    data:roleJson,   
				    valueField:'code',    
				    textField:'roleName'   
				});  		
			}
		});
   }
    
    function getClasses(){
    	$.ajax({
			url : "/stu-system-web/sysClassAction/getClassName.do",
			type : "POST",
			dataType : "json",
			contentType : 'application/x-www-form-urlencoded; charset=UTF-8',//防止乱码
			success : function(data) {	
				var classJson =  [{
					className: '请选择班级...',
					code: ''
				}];
				for(var i = 0;i<data.length;i++){
					var classModel = data[i];
					classJson.push({code:classModel.code,className:classModel.className})
				}
			   $('#classId').combobox({    
				    data:classJson,   
				    valueField:'code',    
				    textField:'className'   
				});  		
			}
		});
    }
    
    
	var url;  //url用来保存请求的地址
	
	function searchUser(){
		$("#dg").datagrid('load',{
			"userAccount":$("#s_userName").val()
		});
	}
	
	function deleteUser(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length==0){
			$.messager.alert("系统提示","请选择要删除的数据！");
			return;
		}
		var strIds=[];
		for(var i=0;i<selectedRows.length;i++){
			strIds.push(selectedRows[i].id);
		}
		var ids=strIds.join(",");
		$.messager.confirm("系统提示","您确认要删除这<font color=red>"+selectedRows.length+"</font>条数据吗？",function(r){
			if(r){
				$.post("${pageContext.request.contextPath}/sysUserAction/deleteByUpdate.do",{ids:ids},function(result){
					if(result.success){
						$.messager.alert("系统提示","数据已成功删除！");
						$("#dg").datagrid("reload");
					}else{
						$.messager.alert("系统提示","数据删除失败！");
					}
				},"json");
			}
		});
		
	}
	
	
	function openUserAddDialog(){
		$("#dlg").dialog("open").dialog("setTitle","添加用户信息");
	    url="${pageContext.request.contextPath}/sysUserAction/save.do";
	}
	/* 用来用户批量上传的 */
	function check (){
		  var excel_file = $("#excel_file").val();  
	      if (excel_file == "" || excel_file.length == 0) {  
	          alert("请选择文件路径！");  
	          return false;  
	      } else {  
	         return true;  
	      }  
	}
	/* 打开批量上传对话框 */
	function openBatchImportUserInfDialog(){
		$("#dlgBatchImportUserInfId").dialog("open").dialog("setTitle","批量导入用户信息");
	}
	function closeBatchImportUserInfDialog(){
		$("#dlgBatchImportUserInfId").dialog("close");
	}
	function saveUserBatchImport(){
		$("#formBatchImportUserInfId").form("submit",{
			url:"${pageContext.request.contextPath}/sysUserAction/batchImportUserInf.do",
			onSubmit:function(){				
				return $(this).form("validate");
			},
			success:function(result){
				var result=eval('('+result+')');
				if(result.success){
					$.messager.alert("系统提示","批量导入成功");	
					$("#dlgBatchImportUserInfId").dialog("close");
				    $("#dg").datagrid("reload"); 
				}else{
					$.messager.alert("系统提示","保存失败");
					return;
				}
			}
		});
	}
	function saveUser(){
	
		$("#fm").form("submit",{
			url:url,
			onSubmit:function(){
				if($("#roleName").combobox("getValue")==""){
					$.messager.alert("系统提示","请选择用户角色");
					return false;
				}
				return $(this).form("validate");
			},
			success:function(result){
				var result=eval('('+result+')');
				if(result.success){
					$.messager.alert("系统提示","保存成功");
					resetValue();
					$("#dlg").dialog("close");
				    $("#dg").datagrid("reload"); 
				}else{
					$.messager.alert("系统提示","保存失败");
					return;
				}
			}
		});
	}
	
	function BatchexportUserInformation(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length==0){
			$.messager.alert("系统提示","请选择要导出的用户！");
			return;
		}
		var strIds=[];
		for(var i=0;i<selectedRows.length;i++){
			strIds.push(selectedRows[i].id);
		}
		var ids=strIds.join(",");
		/* $.messager.confirm("系统提示","您确认要导出这<font color=red>"+selectedRows.length+"</font>条数据吗？",function(r){
			if(r){
				$.post("${pageContext.request.contextPath}/sysUserAction/export.do",{ids:ids},function(result){
					
				},"json");
			}
		}); */
		
			
		
		
		
		window.location.href = "/stu-system-web/sysUserAction/export.do?ids="+ids;	
		
		
	}
		
	
	function openUserModifyDialog(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要编辑的数据！");
			return;
		}
		var row=selectedRows[0];
		$("#dlg").dialog("open").dialog("setTitle","编辑用户信息");
		$('#fm').form('load',row);
		url="${pageContext.request.contextPath}/sysUserAction/update.do?id="+row.id;
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
</script>
</head>
<body style="margin:1px;">
	<table id="dg" title="用户管理" class="easyui-datagrid"
	 fitColumns="true"  pagination="true"  rownumbers="true"
	 url="${pageContext.request.contextPath}/sysUserAction/getUserInformation.do" fit="true" toolbar="#tb">
	 <thead>
	 	<tr>
	 		<th field="cb" checkbox="true" align="center"></th>
	 		<th field="id" width="50" align="center">编号</th>
	 		<th field="userAccount" width="100" align="center">用户名</th>
	 		<th field="userPassword" width="100" align="center">密码</th>
	 		<th field="userTrueName" width="100" align="center">真实姓名</th>	 		
	 		<th field="userTelephone" width="100" align="center">联系电话</th>
	 		<th field="className" width="80" align="center">班级</th>
	 		<th field="roleName" width="80" align="center">角色</th>
	 		<th field="descr" width="80" align="center">备注</th>
	 	</tr>
	 </thead>
	</table>
	<div id="tb">
		<div>
			<a href="javascript:openUserAddDialog()" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a>
			
			<a href="javascript:openUserModifyDialog()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
			<a href="javascript:deleteUser()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
			<a href="javascript:openBatchImportUserInfDialog()" class="easyui-linkbutton" iconCls="icon-add" plain="true">批量导入</a>
			<a href="javascript:BatchexportUserInformation()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">批量导出用户信息</a> 
		</div>
		<div>
			&nbsp;用户名：&nbsp;<input type="text" id="s_userName" size="20" onkeydown="if(event.keyCode==13) searchUser()"/>
			<a href="javascript:searchUser()" class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索</a>
		</div>
	</div>
	
	<div id="dlg" class="easyui-dialog" style="width: 620px;height:250px;padding: 10px 20px"
	  closed="true" buttons="#dlg-buttons">
	 	<form id="fm" method="post">	 	
	 	   <table cellspacing="8px">
	 			<tr>
	 				<td>用户名：</td>
	 				<td><input type="text" id="userName" name="userAccount" class="easyui-validatebox" required="true"/>&nbsp;<font color="red">*</font></td>
	 				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	 				<td>密码：</td>
	 				<td><input type="text" id="password" name="userPassword" class="easyui-validatebox" required="true"/>&nbsp;<font color="red">*</font></td>
	 			</tr>
	 			<tr>
	 				<td>真实姓名：</td>
	 				<td><input type="text" id="trueName" name="userTrueName" class="easyui-validatebox" required="true"/>&nbsp;<font color="red">*</font></td>
	 				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	 				<td>联系电话：</td>
	 				<td><input type="text" id="phone" name="userTelephone" class="easyui-validatebox"  required="true"/>&nbsp;<font color="red">*</font></td>
	 			</tr>
	 			<tr>
	 			    <td>用户角色：</td>
	 				<td>
	 					<select class="easyui-combobox" id="roleName" name="roleCode"  class="easyui-validatebox" required="true" style="width: 154px;" editable="false" panelHeight="auto">
	 						
	 					</select>&nbsp;<font color="red">*</font>
	 				</td>	 			    
	 				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	 				<td>班級：</td>
	 				    
	 				   <td> <select class="easyui-combobox" id="classId" name="classCode"  class="easyui-validatebox" required="true" style="width: 154px;" editable="false" panelHeight="auto">
	 						<option value="">请选择班级...</option>
	 						
	 					</select>&nbsp;<font color="red">*</font>
	 				  </td>			 				
	 			</tr>
	 			<tr>
	 			   <td>备&nbsp注：</td>
	 			   <td><input type="text" id="descrId" name="descr" required="false" class="easyui-textbox" />&nbsp;</td> 
	 			</tr>
	 			
	 		</table> 
	 	</form>
	</div>
	
	<div id="dlg-buttons">
		<a href="javascript:saveUser()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
		<a href="javascript:closeUserDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
	
	<div id="dlgBatchImportUserInfId" class="easyui-dialog" style="width: 620px;height:250px;padding: 10px 20px"
	  closed="true" buttons="#dlgBatchImportUserInf-buttons">
	  
	  <form id = "formBatchImportUserInfId" method="post" enctype="multipart/form-data" onsubmit="return check();">
	      <span>请选择excel文件：</span>
	      <input id="excel_file" type="file" name="filename" accept="xlsx" size="30"/>	      
      </form>
	  
	 	
	</div>
	<div id="dlgBatchImportUserInf-buttons">
		<a href="javascript:saveUserBatchImport()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
		<a href="javascript:closeBatchImportUserInfDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
	
	
</body>
</html>