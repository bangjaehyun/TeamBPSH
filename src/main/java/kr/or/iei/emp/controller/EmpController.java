package kr.or.iei.emp.controller;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Random;
import java.util.stream.Collectors;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import kr.or.iei.common.EmpSessionListener;
import kr.or.iei.common.annotation.AdminChk;
import kr.or.iei.common.annotation.NoLoginChk;
import kr.or.iei.common.exception.CommonException;
import kr.or.iei.document.model.vo.Document;
import kr.or.iei.document.model.vo.DocumentSign;
import kr.or.iei.emp.model.service.EmpService;
import kr.or.iei.emp.model.vo.Alarm;
import kr.or.iei.emp.model.vo.Chat;
import kr.or.iei.emp.model.vo.ChatGroup;
import kr.or.iei.emp.model.vo.Commute;
import kr.or.iei.emp.model.vo.DailyReport;
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
				if(EmpSessionListener.getInstance().isUsing(loginEmp.getEmpCode())) {
                    CommonException ex = new CommonException("이미 아이디가 접속중 입니다.");
                    ex.setErrorCode("DL001");
                    ex.setData(loginEmp);
                    ex.setUserMsg(message.getMessage(ex.getErrorCode(), null, Locale.KOREA));
                    throw ex;
                }else {
                	session.setAttribute("loginEmp", loginEmp);
					session.setMaxInactiveInterval(600);
                	EmpSessionListener.getInstance().setSession(session, loginEmp.getEmpCode());
                }
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
    public String approval(Emp emp, Model model) {
        int result = service.approval(emp);
        
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
    public String chatEmpList(String empCode) {
        ArrayList<Emp> empList = service.chatEmpList(empCode);
        
        Collection<String> empCodes = EmpSessionListener.getInstance().getEmps();
        
        for(String code : empCodes) {
            for(Emp emp : empList) {
                if(emp.getEmpCode().equals(code)) {
                    emp.setLogin(true);
                }
            }
        }    
        
        return new Gson().toJson(empList);
    }
    
    @PostMapping(value="chatList.do", produces="application/json; charset=utf-8")
    @ResponseBody
    public String chatList(String fromEmpCode, String toEmpCode) {
    	ChatGroup chatGroup = service.selectChatList(fromEmpCode, toEmpCode);
        
        return new Gson().toJson(chatGroup);
    }
    //main 화면 문서 종류별 출력
    @PostMapping(value="docMain", produces="application/json; charset=utf-8")
    @ResponseBody
    public String docMain(String empCode) {
        ArrayList<Document> documentList = service.docMain(empCode);
        
        for(Document document : documentList) {
        	String sign = "";
        	String status = "";
        	if(document.getProgress() != null && !document.getProgress().isEmpty()) {
        		
        		//모든 결제자 상태 check
        			 status = document.getProgress(); // 결제자 상태 확인(-1 : 반려, 0 : 대기중, 1 : 결제승인)
        			//최종 결제상태 결정
        			if(status.equals("-1")) {
        				sign = "반려";
        			}else if(status.equals("1")) {
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
        
    
    
    //회원관리
    @PostMapping("empManager.do")
    @AdminChk
    public String empManager(Model model) {
    	ArrayList<Emp> empList = service.empManagerList();
    	model.addAttribute("empList", empList);
    	return "main/empManager";
    }
    
    //회원정보 변경
    @PostMapping("changeEmp.do")
    public String changeEmp(Emp emp, Model model) {
    	 int result = service.changeEmp(emp);
         
         if(result < 1) {
             CommonException ex = new CommonException("사원 수정중 오류 발생");
             ex.setErrorCode("SE001");
             Object msgParam[] = {"변경"};
             ex.setUserMsg(message.getMessage(ex.getErrorCode(), msgParam, Locale.KOREA));
             throw ex;
         }
         
        ArrayList<Emp> empList = service.empManagerList();
 		model.addAttribute("empList", empList);
    	
    	
    	return "main/empManager";
    }

    //업무일지 창 
    @PostMapping("dailyReportWrite.do")
    public String dailyReportWrite(String empCode, Model model) {
    	model.addAttribute("empCode",empCode);
    	return "emp/dailyReportWrite";
    }
    
    //일일 업무일지 등록
    @PostMapping("dailyReportCreate.do")
    @ResponseBody
    public Map<String, Object> reportCreate(DailyReport daily) {
        Map<String, Object> response = new HashMap<>();
        int result = service.reportCreate(daily);

        if (result > 0) {
            response.put("success", true);
            response.put("message", "업무일지가 성공적으로 등록되었습니다.");
        } else {
            response.put("success", false);
            response.put("message", "업무일지 등록에 실패했습니다.");
        }
        return response;
    }
    
    //일일 업무일지  수정 창
    @PostMapping("dailyReportUpdateForm.do")
    public String dailyReportUpdate(Model model, String empCode) {
    	DailyReport report = service.dailyReportUpdate(empCode);
    	model.addAttribute("dailyReport", report);
    	return "emp/dailyReportUpdate";
    }
    //일일 업무일지 상태 확인 
    @PostMapping("dailyReportCheck.do")
    @ResponseBody
    public boolean checkDailyReportExists(String empCode) {
    	boolean exist = service.empCheckReport(empCode);
    	return exist;
    }
    //일일 업무일지 수정 
    @PostMapping("dailyReportUpdate.do")
    @ResponseBody
    public Map<String, Object> updateDailyReport(DailyReport dailyReport) {
        Map<String, Object> response = new HashMap<>();
        int result = service.dailyReportUpd(dailyReport);

        if (result > 0) {
            response.put("success", true);
            response.put("message", "업무일지가 성공적으로 수정되었습니다.");
        } else {
            response.put("success", false);
            response.put("message", "업무일지 수정에 실패했습니다.");
        }
        return response; // JSON 응답 반환
    }
    

    
  //기존 세션 종료
    @PostMapping(value="removeSession.do", produces="application/json; charset=utf-8")
    @NoLoginChk
    @ResponseBody
    public String removeSession(Emp emp, HttpSession session) {
        
        if(emp != null) {
            EmpSessionListener.getInstance().removeSession(emp.getEmpCode());
        
            session.setAttribute("loginEmp", emp);
            session.setMaxInactiveInterval(600);
            EmpSessionListener.getInstance().setSession(session, emp.getEmpCode());
        }
        
        return "1";
    }
    
    

    @PostMapping(value="addReadCount.do", produces="application/json; charset=utf-8")
    @ResponseBody
    public String addReadCount(Chat chat) {
        service.chatAddReadCount(chat);
        
        return "1";
    }
    
    
    //채팅 파일 업로드
      @PostMapping(value="chatUpload.do", produces = "application/json; charset=utf-8")
      @ResponseBody
      public String chatUpload(HttpServletRequest request, MultipartFile file) {
          Chat chat = null;
          if(!file.isEmpty()) {

              String savePath = request.getSession().getServletContext().getRealPath("/resources/chatUpload/");
              String originalFilename = file.getOriginalFilename();
              String fileName = originalFilename.substring(0, originalFilename.lastIndexOf("."));
              String extension = originalFilename.substring(originalFilename.lastIndexOf("."));
              
              //서버 업로드 파일명 중복되지 않도록
              String toDay = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
              int ranNum = new Random().nextInt(100000) +1;
              String filePath = fileName + "_" + toDay + "_" + ranNum + extension;
              
              savePath += filePath;
              
              try {
                  byte[] bytes = file.getBytes();
                  BufferedOutputStream bos = new BufferedOutputStream(new FileOutputStream(new File(savePath)));
                  bos.write(bytes);
                  bos.close();
                  
                  chat = new Chat();
                  chat.setChatFileName(originalFilename);
                  chat.setChatFilePath(filePath);
                  
                  //result = service.insertChatFile(chat);
              } catch (IOException e) {
                  // TODO Auto-generated catch block
                  e.printStackTrace();
              }
          }
          
          return new Gson().toJson(chat);
      }
      
      //채팅 파일 다운
      @GetMapping(value="/chatFileDown.do", produces = "application/octet-stream;")
      public void chatFileDown(HttpServletRequest request, HttpServletResponse response, String fileName, String filePath) {
            
            String root = request.getSession().getServletContext().getRealPath("/resources/chatUpload/");
          
          
            BufferedInputStream bis = null;
            BufferedOutputStream bos = null;
            
            try {
               FileInputStream fis = new FileInputStream(root + filePath);
               
               bis = new BufferedInputStream(fis);
               
               ServletOutputStream sos = response.getOutputStream();
               
               bos = new BufferedOutputStream(sos);
               
               String resFilename = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
               
               response.setHeader("Content-Disposition", 
                       "attachment; filename="+resFilename);
               
               while(true) {
                  int read = bis.read();
                  if(read == -1) {
                      break;
                  }else {
                      bos.write(read);
                      System.out.println(read);
                  }
              }
               
            } catch (FileNotFoundException e) {
               // TODO Auto-generated catch block
               e.printStackTrace();
            } catch (IOException e) {
               // TODO Auto-generated catch block
               e.printStackTrace();
            } finally {
                try {
                    bos.close();
                    bis.close();
                } catch (IOException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
            }
      }

      @PostMapping(value="loadAlarmList.do", produces="application/json; charset=utf-8")
      @ResponseBody
      public String loadAlarmList(String empCode) {
    	  ArrayList<Alarm> alarmList = service.loadAlarmList(empCode);
    	  System.out.println(alarmList);
    	  return new Gson().toJson(alarmList);
      }
      
      @PostMapping(value="alarmRead.do", produces="application/json; charset=utf-8")
      @ResponseBody
      public String alarmRead(String alarmNo) {
    	  int result = service.readAlarm(alarmNo);
    	  System.out.println(result);
    	  return String.valueOf(result);
      }
      
      @PostMapping("myPage.do")
      public String myPage(String empCode, Model model) {
    	  Commute commute = service.selectCommute(empCode);
    	  
    	  model.addAttribute("commute", commute);
    	  
    	  return "emp/myPage";
      }
      
      @PostMapping(value="onWork.do", produces="application/json; charset=utf-8")
      @ResponseBody
      public String onWork(String empCode) {
    	  return  String.valueOf(service.onWork(empCode));
      }
      
      @PostMapping(value="offWork.do", produces="application/json; charset=utf-8")
      @ResponseBody
      public String offWork(String empCode) {
    	  return  String.valueOf(service.offWork(empCode));
      }
      
      @PostMapping(value="updateEmp.do", produces="application/json; charset=utf-8")
      @ResponseBody
      public String updateEmp(Emp emp, HttpSession session) {
    	  Emp loginEmp = service.updateEmp(emp);
    	  
    	  if(loginEmp == null) {
    		  return "0";
    	  }else {
    		  session.setAttribute("loginEmp", loginEmp);
    	  }
    	  
    	  return "1";
      }
      
      @PostMapping("empPwUpdateFrm.do")
      public String empPwUpdateFrm() {
    	  return "emp/pwUpdate";
      }
      
      @PostMapping(value="updatePw.do", produces="application/json; charset=utf-8")
      @ResponseBody
      public String updatePw(Emp emp, String oldPw, String newPw, HttpSession session) {
    	  int result = service.updatePw(emp,oldPw, newPw);
    	  
    	  if(result > 0) {
    		  session.invalidate();
    	  }
    	  
    	  return String.valueOf(result);
      }
}
