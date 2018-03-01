<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>学生管理系统登陆</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.5.3/jquery.min.js"></script>
<STYLE type=text/css>
BODY {
	TEXT-ALIGN: center;
	PADDING-BOTTOM: 0px;
	BACKGROUND-COLOR: #ddeef2;
	MARGIN: 0px;
	PADDING-LEFT: 0px;
	PADDING-RIGHT: 0px;
	PADDING-TOP: 0px
}

A:link {
	COLOR: #000000;
	TEXT-DECORATION: none
}

A:visited {
	COLOR: #000000;
	TEXT-DECORATION: none
}

A:hover {
	COLOR: #ff0000;
	TEXT-DECORATION: underline
}

A:active {
	TEXT-DECORATION: none
}

.input {
	BORDER-BOTTOM: #ccc 1px solid;
	BORDER-LEFT: #ccc 1px solid;
	LINE-HEIGHT: 20px;
	WIDTH: 182px;
	HEIGHT: 20px;
	BORDER-TOP: #ccc 1px solid;
	BORDER-RIGHT: #ccc 1px solid
}

.input1 {
	BORDER-BOTTOM: #ccc 1px solid;
	BORDER-LEFT: #ccc 1px solid;
	LINE-HEIGHT: 20px;
	WIDTH: 120px;
	HEIGHT: 20px;
	BORDER-TOP: #ccc 1px solid;
	BORDER-RIGHT: #ccc 1px solid;
}
</STYLE>
<script type="text/javascript">
   
   $(document).ready(function(){
	 getRoles();
   })
    function getRoles(){
	   $.ajax({
			url : "/stu-system-web/sysRoleAction/getRoles.do",
			type : "POST",
			dataType : "json",
			contentType : 'application/x-www-form-urlencoded; charset=UTF-8',//防止乱码
			success : function(data) {
				show(data)
			}
		});
   }
    function show(rolesList){   	
    	var roles = "";
    	for(var i = 0 ; i < rolesList.length ; i++){
    		roles +=("<option value='"+rolesList[i].code+"'>"+rolesList[i].roleName+"</option>")    		
    	}
    	$("#roleName").append(roles)
    }
	function login(){
		var userName=$("#userName").val();
		var password=$("#password").val();
		var roleName=$("#roleName").val();
		if(userName==null||userName==""){
			alert("用户名不能为空！");
			return;
		}
		if(password==null||password==""){
			alert("密码不能为空！");
			return;
		}
		if(roleName==null||roleName==""){
			alert("请选择用户类型！");
			return;
		}
		 $.ajax({
				url : "/stu-system-web/sysUserAction/login.do",
				type : "POST",
				data : {"userAccount":userName , "userPassword": password , "roleCode" : roleName},
				dataType : "text",
				contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
				success : function(data) {
					if(data=="yes"){
						window.location.href="<%=request.getContextPath()%>/jsp/main.jsp"
					}
					if(data=="no"){
						alert("用户信息错误")
					}
				}
			});			
	}
</script>
</head>
<body>
<div id=adminlogin  method=post name=adminlogin   >
<DIV></DIV>
<TABLE style="MARGIN: auto; WIDTH: 100%; HEIGHT: 100%" border=0
	cellSpacing=0 cellPadding=0>
	<TBODY>
		<TR>
			<TD height=150>&nbsp;</TD>
		</TR>
		<TR style="HEIGHT: 254px">
			<TD>
			<DIV style="MARGIN: 0px auto; WIDTH: 936px"><IMG
				style="DISPLAY: block" src="${pageContext.request.contextPath}/images/body_03.jpg"></DIV>
			<DIV style="BACKGROUND-COLOR: #278296">
			<DIV style="MARGIN: 0px auto; WIDTH: 936px">
			<DIV
				style="BACKGROUND: url(${pageContext.request.contextPath}/images/body_05.jpg) no-repeat; HEIGHT: 155px">
			<DIV
				style="TEXT-ALIGN: left; WIDTH: 265px; FLOAT: right; HEIGHT: 125px; _height: 95px">
			<TABLE border=0 cellSpacing=0 cellPadding=0 width="100%">
				<TBODY>
					<TR>
						<TD style="HEIGHT: 45px"><INPUT type="text" class=input value="${user.userName }" name="userAccount" id="userName"></TD>
					</TR>
					<TR>
						<TD><INPUT type="password" class=input value="${user.password}" name="userPassword" id="password"/></TD>
					</TR>
					<TR>
						<td>
							<select id="roleName" name="roleCode" class="input" style="margin-top: 15px;height: 24px">
								<option value="">请选择用户类型...</option>
							</select>
						</td>
					</TR>
				</TBODY>
			</TABLE>
			</DIV>
			<DIV style="HEIGHT: 1px; CLEAR: both"></DIV>
			<DIV style="WIDTH: 380px; FLOAT: right; CLEAR: both">
			<TABLE border=0 cellSpacing=0 cellPadding=0 width=300>
				<TBODY>
					
					<TR>
						<TD width=100 align=right><INPUT
							style="BORDER-RIGHT-WIDTH: 0px; BORDER-TOP-WIDTH: 0px; BORDER-BOTTOM-WIDTH: 0px; BORDER-LEFT-WIDTH: 0px"
							id=btnLogin src="${pageContext.request.contextPath}/images/btn1.jpg" type=image name=btnLogin onclick="javascript:login();return false;"></TD>
						<TD width=100 align=middle><INPUT
							style="BORDER-RIGHT-WIDTH: 0px; BORDER-TOP-WIDTH: 0px; BORDER-BOTTOM-WIDTH: 0px; BORDER-LEFT-WIDTH: 0px"
							id=btnReset src="${pageContext.request.contextPath}/images/btn2.jpg" type=image name=btnReset onclick="javascript:adminlogin.reset();return false;"></TD>
					</TR>
				</TBODY>
			</TABLE>
			</DIV>
			</DIV>
			</DIV>
			</DIV>
			<DIV style="MARGIN: 0px auto; WIDTH: 936px"><IMG
				src="${pageContext.request.contextPath}/images/body_06.jpg"></DIV>
			</TD>
		</TR>
		<TR style="HEIGHT: 30%">
			<TD>&nbsp;</TD>
		</TR>
	</TBODY>
</TABLE>
</div>
</body>
</html>
<script type=text/javascript>
	if('${errorMsg}'!=''){
		alert('${errorMsg}');
	}
</script>