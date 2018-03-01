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