package junit;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import stu_system.system.mapper.SysStudentQuestionnaireRelMapper;
import stu_system.system.model.SysStudentQuestionnaireRelModel;

public class TestStudentQuestionnaireRel {
    @Test 
	public void testMapper() {
		ApplicationContext ac = new ClassPathXmlApplicationContext("applicationContext.xml");
		SysStudentQuestionnaireRelMapper mapper = ac.getBean(SysStudentQuestionnaireRelMapper.class);
		SysStudentQuestionnaireRelModel sysStudentQuestionnaireRelModel = new SysStudentQuestionnaireRelModel();
		sysStudentQuestionnaireRelModel.setCreateQuestionCode("018124c0fc4b4cb28d6d313fbd8ba69c");
		int count = mapper.selectCount(null);
	    System.out.println(count);	
	}
}
