package junit;

import java.util.ArrayList;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import stu_system.system.action.SysLeaveAction;
import stu_system.system.mapper.SysLeaveMapper;
import stu_system.system.model.SysLeaveModel;

public class TestLeave {
   
	@Test
	public void testMapper() {
		ApplicationContext ac = new ClassPathXmlApplicationContext("applicationContext.xml");
		SysLeaveMapper sysLeaveMapper = ac.getBean(SysLeaveMapper.class);
		/*int count = sysLeaveMapper.selectCount(null);
		System.out.println(count);*/
		SysLeaveModel sysLeaveModel = new SysLeaveModel();
		sysLeaveModel.setCode("2");
		/*sysLeaveModel.setUserCode("fc30e39b72294941a090dc5f05e82e14");*/
		ArrayList<SysLeaveModel> list = (ArrayList<SysLeaveModel>) sysLeaveMapper.selectLeaveTableAndUserAndDictionaryByTeacher(sysLeaveModel);
	    System.out.println(list.size());
	}
	@Test
	public void testAction() throws Exception {
		ApplicationContext ac = new ClassPathXmlApplicationContext("applicationContext.xml");
		SysLeaveAction sysLeaveAction = (SysLeaveAction) ac.getBean("sysLeaveAction");
		sysLeaveAction.getLeaveInformation(null, null);
	
	
	}
}
