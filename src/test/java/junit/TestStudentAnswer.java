package junit;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import stu_system.system.mapper.SysStudentAnswerMapper;
import stu_system.system.model.SysCreateQuestionModel;
import stu_system.system.model.SysQuestionLibraryModel;
import stu_system.system.model.SysStudentQuestionnaireRelModel;
import stu_system.system.model.SysUserModel;
import stu_system.system.service.SysStudentAnswerService;

public class TestStudentAnswer {
    
	@Test
	public void testMapper() {
		ApplicationContext ac = new ClassPathXmlApplicationContext("applicationContext.xml");
		SysStudentAnswerMapper mapper = ac.getBean(SysStudentAnswerMapper.class);
	    /*int count = mapper.selectCount(null);*/
		/*SysStudentQuestionnaireRelModel sysStudentQuestionnaireRelModel = new SysStudentQuestionnaireRelModel();
		sysStudentQuestionnaireRelModel.setUserCode("fc30e39b72294941a090dc5f05e82e14");
		sysStudentQuestionnaireRelModel.setCreateQuestionCode("018124c0fc4b4cb28d6d313fbd8ba69c");	*/
		SysCreateQuestionModel sysCreateQuestionModelParameter = new SysCreateQuestionModel();
		sysCreateQuestionModelParameter.setCode("018124c0fc4b4cb28d6d313fbd8ba69c");
		
		ArrayList<SysQuestionLibraryModel> sysQuestionLibraryModelList  = (ArrayList<SysQuestionLibraryModel>) mapper.selectQuestionAnswerForAnalysis(sysCreateQuestionModelParameter);
		
		
		ArrayList<Integer> questionIdList = new ArrayList();
		/*System.out.println("记录总条数是"+sysQuestionLibraryModelList.size());*/
 	   for(SysQuestionLibraryModel sysQuestionLibraryModelForEach : sysQuestionLibraryModelList) {
 		   questionIdList.add(sysQuestionLibraryModelForEach.getId());
 		   
 		  /* System.out.println(sysQuestionLibraryModelForEach.getNumber());
 		   System.out.println(sysQuestionLibraryModelForEach.getAnswerName());*/
 	   }
 	   //利用set集合和list集合将list集合中的重复值给去掉
 	  Set set = new  HashSet(); 
 	   ArrayList<Integer> questionIdListNoRepeat = new ArrayList();  
 	   for (Integer id : questionIdList) {
 		    if(set.add(id)) {
 		    	questionIdListNoRepeat.add(id);
 		    }
 	   }
 	   Collections.sort(questionIdListNoRepeat);
 	   
 	  ArrayList<Map<String , Integer>> questionAndAnswerMapList = new ArrayList();
	  for(Integer id : questionIdListNoRepeat) {
	    	Map questionAndAnswerMap  = new HashMap();
	    	questionAndAnswerMap.put("题号", id);
	    	Integer Acount = new Integer(0);
	    	Integer Bcount = new Integer(0);
	    	Integer Ccount = new Integer(0);
	    	for(SysQuestionLibraryModel sysQuestionLibraryModelForEach : sysQuestionLibraryModelList) {
	    		if(sysQuestionLibraryModelForEach.getId()==id ) {
	    			if(sysQuestionLibraryModelForEach.getAnswerName().equals("A")) {
	 					Acount = sysQuestionLibraryModelForEach.getNumber();   	 	 	 			
	 				}
	 				if(sysQuestionLibraryModelForEach.getAnswerName().equals("B")) {
	 					Bcount = sysQuestionLibraryModelForEach.getNumber();    	 	 	 			
	 				}
	 				if(sysQuestionLibraryModelForEach.getAnswerName().equals("C")) {
	 					Ccount = sysQuestionLibraryModelForEach.getNumber();   	 	 	 			
	 				}	 			
	    			
	    		}
	    		
	    	}
	    	questionAndAnswerMap.put("A", Acount);
	    	questionAndAnswerMap.put("B", Bcount);
	    	questionAndAnswerMap.put("C", Ccount);	
	    	questionAndAnswerMapList.add(questionAndAnswerMap);
	    }
	  /* JSONArray questionAndAnswerMapListJSON = JSONArray.fromObject(questionAndAnswerMapList);
	   System.out.println(questionAndAnswerMapListJSON.toString());
	   */
		  ArrayList<Integer> questionNumberList = new ArrayList();	  
		  ArrayList<Integer> questionOptionAList = new ArrayList();	  
		  ArrayList<Integer> questionOptionBList = new ArrayList();	  
		  ArrayList<Integer> questionOptionCList = new ArrayList();
		  
		  for (Map<String , Integer> mapForEach : questionAndAnswerMapList) {
			  questionNumberList.add(mapForEach.get("题号"));
			  questionOptionAList.add(mapForEach.get("A"));
			  questionOptionBList.add(mapForEach.get("B"));
			  questionOptionCList.add(mapForEach.get("C"));			  
		  }
	  Map<String , ArrayList> questtionNumberAndOptionEchart = new HashMap();
	  questtionNumberAndOptionEchart.put("questionNumber", questionNumberList);
	  questtionNumberAndOptionEchart.put("AOption", questionOptionAList);
	  questtionNumberAndOptionEchart.put("BOption", questionOptionBList);
	  questtionNumberAndOptionEchart.put("COption", questionOptionCList);
	  JSONObject answerAnalysisEchartsDataJSON = JSONObject.fromObject(questtionNumberAndOptionEchart);
	  System.out.println(answerAnalysisEchartsDataJSON.toString());
 	  	
 	  //下面是正确的
 	/* for ( Integer id : questionIdListNoRepeat) {
 		Map questionAndAnswerMap  = new HashMap();
    	questionAndAnswerMap.put("题号", id);
 		Integer Acount = 0;
    	Integer Bcount = 0;
    	Integer Ccount = 0;
 		for(SysQuestionLibraryModel sysQuestionLibraryModelForEach : sysQuestionLibraryModelList) {
 			if(sysQuestionLibraryModelForEach.getId()==id ) {
 				if(sysQuestionLibraryModelForEach.getAnswerName().equals("A")) {
 					Acount = sysQuestionLibraryModelForEach.getNumber();
 	 	 			System.out.println(id+ "Acount是"+Acount);
 				}
 				if(sysQuestionLibraryModelForEach.getAnswerName().equals("B")) {
 					Bcount = sysQuestionLibraryModelForEach.getNumber();
 	 	 			System.out.println(id+ "Bcount是"+Bcount);
 				}
 				if(sysQuestionLibraryModelForEach.getAnswerName().equals("C")) {
 					Ccount = sysQuestionLibraryModelForEach.getNumber();
 	 	 			System.out.println(id+ "Ccount是"+Ccount);
 				}	 			
 			}
 		}
 		questionAndAnswerMap.put("A", Acount);
    	questionAndAnswerMap.put("B", Bcount);
    	questionAndAnswerMap.put("C", Ccount);	
 		questionAndAnswerMapList.add(questionAndAnswerMap);
 	 }
 	JSONArray questionAndAnswerMapListJSON = JSONArray.fromObject(questionAndAnswerMapList);
	   System.out.println(questionAndAnswerMapListJSON.toString());*/
 	   
    /* ArrayList<Map<String , Integer>> questionAndAnswerMapList = new ArrayList();
	    for(Integer id : questionIdListNoRepeat) {
	    	Map questionAndAnswerMap  = new HashMap();
	    	questionAndAnswerMap.put("题号", id);
	    	Integer Acount = null;
	    	Integer Bcount = null;
	    	Integer Ccount = null;
	    	for(SysQuestionLibraryModel sysQuestionLibraryModelForEach : sysQuestionLibraryModelList) {
	    		
	    		System.out.println(sysQuestionLibraryModelForEach.getId());
	    		System.out.println(sysQuestionLibraryModelForEach.getAnswerName());
	    		if(sysQuestionLibraryModelForEach.getId()==1 || sysQuestionLibraryModelForEach.getAnswerName().equals("A")) {
	    			Acount = sysQuestionLibraryModelForEach.getNumber();
	    		}else {
	    			Acount = 0;
	    		}
	    		if(sysQuestionLibraryModelForEach.getId()==1 || sysQuestionLibraryModelForEach.getAnswerName().equals("B")) {
	    			Bcount = sysQuestionLibraryModelForEach.getNumber();
	    		}else {
	    			Bcount = 0;
	    		}
	    		if(sysQuestionLibraryModelForEach.getId()==1 || sysQuestionLibraryModelForEach.getAnswerName().equals("C")) {
	    			Ccount = sysQuestionLibraryModelForEach.getNumber();
	    		}else {
	    			Ccount = 0;
	    		}
	    	}
	    	
	    	System.out.println(id+ "号题的A选项有"+Acount);
	    	System.out.println(id+ "号题的B选项有"+Bcount);
	    	System.out.println(id+ "号题的C选项有"+Ccount);*/
	    	/*questionAndAnswerMap.put("A", Acount);
	    	questionAndAnswerMap.put("B", Bcount);
	    	questionAndAnswerMap.put("C", Ccount);	    	
	    	questionAndAnswerMapList.add(questionAndAnswerMap);    	   */ 
	   /* }*/
	   /*JSONArray questionAndAnswerMapListJSON = JSONArray.fromObject(questionAndAnswerMapList);
	   System.out.println(questionAndAnswerMapListJSON.toString());*/
		
		
	}
	@Test
	public void testService() {
		ApplicationContext ac = new ClassPathXmlApplicationContext("applicationContext.xml");

		SysStudentAnswerService  sysStudentAnswerService  = (SysStudentAnswerService) ac.getBean("sysStudentAnswerService");
		SysStudentQuestionnaireRelModel sysStudentQuestionnaireRelModel = new SysStudentQuestionnaireRelModel();
	   
	    sysStudentQuestionnaireRelModel.setUserCode("fc30e39b72294941a090dc5f05e82e14");
	    sysStudentQuestionnaireRelModel.setCreateQuestionCode("018124c0fc4b4cb28d6d313fbd8ba69c");
	    ArrayList<SysQuestionLibraryModel> sysQuestionLibraryModelList = (ArrayList<SysQuestionLibraryModel>) sysStudentAnswerService.selectQuestionLibraryAndStudentAnswer(sysStudentQuestionnaireRelModel);
	    System.out.println(sysQuestionLibraryModelList.size());
	}
}
