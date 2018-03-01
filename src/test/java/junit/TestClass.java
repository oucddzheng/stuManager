package junit;

import java.util.ArrayList;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import stu_system.system.action.SysClassAction;
import stu_system.system.mapper.SysClassMapper;
import stu_system.system.model.SysClassModel;

public class TestClass {

	@Test
	public void testMapper() {
		ApplicationContext ac = new ClassPathXmlApplicationContext("applicationContext.xml");
		SysClassMapper<SysClassModel> sysClassMapper = ac.getBean(SysClassMapper.class);
		/*int count = sysClassMapper.selectCount(null);
		System.out.println(count);*/
		SysClassModel sysClassModel = new SysClassModel();
		
		ArrayList<SysClassModel> list = (ArrayList<SysClassModel>) sysClassMapper.selectAll(sysClassModel);
		System.out.println(list.size());
	
	}
	
	@Test
	public void testAction() throws Exception {
		ApplicationContext ac = new ClassPathXmlApplicationContext("applicationContext.xml");
		SysClassAction sysClassAction = (SysClassAction) ac.getBean("sysClassAction");
		sysClassAction.getClassName(null, null, null);
	}
	
	
}
