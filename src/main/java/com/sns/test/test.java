package com.sns.test;

import java.util.HashMap;
import java.util.Map;

import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@EnableAutoConfiguration(exclude={DataSourceAutoConfiguration.class})
@Controller
public class test {

	// 1. String 체크
	@ResponseBody
	@RequestMapping("/test1")
	public String test1() {
		return "Hello world";
	}
	
	// 2. Map 체크
	@ResponseBody
	@RequestMapping("/test2")
	public Map<String, Object> test2(){
		Map<String, Object> test2 = new HashMap<>();
		
		test2.put("안녕", "ㅋㅋ");
		test2.put("테스트", 111);
		test2.put("테스트2", 222);
		
		return test2;
	}
	
	// 3. jsp 체크
	@RequestMapping("/test3")
	public String test3() {
		return "test/quizTest";
	}
	
}
