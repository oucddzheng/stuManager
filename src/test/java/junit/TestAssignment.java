package junit;

import java.util.ArrayList;
import java.util.Random;

import javax.servlet.http.HttpSession;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import stu_system.system.mapper.SysAasignmentMapper;
import stu_system.system.model.SysAasignmentModel;
import stu_system.system.model.SysUserModel;
import tools.FormatCalendar;
import tools.FormatEmpty;
import tools.UniqueCode;

public class TestAssignment {
	
	@Test
	public void testMapper() {
		/*ApplicationContext ac = new ClassPathXmlApplicationContext("applicationContext.xml");*/
		ApplicationContext ac = new ClassPathXmlApplicationContext("applicationContext.xml");
		
		SysAasignmentMapper sysAasignmentMapper  = ac.getBean(SysAasignmentMapper.class);
		SysAasignmentModel sysAasignmentModel  = new SysAasignmentModel();
		ArrayList<SysAasignmentModel> list =  (ArrayList<SysAasignmentModel>) sysAasignmentMapper.selectAasignmentAndDictionary(sysAasignmentModel);
		System.out.println(list.size());
		
		/*int count = sysAasignmentMapper.selectCount(null);
	    System.out.println(count);*/
		
		
		
	
	}

}
