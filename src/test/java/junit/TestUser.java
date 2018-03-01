package junit;

import java.util.ArrayList;
import java.util.Random;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import stu_system.system.action.SysUserAction;
import stu_system.system.mapper.SysUserMapper;
import stu_system.system.model.SysUserModel;
import tools.FormatCalendar;
import tools.UniqueCode;

public class TestUser {
	@Test
	public void testMapper() {
		ApplicationContext ac = new ClassPathXmlApplicationContext("applicationContext.xml");
		SysUserMapper sysUserMapper = ac.getBean(SysUserMapper.class);
		/*int count = sysUserMapper.selectCount(null);
		System.out.println(count);	*/
		SysUserModel sysUserModelParameter = new SysUserModel();
		
		/*sysUserModelParameter.setIsDelete(0);*/
		
		/*int i = sysUserMapper.selectCount(sysUserModelParameter);
		System.out.println(i);*/
	   /* ArrayList<SysUserModel> list = (ArrayList<SysUserModel>) sysUserMapper.selectUserAndRoleAndClass(sysUserModelParameter);
		System.out.println(list.size());*/
		
		/*System.out.println(list.get(2).getSysClassModel());*/
		/*sysUserModelParameter.setCode(UniqueCode.getUUID());*/
		sysUserModelParameter.setId(13);
		sysUserModelParameter.setUserAccount("aaaa");
		sysUserModelParameter.setUserPassword("111111");
		sysUserModelParameter.setUserTrueName("уей╝");
		sysUserModelParameter.setUserTelephone("18253206010");
		sysUserModelParameter.setRoleCode("1");
		sysUserModelParameter.setClassCode("1");
		/*sysUserModelParameter.setCreateTime(FormatCalendar.getCurrentTime(FormatCalendar.F_YMDHMS));*/
		sysUserModelParameter.setUpdateTime(FormatCalendar.getCurrentTime(FormatCalendar.F_YMDHMS));
		/*sysUserModelParameter.setCreator("admin@qq.com");*/
		sysUserModelParameter.setUpdater("admin@qq.com");
		sysUserModelParameter.setIsDelete(0);
		sysUserModelParameter.setIsEffect(1);
		/*sysUserModelParameter.setOrderBy((new Random()).nextDouble());*/
		sysUserModelParameter.setDescr("нч");
		int count = sysUserMapper.selectCount(sysUserModelParameter);
		System.out.println(count);
	}
	@Test
	public void testAciton() throws Exception {
		ApplicationContext ac = new ClassPathXmlApplicationContext("applicationContext.xml");
		SysUserAction sysUserAction =  (SysUserAction) ac.getBean("sysUserAction");
		sysUserAction.getUserInformationForAttendence(null, null, null);
	}
	
	
}
