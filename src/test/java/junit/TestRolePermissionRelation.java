package junit;

import java.util.ArrayList;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import stu_system.system.mapper.SysRolePermissionRelationMapper;
import stu_system.system.model.SysPermissionModel;
import stu_system.system.model.SysRolePermissionRelationModel;

public class TestRolePermissionRelation {
	
	@Test
	public void testMapper() {
		ApplicationContext ac = new ClassPathXmlApplicationContext("applicationContext.xml");
		SysRolePermissionRelationMapper sysRolePermissionRelationMapper = ac.getBean(SysRolePermissionRelationMapper.class);
	   
		/*SysRolePermissionRelationModel sysRolePermissionRelationModel = new SysRolePermissionRelationModel();
		sysRolePermissionRelationModel.setRoleCode("3");
		sysRolePermissionRelationModel.setMenuCode("4");*/
		/*int count = sysRolePermissionRelationMapper.selectCount(sysRolePermissionRelationModel);*/
		SysPermissionModel sysPermissionModel = new SysPermissionModel();
		sysPermissionModel.getSysRolePermissionRelationModel().setRoleCode("3");
	    ArrayList<SysPermissionModel> list = (ArrayList<SysPermissionModel>) sysRolePermissionRelationMapper.selectPermissionAndRolePermissionRel(sysPermissionModel);
		
		System.out.println(list.size());
	
	
	} 

}
