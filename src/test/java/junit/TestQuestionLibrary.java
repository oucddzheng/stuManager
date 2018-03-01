package junit;

import java.util.ArrayList;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import stu_system.system.mapper.SysQuestionLibraryMapper;
import stu_system.system.model.SysQuestionLibraryModel;

public class TestQuestionLibrary {
    
	@Test
	public void testMapper() {
		ApplicationContext ac = new ClassPathXmlApplicationContext("applicationContext.xml");
		SysQuestionLibraryMapper mapper = ac.getBean(SysQuestionLibraryMapper.class);
		int count = mapper.selectCount(null);
		System.out.println(count);
		SysQuestionLibraryModel sysQuestionLibraryModel = new SysQuestionLibraryModel();
		ArrayList<SysQuestionLibraryModel> list = (ArrayList<SysQuestionLibraryModel>) mapper.selectModel(sysQuestionLibraryModel);		
	    System.out.println(list.size());
	
	}
	
}
