package junit;

import java.util.ArrayList;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import stu_system.system.action.SysRoleAction;
import stu_system.system.mapper.SysRoleMapper;
import stu_system.system.model.SysRoleModel;

public class TestRole {
	
	@Test
	public void testMapper() {
		ApplicationContext ac = new ClassPathXmlApplicationContext("applicationContext.xml");
		SysRoleMapper sysRoleMapper = ac.getBean(SysRoleMapper.class);
		/*int count = sysRoleMapper.selectCount(null);
		System.out.println(count);		*/
		
		SysRoleModel sysRoleModelParameter = new SysRoleModel();
		
		ArrayList<SysRoleModel> sysRoleModelList = (ArrayList<SysRoleModel>) sysRoleMapper.selectAll(sysRoleModelParameter);
	    System.out.println(sysRoleModelList.size());
	
	}
	@Test
	public void testAction() throws Exception {
		ApplicationContext ac = new ClassPathXmlApplicationContext("applicationContext.xml");
		SysRoleAction sysRoleAction = (SysRoleAction) ac.getBean("sysRoleAction");
		sysRoleAction.getRoles(null, null);	
	}
	

}
