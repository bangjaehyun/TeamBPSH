package kr.or.iei.emp.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.iei.emp.model.service.EmpService;
import kr.or.iei.emp.model.vo.Emp;

@Controller("empController")
@RequestMapping("/emp/")
public class EmpController {

	@Autowired
	@Qualifier("empService")
	private EmpService service;
	
	
	@PostMapping("login.do")
	private String login(Emp emp) {
		Emp loginEmp = service.login(emp);
		
		System.out.println(loginEmp.toString());
		return null;
	}
}
