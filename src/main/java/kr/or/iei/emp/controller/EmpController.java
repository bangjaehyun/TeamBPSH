package kr.or.iei.emp.controller;

import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;
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
	
	
	@PostMapping("mainPage.do")
	private String login(Emp emp, HttpSession session) {
		Emp loginEmp = service.login(emp);
		if(loginEmp != null) {
			if(loginEmp.getRankCode() != null) {
				session.setAttribute("loginEmp", loginEmp);
			}else {
				//관리자 승인을 못받은 회원
				return "redirect:/";
			}
		}else {
			//회원 가입을 안한 회원
			return "redirect:/";
		}
		
		return "main/mainPage";
	}
	
	@PostMapping("joinFrm.do")
	public String joinFrm() {
		
		return"emp/join";
	}
	
	@PostMapping(value="checkId.do",produces="application/json;charset=utf-8" )
	@ResponseBody
	public int checkId(String empId) {
		System.out.println(empId);
		int result=0;
		result = service.idCheck(empId);
		System.out.println(result);
		return result;
	}
	
	@PostMapping(value = "join.do", produces = "application/json; charset=utf-8")
	@ResponseBody 
	public int join(String empId, String empPw, String empName, String empPhone) {
		String newEmpPw=null;
		newEmpPw=BCrypt.hashpw(empPw, BCrypt.gensalt());
		Emp emp=new Emp();
	    emp.setEmpId(empId);
	    emp.setEmpPw(newEmpPw);
	    emp.setEmpName(empName);
	    emp.setEmpPhone(empPhone);
	    int result = service.join(emp);
	   
	    
	    return result;
	   
	}
	
	
	@PostMapping("empWait.do")
	public String empWait(Model model) {
		ArrayList<Emp> empWaitList = service.empWaitList();
		
		model.addAttribute("empWaitList", empWaitList);
		return "main/empWait";
	}
	
	
}
