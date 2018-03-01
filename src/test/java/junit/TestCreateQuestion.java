package junit;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import net.sf.json.JSONArray;
import stu_system.system.mapper.SysCreateQuestionMapper;
import stu_system.system.model.SysCreateQuestionModel;
import stu_system.system.model.SysQuestionnaireForStuModel;
import stu_system.system.model.SysUserModel;
import tools.FormatEmpty;

public class TestCreateQuestion {
	
	@Test
	public void testMapper() {
		ApplicationContext ac = new  ClassPathXmlApplicationContext("applicationContext.xml");
		SysCreateQuestionMapper mapper = ac.getBean(SysCreateQuestionMapper.class);
		/*SysCreateQuestionModel sysCreateQuestionModel = new SysCreateQuestionModel();		*/
		/*int count = mapper.selectCount(sysCreateQuestionModel);
	    System.out.println(count);*/
		/*sysCreateQuestionModel.setCode("018124c0fc4b4cb28d6d313fbd8ba69c");
		ArrayList<SysCreateQuestionModel> list = (ArrayList<SysCreateQuestionModel>) mapper.selectQuestionForAnswerOfStu(sysCreateQuestionModel);
		System.out.println(list.size());*/
		SysUserModel  sysUserModelParameter = new SysUserModel();
    	sysUserModelParameter.setCode("fc30e39b72294941a090dc5f05e82e14");
    	ArrayList<SysCreateQuestionModel> sysCreateQuestionModelList  = (ArrayList<SysCreateQuestionModel>) mapper.selectCreateQuestionAndStudentRelation(sysUserModelParameter);
    	if(FormatEmpty.isEmpty(sysCreateQuestionModelList)) {
    		System.out.println("Ã»ÓÐÎÊ¾í");
    		
    	}
    	
    	ArrayList<Map<String , String>> listMapRequired = new ArrayList();
    	for(SysCreateQuestionModel modelForEach : sysCreateQuestionModelList) {
    		Map<String , String> mapModel = new HashMap();
    		mapModel.put("cb", "");
    		mapModel.put("id", modelForEach.getId().toString());
    		mapModel.put("code", modelForEach.getCode());
    		mapModel.put("questionnaireName", modelForEach.getQuestionName());
    		String descr = modelForEach.getDescr();
    		if(FormatEmpty.isEmpty(descr)) {
    			mapModel.put("descr", "");
    		}else {
    			mapModel.put("descr", descr);
    		}
    		
    		SysQuestionnaireForStuModel sysQuestionnaireForStuModel = modelForEach.getSysQuestionnaireForStuModel(); 		   		
    		System.out.println("a"+sysQuestionnaireForStuModel.getUserCode());
    		if(sysQuestionnaireForStuModel.getUserCode() ==null) {
    			mapModel.put("operation", "0");		
    		}else {
    			mapModel.put("operation", "1");
    		}
    		listMapRequired.add(mapModel);
    	}
    	  JSONArray sysUserModellistJson = JSONArray.fromObject(listMapRequired);	    	  
    	   	
		
		
		
		
		
	
	}
	

}
