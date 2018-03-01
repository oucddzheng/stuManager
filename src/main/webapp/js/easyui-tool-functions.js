

//该函数用来设置easyui中下拉框的值
 function setComboxValue(data , id, valueField , textField){
    	$('#'+id).combobox({    
	    data:data,   
	    valueField:valueField,    
	    textField:textField   
	});  		
 }