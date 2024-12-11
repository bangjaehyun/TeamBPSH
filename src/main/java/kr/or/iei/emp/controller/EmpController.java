package kr.or.iei.emp.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
	
	@PostMapping("joinFrm.do")
	public String joinFrm() {
		
		return"emp/join";
	}
	
	@PostMapping(value="checkId.do",produces="application/json;charset=utf-8" )
	@ResponseBody
	public int checkId(String empId) {
		
		int result=0;
		result = service.idCheck(empId);
		
		return result;
	}
	
	@PostMapping("join.do")
	public String join(Emp emp, Model m) {
	
		int result=0;
		result=service.join(emp);
		System.out.println(result);
		if(result>0) {
			//추후 알림기능 추가시 여기에 작성.
			
			m.addAttribute("alert", "신청이 완료되어 관리자 승인시 가입이 가능합니다.");
		return "redirect:/";
		}else {
			m.addAttribute("alert", "신청중 문제가 발생되었습니다 관리자에게 보고해주세요.");
			return"emp/join";
		}
	}
	
	
}
