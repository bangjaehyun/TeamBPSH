package kr.or.iei.emp.controller;

import java.util.ArrayList;
import java.util.Locale;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.iei.common.exception.CommonException;
import kr.or.iei.emp.model.service.EmpService;
import kr.or.iei.emp.model.vo.Emp;


@Controller("empController")
@RequestMapping("/emp/")
public class EmpController {

	@Autowired
	@Qualifier("empService")
	private EmpService service;
	
	  @Autowired
	    @Qualifier("messageSource")
	    private MessageSource message;
	
	//로그인
	@PostMapping("mainPage.do")
	private String login(Emp emp, HttpSession session) {
		
		Emp loginEmp = service.login(emp);
		if(loginEmp != null) {
			if(loginEmp.getRankCode() != null) {
				session.setAttribute("loginEmp", loginEmp);
			}else {
				//승인이 안된 사원
				  CommonException ex = new CommonException("관리자 승인 대기중입니다.");
		          ex.setErrorCode("MA002");
		          ex.setUserMsg(message.getMessage(ex.getErrorCode(), null, Locale.KOREA));
		          throw ex;
			}
		}else {
			//가입을 하지 않은 사람
			CommonException ex = new CommonException("일치하는 회원정보가 존재하지 않습니다.");
	        ex.setErrorCode("MA003");
	        ex.setUserMsg(message.getMessage(ex.getErrorCode(), null, Locale.KOREA));
	        throw ex;
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
	public int join(Emp emp) {
		String newEmpPw=null;
		newEmpPw=BCrypt.hashpw(emp.getEmpPw(), BCrypt.gensalt());
		System.out.println(emp.toString());
	    emp.setEmpPw(newEmpPw);
	   
	    int result = service.join(emp);
	   
	    
	    return result;
	}
	
	//신규 회원 관리 페이지로 변경
	@PostMapping("empWait.do")
	public String empWait(Model model) {
		ArrayList<Emp> empWaitList = service.empWaitList();
		
		model.addAttribute("empWaitList", empWaitList);
		return "main/empWait";
	}
	
	//관리자가 승인하였을 경우
	@PostMapping(value="approval.do", produces="text/html; charset=utf-8;")
    public String approval(Emp emp, int salary, Model model) {
        int result = service.approval(emp, salary);
        
        if(result < 1) {
            CommonException ex = new CommonException("관리자 승인중 오류 발생");
            ex.setErrorCode("SE001");
            Object msgParam[] = {"승인"};
            ex.setUserMsg(message.getMessage(ex.getErrorCode(), msgParam, Locale.KOREA));
            throw ex;
        }
        
        ArrayList<Emp> empWaitList = service.empWaitList();
		
		model.addAttribute("empWaitList", empWaitList);
        
        return "main/empWait";
    }
	
    //달력 화면
    @PostMapping("calendar.do")
    public String calendar() {
        return "emp/calendar";
    }
   
    //메인페이지로 이동
	@PostMapping(value="empMain.do",  produces="text/html; charset=utf-8;")
	public String mainPage(HttpSession session, HttpServletResponse response) {
		Emp loginEmp = (Emp)session.getAttribute("loginEmp");
		if(loginEmp == null) {
			CommonException ex = new CommonException("not loginEmp");
			ex.setErrorCode("MA001");
            ex.setUserMsg(message.getMessage(ex.getErrorCode(), null, Locale.KOREA));
            throw ex;
		}
		
		return "main/main";
	}
}
