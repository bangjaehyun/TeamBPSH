package kr.or.iei.emp.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

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
	
	@PostMapping(value="join.do",produces="application/json;charset=utf-8")
	public void join(Emp emp, Model m,HttpServletResponse response) {
	
		int result=0;
		result=service.join(emp);
		
		if(result>0) {
			//추후 알림기능 추가시 여기에 작성.
			 try {
			        response.setContentType("text/html; charset=utf-8");
			        PrintWriter w = response.getWriter();
			        w.write("<script>alert('가입신청이 완료되었습니다. 관리자 승인 시 로그인이 가능합니다.');location.href='/';</script>");
			        w.flush();
			        w.close();
			    } catch(Exception e) {
			        e.printStackTrace();
			    }
			
		
		}else {
			 try {
			        response.setContentType("text/html; charset=utf-8");
			        PrintWriter w = response.getWriter();
			        w.write("<script>alert('가입 신청중 오류가 발생했습니다. 관리자에게 문의해 주십시오.');location.href='/WEB-INF/views/emp/join.jsp';</script>");
			        w.flush();
			        w.close();
			    } catch(Exception e) {
			        e.printStackTrace();
			    }
			
		}
	}
	
	
}
