package junit;

import java.util.ArrayList;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import stu_system.system.mapper.SysWorkAttendanceMapper;
import stu_system.system.model.SysWorkAttendanceModel;

public class TestWorkAttendence {
	@Test
	public void testMapper() {
		ApplicationContext ac = new ClassPathXmlApplicationContext("applicationContext.xml");
		SysWorkAttendanceMapper mapper = ac.getBean(SysWorkAttendanceMapper.class);
		SysWorkAttendanceModel sysWorkAttendanceModel = new SysWorkAttendanceModel();
		sysWorkAttendanceModel.getSysUserModel().setClassCode("2");
		
		/*sysWorkAttendanceModel.setTime("2018-01-23");*/
		/*sysWorkAttendanceModel.setUserTrueName("Ö£¶°¶°");*/
		/*ArrayList<SysWorkAttendanceModel> list = (ArrayList<SysWorkAttendanceModel>) mapper.selectAttendenceStatus(sysWorkAttendanceModel);
		System.out.println(list.size());*/
		/*int count = mapper.selectCount(null);
		System.out.println(count);	*/
	}

}
