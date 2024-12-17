package kr.or.iei.emp.controller;

import java.util.ArrayList;
import java.util.Locale;

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
	
	@PostMapping("mainPage.do")
	private String login(Emp emp, HttpSession session) {
		
		Emp loginEmp = service.login(emp);
		if(loginEmp != null) {
			if(loginEmp.getRankCode() != null) {
				session.setAttribute("loginEmp", loginEmp);
			}else {
				//愿�由ъ옄 �듅�씤�쓣 紐삳컺�� �쉶�썝
				return "redirect:/";
			}
		}else {
			//�쉶�썝 媛��엯�쓣 �븞�븳 �쉶�썝
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
	public int join(Emp emp) {
		String newEmpPw=null;
		newEmpPw=BCrypt.hashpw(emp.getEmpPw(), BCrypt.gensalt());
		System.out.println(emp.toString());
	    emp.setEmpPw(newEmpPw);
	   
	    int result = service.join(emp);
	   
	    
	    return result;
	}
	
	
	@PostMapping("empWait.do")
	public String empWait(Model model) {
		ArrayList<Emp> empWaitList = service.empWaitList();
		
		model.addAttribute("empWaitList", empWaitList);
		return "main/empWait";
	}
	
	@PostMapping("emp/approval.do")
    public String approval(Emp emp, int salary) {
        int result = service.approval(emp, salary);
        
        if(result < 1) {
            CommonException ex = new CommonException("시발");
            ex.setErrorCode("EC001");
            ex.setUserMsg(message.getMessage(ex.getErrorCode(), null, Locale.KOREA));
            throw ex;
        }
        
        return "main/empWait";
    }
	
	
}
