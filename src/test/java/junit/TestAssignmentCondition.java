package junit;

import java.util.ArrayList;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import stu_system.system.mapper.SysAssignmentConditionMapper;
import stu_system.system.model.SysAasignmentModel;
import stu_system.system.model.SysAssignmentConditionModel;
import stu_system.system.model.SysUserModel;

public class TestAssignmentCondition {
	@Test
	public void testMapper() {
		ApplicationContext ac = new ClassPathXmlApplicationContext("applicationContext.xml");
		SysAssignmentConditionMapper mapper = ac.getBean(SysAssignmentConditionMapper.class);
	   /* int count = mapper.selectCount(null);
	    System.out.println(count);*/
		/*SysUserModel sysUserModel = new SysUserModel();
		sysUserModel.setClassCode("2");
		sysUserModel.setRoleCode("2");
		sysUserModel.setCode("fc30e39b72294941a090dc5f05e82e14");
		ArrayList<SysAasignmentModel> list = (ArrayList<SysAasignmentModel>) mapper.selectAssignmentAndAssignment_conditionAndUser(sysUserModel);*/
		SysAasignmentModel sysAasignmentModel = new SysAasignmentModel();
		sysAasignmentModel.setTeacherCode("fc30e39b72294941a090dc5f05e82e14");
		sysAasignmentModel.setCode("dce74e3274104a84ba06e6c5c9f5cc03");
		ArrayList<SysAssignmentConditionModel> list = (ArrayList<SysAssignmentConditionModel>) mapper.selectUserAndAssignment_condition(sysAasignmentModel);
		System.out.println(list.size());	
	}

}
