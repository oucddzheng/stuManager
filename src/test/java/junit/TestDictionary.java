package junit;

import java.util.ArrayList;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import stu_system.system.mapper.SysDictionaryMapper;
import stu_system.system.model.SysDictionaryModel;

public class TestDictionary {
	
	@Test
	public void testMapper() {
		ApplicationContext ac = new ClassPathXmlApplicationContext("applicationContext.xml");
		SysDictionaryMapper sysDictionaryMapper = ac.getBean(SysDictionaryMapper.class);
	  
		SysDictionaryModel sysDictionaryModel = new SysDictionaryModel();
		sysDictionaryModel.setType(2);
		ArrayList<SysDictionaryModel> list = (ArrayList<SysDictionaryModel>) sysDictionaryMapper.selectAll(sysDictionaryModel);
		System.out.println(list.size());
		
		/*int count = sysDictionaryMapper.selectCount(null);
	    System.out.println(count);*/
	
	
	}

}
