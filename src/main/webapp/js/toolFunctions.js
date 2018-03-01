
//该函数是用来进行手机号校验的，
function telephoneNumberTest(telephoneNumber){
	if(/^1[34578]\d{9}$/.test(telephone)){
		return true
	}else{
		return false
		}
}
//该函数是用来检验邮箱
function emailTest(email){
	if((/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/).test(email)){
		return true;
	}else{
		return false;
	}
} 