package kr.or.iei.emp.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.stream.Collectors;

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

import com.google.gson.Gson;

import kr.or.iei.common.annotation.AdminChk;
import kr.or.iei.common.annotation.NoLoginChk;
import kr.or.iei.common.exception.CommonException;
import kr.or.iei.document.model.vo.Document;
import kr.or.iei.document.model.vo.DocumentSign;
import kr.or.iei.emp.model.service.EmpService;
import kr.or.iei.emp.model.vo.Chat;
import kr.or.iei.emp.model.vo.ChatGroup;
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
	@NoLoginChk
	public String login(Emp emp, HttpSession session) {
		Emp loginEmp = service.login(emp);
		if(loginEmp != null) {
			if(loginEmp.getRankCode() != null) {
				session.setAttribute("loginEmp", loginEmp);
				session.setMaxInactiveInterval(600);
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
		
		return "redirect:/";
	}
	
	@PostMapping("joinFrm.do")
	@NoLoginChk
	public String joinFrm() {
		
		return"emp/join";
	}
	
	@PostMapping(value="checkId.do",produces="application/json;charset=utf-8" )
	@ResponseBody
	@NoLoginChk
	public int checkId(String empId) {
		System.out.println(empId);
		int result=0;
		result = service.idCheck(empId);
		System.out.println(result);
		return result;
	}
	
	@PostMapping(value = "join.do", produces = "application/json; charset=utf-8")
	@ResponseBody 
	@NoLoginChk
	public int join(Emp emp) {
		String newEmpPw=null;
		newEmpPw=BCrypt.hashpw(emp.getEmpPw(), BCrypt.gensalt());
		System.out.println(emp.toString());
	    emp.setEmpPw(newEmpPw);
	   
	    int result = service.join(emp);
	   
	    
	    return result;
	}
	
	//신규 회원 관리 페이지로 변경
	@PostMapping(value="empWait.do", produces="text/html; charset=utf-8;")
	@AdminChk
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
    
    //달력 프로젝트 불러오기
    
   
    //메인페이지로 이동
	@PostMapping(value="empMain.do",  produces="text/html; charset=utf-8;")
	public String mainPage(HttpSession session, HttpServletResponse response) {
		return "main/main";
	}
	
    
    //로그아웃
    @PostMapping("logout.do")
    public String logOut(HttpSession session) {
        
        Emp loginEmp = (Emp)session.getAttribute("loginEmp");
        
        if(loginEmp != null) {
            session.invalidate();
        }
        
        return "redirect:/"; 
    }
    
    //채팅창으로 이동
    @PostMapping("chatFrm.do")
    public String chatFrm() {
        return "emp/chat";
    }
    
    @PostMapping(value="chatEmpList.do", produces="application/json; charset=utf-8")
    @ResponseBody
    public String chatEmpList() {
        ArrayList<Emp> empList = service.chatEmpList();
        
        return new Gson().toJson(empList);
    }
    
    @PostMapping(value="chatList.do", produces="application/json; charset=utf-8")
    @ResponseBody
    public String chatList(String fromEmpCode, String toEmpCode) {
    	ChatGroup chatGroup = service.selectChatList(fromEmpCode, toEmpCode);
        
        return new Gson().toJson(chatGroup);
    }
    //main 화면 문서 종류별 출력
    @PostMapping(value="docMain.do", produces="application/json; charset=utf-8")
    @ResponseBody
    public String docMain(String empCode) {
        ArrayList<Document> documentList = service.docMain(empCode);
        
        for(Document document : documentList) {
        	String sign = "대기 중";
        	
        	if(document.getSignList() != null && !document.getSignList().isEmpty()) {
        		boolean signIng = false; //반려 상태 여부
        		boolean signOk = true; // 모든 결제자가 결제상태인지 여부
        		
        		//모든 결제자 상태 check
        		for(DocumentSign docSign : document.getSignList()) {
        			String status = docSign.getSignYn(); // 결제자 상태 확인(-1 : 반려, 0 : 대기중, 1 : 결제승인)
        			
        			//결제 상태가 -1인 경우 반려
        			if("-1".equals(status)) {
        				signIng = true;
        				break;
        			}
        		}
        		
        		//최종 결제상태 결정
        		if(signIng) {
        			sign = "반려";
        		}else if(signOk) {
        			sign = "결제 완료";
        		}else {
        			sign = "대기 중";
        		}
        		
        	}
        	document.setProgress(sign);
        }
        
     // 문서 타입별로 데이터를 그룹화
        Map<String, List<Document>> docType = documentList.stream()
                .collect(Collectors.groupingBy(Document::getDocumentTypeCode));
        
        return new Gson().toJson(docType);
    }
}
