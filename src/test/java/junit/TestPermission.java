package junit;

import java.util.List;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import stu_system.system.mapper.SysPermissionMapper;
import stu_system.system.model.SysPermissionModel;

public class TestPermission {
	@Test
	public void testMapper() {
		ApplicationContext ac = new ClassPathXmlApplicationContext("applicationContext.xml");
		SysPermissionMapper mapper = ac.getBean(SysPermissionMapper.class);
		SysPermissionModel sysPermissionModelParameter = new SysPermissionModel();
		sysPermissionModelParameter.setType(1);		
		sysPermissionModelParameter.getSysRolePermissionRelationModel().setRoleCode("3");
		/*int count = mapper.selectCount(null);
		System.out.println(count);	*/	
		List<SysPermissionModel> list = mapper.selectPermissionAndRolePermissionRel(sysPermissionModelParameter);
		System.out.println(list.size());
		
	}
	

}
