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
	function leaveIsEffect(value,row,index){
		   
		   var isEffect = row.isEffect
		     if(isEffect == 1){
		    	 return "未销假";	
		     }
		     if(isEffect == 0){
		    	 return "已销假";	
		     }
		  	  
		  }
	function leaveStatus(value,row,index){
		var status = row.status;
		
		 if(status==3){
    		  
    		 return "等待班主任审核";
    	 }
    	 if(status==4){
    		
    		 return "班主任未批准该假条"
    	 }    	 
    	 if(status==6){
    		 
    		 return "等待教务审核";
    	 }
    	 if(status==7){
    		 
    		 return "教务未批准该假条";
    	 }
    	 if(status==8){
    		 
    		 return "该假条已被批准";
    	 }		
	}	
</script>
</head>
<body style="margin:1px;">
	<table id="dg" title="个人请假记录" class="easyui-datagrid"
	 fitColumns="true"  pagination="false"  rownumbers="true"
	 url="${pageContext.request.contextPath}/sysLeaveAction/selectLeaveRecordForStudents.do" fit="true" toolbar="#tb">
	 <thead>
	 	<tr>
	 		
	 		<th field="cb" checkbox="true" align="center"></th>
	 		<th data-options="field:'id',width:20, align:'center',hidden: 'true'">编号</th>
	 	    <th data-options="field:'code',width:20,align:'center',hidden: 'true'"></th>
	 	    <th data-options="field:'userTrueName',width:20,align:'center'">姓名</th>
			<th data-options="field:'why',width:20,align:'center'">事由</th> 
	 	    <th data-options="field:'createTime',width:20,align:'center'">申请时间</th> 
	 		<th data-options="field:'beginTime',width:20, align:'center'">开始时间</th>
	 	    <th data-options="field:'endTime',width:20,align:'center',">截至时间</th>
	 	    <th data-options="field:'status',width:20,align:'center' , formatter: leaveStatus">状态</th>
			<th data-options="field:'isEffect',width:20,align:'center' ,formatter: leaveIsEffect ">是否销假</th> 
	 	    <th data-options="field:'descr',width:20,align:'center'">备注</th> 
	 	</tr>
	 </thead>
	</table>
	<div id="tb">		
	</div>		
</body>
</html>