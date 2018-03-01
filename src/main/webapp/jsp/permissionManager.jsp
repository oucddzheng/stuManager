<%@ page language="java" contentType="text/html;  charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored = "false"%>
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
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/easyui-tool-functions.js"></script>
    <script type="text/javascript">
    
    $(document).ready(function(){
   	 getRoles();/* 该函数在加载页面的时候从库中获得角色分类别 */
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
    
    function onChange(newValue,oldValue){
    	if(newValue==''){
    		return false;
    	}
    	getPermission('dgFirstPermissionId',1 , newValue);
    	getPermission('dgSecondPermissionId', 2 , newValue);
    	   	
    }
    function getPermission(id , type , newValue){
        	   	
    	$.ajax({
			url : "/stu-system-web/sysPermissionAction/selectPermission.do",
			type : "POST",
			data:{'type' : type , 'roleCode': newValue },/*  roleCode: newValue  'sysRolePermissionRelationModel':{ 'roleCode': newValue}*/
			dataType : "json",
			contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
			success : function(data) {	
				$("#"+id).datagrid({data:data})
			}
		});    	
    	
    }
    function addatag(value,row,index){
      var roleCode = $("#roleName").combobox("getValue")
      var permissionCode = row.code; 	
      var idInRolePermissionRelation = row.idInRolePermissionRelation
  	  var operationStatus = row.operation;
  	  if(operationStatus==''){ 		 	  
  		  return '<a href=\"javascript:save(\''+permissionCode+'\',\''+roleCode+'\')\"\>添加</a>'
  	  }
  	  if(operationStatus!=''){
  		  return '<a href=\"javascript:deleteByUpdate(\''+permissionCode+'\',\''+roleCode+'\''+',\''+idInRolePermissionRelation+'\')\"\>删除</a>'
  	  }
  	  
    }
      function save(permissionCode , roleCode){
    	  
    	  $.ajax({
  			url : "/stu-system-web/sysRolePermissionRelationAction/saveRolePermissionRel.do",
  			type : "POST",
  			data:{'roleCode' : roleCode , 'menuCode': permissionCode },/*  roleCode: newValue  'sysRolePermissionRelationModel':{ 'roleCode': newValue}*/
  			dataType : "json",
  			contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
  			success : function(data) {	
  				if(data.success){
					$.messager.alert("系统提示","权限添加成功！");
					getPermission('dgFirstPermissionId',1 , roleCode);
			    	getPermission('dgSecondPermissionId', 2 , roleCode);
					
				}else{
					$.messager.alert("系统提示","权限添加失败！")
				}
  			}
  		});    	
      }  
      function deleteByUpdate(permissionCode , roleCode , idInRolePermissionRelation){
    	  $.ajax({
    			url : "/stu-system-web/sysRolePermissionRelationAction/deleteRolePermissionRelByUpdate.do",
    			type : "POST",
    			data:{'roleCode' : roleCode , 'menuCode': permissionCode , 'id' : idInRolePermissionRelation},
    			dataType : "json",
    			contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
    			success : function(data) {	
    				if(data.success){
  					$.messager.alert("系统提示","权限删除成功！");
  					getPermission('dgFirstPermissionId',1 , roleCode);
  			    	getPermission('dgSecondPermissionId', 2 , roleCode);
  					
  				}else{
  					$.messager.alert("系统提示","权限删除失败！")
  				     }
    			}
    		});    	
      }        
    </script>
   
    



</head>
<body>

   <div id = "firstPermissionId" style = "width : 400px">
       <table id="dgFirstPermissionId"  class="easyui-datagrid" data-options="	                                       
											border:false,
											fit:false,
											striped:true,
											checkOnSelect:false,
											fitColumns:true,
											toolbar:'#tbfirstId',"																					
											>	
	 <thead>
      <tr>	 	
	 	    <th field="cb" checkbox="true" align="center"></th>
	 		<th field="id" width="50" align="center">编号</th>
	 		
	 		<th data-options="field:'code',width:20,align:'center',hidden: 'true'"></th>
	 		
	 		<th field="menuName" width="100" align="center">菜单</th>	 
	 		<th data-options ="field:'operation',width:100,align:'center', formatter: addatag" >操作</th>		
	 </tr>
	 </thead>
	</table>	
       <div id="tbfirstId" style="width:100%">
		<select class="easyui-combobox" id="roleName" data-options="onChange:onChange" name="roleCode"  class="easyui-validatebox"  required="true" style="width: 154px;" editable="false" panelHeight="auto">
	 						
	 	</select>&nbsp;<font color="red">*</font>	
		<p>选择一级菜单</p>
	   </div>   
   </div>
     	
     <br>
     
     	
   <div id = "secondPermissionId" style = "width : 400px" > 
       <table id="dgSecondPermissionId"  class="easyui-datagrid" data-options="	                                       
											border:false,
											fit:false,
											striped:true,
											checkOnSelect:false,
											fitColumns:true,
											toolbar:'#tbsecondId',"																					
											>	
	 <thead>
      <tr>	 	
	 	    <th field="cb" checkbox="true" align="center"></th>
	 		<th field="id" width="50" align="center">编号</th>
	 		<th data-options="field:'code',width:20,align:'center',hidden: 'true'"></th>
	 		<th field="menuName" width="100" align="center">菜单名</th>
	 		<th data-options ="field:'operation',width:100,align:'center', formatter: addatag" >操作</th>		
	 		<th data-options="field:'idInRolePermissionRelation',width:20,align:'center',hidden: 'true'"></th>
	 		
	 </tr>
	 </thead>
	</table>	
       <div id="tbsecondId" style="width:100%">
		  <p id = "">选择二级菜单</p>
	   </div>   
   </div>
	
	
	
</body>
</html>