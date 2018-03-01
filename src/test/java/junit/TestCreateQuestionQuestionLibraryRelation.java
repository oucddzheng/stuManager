package junit;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import stu_system.system.mapper.SysCreateQuestionQuestionLibraryRelationMapper;

public class TestCreateQuestionQuestionLibraryRelation {
	@Test
	public void testMapper() {
		ApplicationContext ac = new  ClassPathXmlApplicationContext("applicationContext.xml");
		SysCreateQuestionQuestionLibraryRelationMapper mapper = ac.getBean(SysCreateQuestionQuestionLibraryRelationMapper.class);
	    int count = mapper.selectCount(null);
	    System.out.println(count);
	}

}
