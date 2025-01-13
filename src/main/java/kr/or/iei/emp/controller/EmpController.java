package kr.or.iei.emp.controller;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.YearMonth;
import java.time.format.DateTimeFormatter;
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

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.hssf.util.HSSFColor.HSSFColorPredefined;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.MessageSource;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;


import kr.or.iei.common.EmpSessionListener;
import kr.or.iei.common.annotation.AdminChk;
import kr.or.iei.common.annotation.NoLoginChk;
import kr.or.iei.common.exception.CommonException;
import kr.or.iei.document.model.vo.Document;
import kr.or.iei.document.model.vo.Sales;
import kr.or.iei.document.model.vo.Spending;
import kr.or.iei.emp.model.service.EmpService;
import kr.or.iei.emp.model.vo.Alarm;
import kr.or.iei.emp.model.vo.AlarmPaging;
import kr.or.iei.emp.model.vo.Chat;
import kr.or.iei.emp.model.vo.ChatGroup;
import kr.or.iei.emp.model.vo.Check;
import kr.or.iei.emp.model.vo.Commute;
import kr.or.iei.emp.model.vo.DailyReport;
import kr.or.iei.emp.model.vo.DevelopPrice;
import kr.or.iei.emp.model.vo.Disciplinary;
import kr.or.iei.emp.model.vo.Emp;
import kr.or.iei.emp.model.vo.Leader;
import kr.or.iei.emp.model.vo.Salary;
import kr.or.iei.emp.model.vo.SalesSpending;


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
    @PostMapping(value="docMain.do", produces="application/json; charset=utf-8")
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
    @PostMapping(value="empManager.do", produces="text/html; charset=utf-8;")
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
    
    //급여 변경
    @PostMapping("updateSalary.do")
    public String updateSalary(Emp emp, Model model) {
    	
    	int result = service.updateSalary(emp);
    	
    	 if(result < 1) {
             CommonException ex = new CommonException("사원 급여 수정중 오류 발생");
             ex.setErrorCode("SE001");
             Object msgParam[] = {"급여"};
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
      public String loadAlarmList(AlarmPaging alarmNavi) {
    	  AlarmPaging alarmPaging = service.loadAlarmList(alarmNavi);
    	  return new Gson().toJson(alarmPaging);
      }
      
      @PostMapping(value="alarmRead.do", produces="application/json; charset=utf-8")
      @ResponseBody
      public String alarmRead(String alarmNo, HttpSession session) {
    	  int result = service.readAlarm(alarmNo);
    	  
    	  if(result > 0) {
    		Emp loginEmp = (Emp)session.getAttribute("loginEmp");
    		if(loginEmp.getAlarmCount() > 0) {
    			loginEmp.setAlarmCount(loginEmp.getAlarmCount() - 1);
    		}
    	  }
    	  
    	  return String.valueOf(result);
      }
      
      @PostMapping(value="myPage.do", produces="text/html; charset=utf-8")
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
      
      @PostMapping(value="empDevelopPrice.do", produces="text/html; charset=utf-8;")
      @AdminChk
      public String empDevelopPrice(Model model) {
          ArrayList<DevelopPrice> developPrice = service.selectDevelopsPrice();
          
          model.addAttribute("developPrice", new Gson().toJson(developPrice));
          return "emp/empDevelopPrice";
      }
      
      @PostMapping("changePrice.do")
      public String chagePrice(DevelopPrice price, Model model) {
          int result = service.changePrice(price);
          
          if(result < 1) {
              CommonException ex = new CommonException("관리자 변경중 오류 발생");
              ex.setErrorCode("SE001");
              Object msgParam[] = {"가격 설정"};
              ex.setUserMsg(message.getMessage(ex.getErrorCode(), msgParam, Locale.KOREA));
              throw ex;
          }
          
          ArrayList<DevelopPrice> developPrice = service.selectDevelopsPrice();
          
          model.addAttribute("developPrice", new Gson().toJson(developPrice));
          
          return "emp/empDevelopPrice";
      }
      
      //부서장 관리
      @PostMapping(value="deptLeaderApPoint.do", produces="text/html; charset=utf-8;")
      @AdminChk
      public String deptLeaderApPoint(Model model) {
    	  Leader deptLeader = service.selectDeptLeaderList();
    	  model.addAttribute("leaderList", new Gson().toJson(deptLeader.getLeaderList()));
    	  model.addAttribute("empList",deptLeader.getEmpList());
    	  
    	  return "emp/deptReaderApPoint";
      }
      
      //팀장 관리
      @PostMapping(value="teamLeaderApPoint.do", produces="text/html; charset=utf-8;")
      @AdminChk
      public String teamLeaderApPoint(Model model) {
    	  Leader teamLeader = service.selectTeamLeaderList();
    	  model.addAttribute("leaderList", new Gson().toJson(teamLeader.getLeaderList()));
    	  model.addAttribute("empList",teamLeader.getEmpList());
    	  
    	  return "emp/teamReaderApPoint";
      }
      
      
      @PostMapping(value="changeLeader.do", produces="application/json; charset=utf-8")
      @ResponseBody
      public String changeLeader(Emp emp) {
    	  int result = service.chageLeader(emp);
    	  
    	  return String.valueOf(result);
      }
      
      @PostMapping(value="changeTeamLeader.do", produces="application/json; charset=utf-8")
      @ResponseBody
      public String changeTeamLeader(Emp emp) {
    	  int result = service.chageTeamLeader(emp);
    	  
    	  return String.valueOf(result);
      }
      
      @PostMapping(value="empCheck.do", produces="text/html; charset=utf-8;")
      @AdminChk
      public String empCheck(Model model,String yearMonth) {
    	  DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMM");
    	  YearMonth yearMonthDate = YearMonth.parse(yearMonth, formatter);
    	  
    	  LocalDate newDate = yearMonthDate.atDay(1);
    	  ArrayList<Emp> empList = service.empCheckMonth(yearMonth);
    	  model.addAttribute("date", newDate);
    	  model.addAttribute("empList", empList);
    	  model.addAttribute("empListJson", new Gson().toJson(empList));
    	  
    	  return "emp/empCheck";
      }
      
      //출퇴근 기록 엑셀 출력
      @GetMapping(value="empCheckExport.do")
      public void empCheckExport(String year, String month,String empList,  HttpServletResponse response){
			try {
				ObjectMapper objectMapper = new ObjectMapper();
				ArrayList<Emp> emps = objectMapper.readValue(empList, new TypeReference<ArrayList<Emp>>() {
				});

				  DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMM");
		    	  YearMonth yearMonthDate = YearMonth.parse(String.format("%d%02d", Integer.parseInt(year),Integer.parseInt(month)), formatter);
		    	  
		    	  LocalDate newDate = yearMonthDate.atDay(1);
		    	  
		    	
				
				// ExcelDown시작
				Workbook workbook = new HSSFWorkbook();

				// 시트생성

				Sheet sheet = workbook.createSheet(String.format("%s년 %s월 %s", year, month,"출,퇴근 관리"));

				sheet.setDefaultColumnWidth((short)15);
				sheet.setDefaultRowHeightInPoints(20);
				// 행,열,열번호

				Row row = null;

				Cell cell = null;

				int rowNo = 0;

				// 테이블헤더용스타일

				CellStyle valueStyle = workbook.createCellStyle();
				
				valueStyle.setBorderTop(BorderStyle.THIN);

				valueStyle.setBorderBottom(BorderStyle.THIN);

				valueStyle.setBorderLeft(BorderStyle.THIN);

				valueStyle.setBorderRight(BorderStyle.THIN);

				valueStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
				
				valueStyle.setVerticalAlignment(VerticalAlignment.CENTER);
				
				valueStyle.setAlignment(HorizontalAlignment.CENTER);
				
				Font valuefont = workbook.createFont();
				valuefont.setFontHeightInPoints((short) 12);
				valueStyle.setFont(valuefont);
				
				valueStyle.setFillForegroundColor(HSSFColorPredefined.WHITE.getIndex()); //흰색 배경
				
				
				CellStyle headStyle = workbook.createCellStyle();

				// 가는경계선을가집니다.

				headStyle.setBorderTop(BorderStyle.THIN);

				headStyle.setBorderBottom(BorderStyle.THIN);

				headStyle.setBorderLeft(BorderStyle.THIN);

				headStyle.setBorderRight(BorderStyle.THIN);


				headStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
				
				headStyle.setVerticalAlignment(VerticalAlignment.CENTER);
				
				headStyle.setAlignment(HorizontalAlignment.CENTER);
				Font headfont = workbook.createFont();
				headfont.setFontHeightInPoints((short) 15);
				headStyle.setFont(headfont);			
				headStyle.setFillForegroundColor(HSSFColorPredefined.GREY_40_PERCENT.getIndex()); //회색
				
				CellStyle weekendStyle = workbook.createCellStyle();
				
				weekendStyle.setBorderTop(BorderStyle.THIN);

				weekendStyle.setBorderBottom(BorderStyle.THIN);

				weekendStyle.setBorderLeft(BorderStyle.THIN);

				weekendStyle.setBorderRight(BorderStyle.THIN);

				weekendStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
				
				weekendStyle.setVerticalAlignment(VerticalAlignment.CENTER);
				
				weekendStyle.setAlignment(HorizontalAlignment.CENTER);
				
				 Font weekendfont = workbook.createFont();
				 weekendfont.setColor(HSSFColor.HSSFColorPredefined.WHITE.getIndex());
				 weekendfont.setFontHeightInPoints((short) 15);
			    weekendStyle.setFont(weekendfont);				
				weekendStyle.setFillForegroundColor(HSSFColorPredefined.RED.getIndex()); //빨간 배경
				

				CellStyle bodyStyle = workbook.createCellStyle();

				bodyStyle.setBorderTop(BorderStyle.THIN);

				bodyStyle.setBorderBottom(BorderStyle.THIN);

				bodyStyle.setBorderLeft(BorderStyle.THIN);

				bodyStyle.setBorderRight(BorderStyle.THIN);

				row = sheet.createRow(rowNo++);
				cell = row.createCell(0);
				cell.setCellStyle(valueStyle);
				cell.setCellValue(String.format("%s년 %s월 %s", year, month,"출,퇴근 관리"));
				sheet.addMergedRegion(new CellRangeAddress( 0, 1, 0, 8));
				// 헤더명설정
				
				rowNo +=3;
				row = sheet.createRow(rowNo++);
				
				sheet.addMergedRegion(new CellRangeAddress( 4, 5, 0, 0));
				
				cell = row.createCell(0);
				cell.setCellStyle(valueStyle);
				cell.setCellValue("이름");
				int firstCol = 1;
				int lastCol = 3;
				for(int i =1; i <= newDate.lengthOfMonth(); i++) {
					
					cell = row.createCell(firstCol);
					sheet.addMergedRegion(new CellRangeAddress( 4, 4, firstCol ,lastCol));
					firstCol = lastCol + 1;
					lastCol = lastCol + 3;
					
					if(newDate.withDayOfMonth(i).getDayOfWeek().getValue() == 6 || newDate.withDayOfMonth(i).getDayOfWeek().getValue() == 7) {
						cell.setCellStyle(weekendStyle);
					}else {
						cell.setCellStyle(headStyle);
					}
					
					
					cell.setCellValue(i);
		    	 }
				
				
				cell = row.createCell(lastCol-3);
				cell.setCellStyle(headStyle);
				
				
				row = sheet.createRow(rowNo++);
				
				int subHeaderCol = 1;
				for(int i =1; i <= newDate.lengthOfMonth(); i++) {
					
					cell = row.createCell(subHeaderCol++);		
					cell.setCellStyle(headStyle);
					cell.setCellValue("출근");
					
					cell = row.createCell(subHeaderCol++);
					cell.setCellStyle(headStyle);
					cell.setCellValue("퇴근");
					
					cell = row.createCell(subHeaderCol++);
					cell.setCellStyle(headStyle);
					cell.setCellValue("비고");
				}
					
				
				
				for(Emp emp : emps) {
					row = sheet.createRow(rowNo++);
					cell = row.createCell(0);
					cell.setCellStyle(valueStyle);
					cell.setCellValue(emp.getEmpName());
					
					int empValueCol = 1;
					for(int i =1; i <= newDate.lengthOfMonth(); i++) {
						boolean valueChk = false;
						for(Check check : emp.getCheckList()) {
							int day = Integer.parseInt(String.format("%02d", i));
							int checkDay = Integer.parseInt(check.getDay().substring(6,8));
							if(day == checkDay) {
								valueChk = true;
								
								cell = row.createCell(empValueCol++);
								cell.setCellStyle(valueStyle);
								cell.setCellValue(getTimeFormat(check.getCheckIn()));
								
								cell = row.createCell(empValueCol++);
								cell.setCellStyle(valueStyle);
								cell.setCellValue(getTimeFormat(check.getCheckOut()));
								
								cell = row.createCell(empValueCol++);
								cell.setCellStyle(valueStyle);
								cell.setCellValue(check.getCheckNote());
							}
						}
						if(!valueChk) {
							cell = row.createCell(empValueCol++);
							cell.setCellStyle(valueStyle);
							
							cell = row.createCell(empValueCol++);
							cell.setCellStyle(valueStyle);
							
							cell = row.createCell(empValueCol++);
							cell.setCellStyle(valueStyle);
						}
					
					}
				}

				
				// 컨텐츠타입과파일명지정
				response.setContentType("ms-vnd/excel");
				String fileName = java.net.URLEncoder.encode(String.format("%s년 %s월 %s", year, month,"출,퇴근 관리.xls"), "UTF8");
				fileName = fileName.replaceAll("\\+", "%20");
				response.setHeader("Content-Disposition",
						"attachment;filename=" + fileName);

				// 엑셀출력

				workbook.write(response.getOutputStream());

				workbook.close();

			} catch (Exception e) {

				e.printStackTrace();

			}
		}
      
      private String getTimeFormat(String value) {
    	  if(value != null) {
	    	  String hour = value.substring(0,2);
	    	  String min = value.substring(2,4);
	    	  String sec = value.substring(4,6);
	    	  
	    	  
	    	  return String.format("%s:%s:%s", hour,min,sec);
    	  }else {
    		  return null;
    	  }
      }
      
      @PostMapping(value="salesManager", produces="text/html; charset=utf-8")
      @AdminChk
      public String salesManager(String yearMonth, Model model) {
    	 
    	  SalesSpending list = service.selectSalesManager(yearMonth);
    	  
    	  DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMM");
    	  YearMonth yearMonthDate = YearMonth.parse(yearMonth, formatter);
    	  
    	  LocalDate newDate = yearMonthDate.atDay(1);
    	  
    	  model.addAttribute("year", newDate.getYear());
    	  model.addAttribute("month", newDate.getMonthValue());
    	  model.addAttribute("salesSpendingList", list);
    	  model.addAttribute("salesSpendingListJson", new Gson().toJson(list));
    	  
    	  return "emp/salesManager";
      }
      
      @GetMapping(value="salesManagerExport.do")
      public void salesManagerExport(String year, String month,String salesManager,  HttpServletResponse response){
    	  System.out.println(salesManager);
			try {
				ObjectMapper objectMapper = new ObjectMapper();
				SalesSpending salesSpending = objectMapper.readValue(salesManager, new TypeReference<SalesSpending>() {
				});

				// ExcelDown시작
				Workbook workbook = new HSSFWorkbook();

				// 시트생성

				Sheet sheet = workbook.createSheet(String.format("%s년 %s월 %s", year, month,"매출 및 지출 관리"));

				sheet.setDefaultColumnWidth((short)15);
				sheet.setDefaultRowHeightInPoints(20);
				// 행,열,열번호

				Row row = null;

				Cell cell = null;

				int rowNo = 0;

				 // 값 스타일
			    CellStyle valueStyle = workbook.createCellStyle();
			    valueStyle.setBorderTop(BorderStyle.THIN);
			    valueStyle.setBorderBottom(BorderStyle.THIN);
			    valueStyle.setBorderLeft(BorderStyle.THIN);
			    valueStyle.setBorderRight(BorderStyle.THIN);
			    valueStyle.setVerticalAlignment(VerticalAlignment.CENTER);
			    valueStyle.setAlignment(HorizontalAlignment.CENTER);
			    valueStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
			    valueStyle.setFillForegroundColor(HSSFColorPredefined.WHITE.getIndex());
			    Font valueFont = workbook.createFont();
			    valueFont.setFontHeightInPoints((short) 12);
			    valueStyle.setFont(valueFont);

			    //메뉴 스타일
			    CellStyle menuStyle = workbook.createCellStyle();
			    menuStyle.cloneStyleFrom(valueStyle);
			    menuStyle.setFillForegroundColor(HSSFColorPredefined.GREY_40_PERCENT.getIndex());
			    Font menuFont = workbook.createFont();
			    menuFont.setFontHeightInPoints((short) 18);
			    menuStyle.setFont(menuFont);
			    
			    //헤더 스타일
			    CellStyle headStyle = workbook.createCellStyle();
			    headStyle.cloneStyleFrom(valueStyle);
			    headStyle.setFillForegroundColor(HSSFColorPredefined.WHITE.getIndex());
			    Font headFont = workbook.createFont();
			    headFont.setFontHeightInPoints((short) 15);
			    headStyle.setFont(headFont);

			  

				row = sheet.createRow(rowNo++);
				cell = row.createCell(0);
				cell.setCellStyle(valueStyle);
				cell.setCellValue(String.format("%s년 %s월 %s", year, month,"매출 및 지출 관리"));
				sheet.addMergedRegion(new CellRangeAddress( 0, 1, 0, 8));
				// 헤더명설정
				
				rowNo +=3;
				row = sheet.createRow(rowNo++);
				sheet.addMergedRegion(new CellRangeAddress( 4, 5, 1, 3));
				
				cell = row.createCell(1);
				cell.setCellStyle(menuStyle);
				cell.setCellValue("매출");
				cell = row.createCell(2);
				cell.setCellStyle(menuStyle);
				cell = row.createCell(3);
				cell.setCellStyle(menuStyle);
				
				
				sheet.addMergedRegion(new CellRangeAddress( 4, 5, 4, 6));
				cell = row.createCell(4);
				cell.setCellStyle(menuStyle);
				cell.setCellValue("지출");
				cell = row.createCell(5);
				cell.setCellStyle(menuStyle);
				cell = row.createCell(6);
				cell.setCellStyle(menuStyle);
				
				rowNo++;
				row = sheet.createRow(rowNo++);
				
				String[] headers = { "매출일", "거래일", "내역", "지출일", "거래일", "내역" };
				for (int i = 0; i < headers.length; i++) {
					cell = row.createCell(i+1);
					cell.setCellStyle(headStyle);
					cell.setCellValue(headers[i]);
				}
				
				
				
				int totalCount = Math.max(salesSpending.getSalesList().size(), salesSpending.getSpendingList().size());

				for (int i = 0; i < totalCount; i++) {
				    Sales sales = null;
				    Spending spending = null;

				    // salesList의 범위를 벗어나지 않는 경우에만 가져오기
				    if (i < salesSpending.getSalesList().size()) {
				        sales = salesSpending.getSalesList().get(i);
				    }

				    // spendingList의 범위를 벗어나지 않는 경우에만 가져오기
				    if (i < salesSpending.getSpendingList().size()) {
				        spending = salesSpending.getSpendingList().get(i);
				    }

				    row = sheet.createRow(rowNo++);
				    int col = 1;

				    // Sales 데이터 처리
				    if (sales != null) {
				        cell = row.createCell(col++);
				        cell.setCellStyle(valueStyle);
				        cell.setCellValue(sales.getSalesDay());

				        cell = row.createCell(col++);
				        cell.setCellStyle(valueStyle);
				        cell.setCellValue(sales.getSalesCost());

				        cell = row.createCell(col++);
				        cell.setCellStyle(valueStyle);
				        cell.setCellValue(sales.getSalesContent());
				    } else {
				        // Sales 데이터가 없는 경우 빈 셀 추가
				        cell = row.createCell(col++);
				        cell.setCellStyle(valueStyle);
				        cell = row.createCell(col++);
				        cell.setCellStyle(valueStyle);
				        cell = row.createCell(col++);
				        cell.setCellStyle(valueStyle);
				    }

				    // Spending 데이터 처리
				    if (spending != null) {
				        cell = row.createCell(col++);
				        cell.setCellStyle(valueStyle);
				        cell.setCellValue(spending.getSpendingDay());

				        cell = row.createCell(col++);
				        cell.setCellStyle(valueStyle);
				        cell.setCellValue(spending.getSpendingCost());

				        cell = row.createCell(col++);
				        cell.setCellStyle(valueStyle);
				        cell.setCellValue(spending.getSpendingContent());
				    } else {
				        // Spending 데이터가 없는 경우 빈 셀 추가
				        cell = row.createCell(col++);
				        cell.setCellStyle(valueStyle);
				        cell = row.createCell(col++);
				        cell.setCellStyle(valueStyle);
				        cell = row.createCell(col++);
				        cell.setCellStyle(valueStyle);
				    }
				}

				
				// 컨텐츠타입과파일명지정
				response.setContentType("ms-vnd/excel");
				String fileName = java.net.URLEncoder.encode(String.format("%s년 %s월 %s", year, month,"매출 및 지출 관리.xls"), "UTF8");
				fileName = fileName.replaceAll("\\+", "%20");
				response.setHeader("Content-Disposition",
						"attachment;filename=" + fileName);

				// 엑셀출력

				workbook.write(response.getOutputStream());

				workbook.close();

			} catch (Exception e) {

				e.printStackTrace();

			}
		}
      
      
      @PostMapping(value="salesHistory.do")
      public String salesHistory(String empCode, Model model) {
    	  ArrayList<Salary> salaryList = service.selectSalaryHisotry(empCode);
    	  
    	  model.addAttribute("salaryList", salaryList);
    	  return "emp/salesHistory";
      }
      
      @PostMapping(value="disciplinary.do")
      public String disciplinary(Emp emp, Model model) {
    	  ArrayList<HashMap<String, String>> typeList = service.selectDisciplinary();
    	  
    	  model.addAttribute("typeList", typeList);
    	  model.addAttribute("empCode", emp.getEmpCode());
    	  model.addAttribute("empName", emp.getEmpName());
    	  
    	  return "emp/disciplinary";
      }
      
      @PostMapping(value="doDisciplinary.do", produces="application/json; charset=utf-8")
      @ResponseBody
      public String doDisciplinary(Disciplinary disciplinary) {
    	  System.out.println(disciplinary.toString());
    	  
    	  int result = service.doDisciplinary(disciplinary);
    	  
    	  return String.valueOf(result);
      }
      
      @PostMapping(value="salarySendFrm.do", produces="text/html; charset=utf-8")
      @AdminChk
      public String salarySendFrm(Model model) {
    	  ArrayList<Emp> list = service.selectEmpSalaryList();
    	  
    	  System.out.println(list.toString());
    	  
    	  model.addAttribute("empList", list);
    	  
    	  return "emp/salarySend";
      }
      
      
      @PostMapping(value="sendSalry.do", produces="application/json; charset=utf-8")
      @ResponseBody
      public String sendSalary(Emp emp) {
    	  int result = service.sendMsg(emp);
    	  
    	  return String.valueOf(result);
      }
      
      @PostMapping(value="findIdFrm.do")
      @NoLoginChk
      public String findIdFrm() {
    	  
    	  return "emp/findIdFrm";
      }
      
      
      @PostMapping(value="chkPhoneToId.do", produces="application/json; charset=utf-8")
      @NoLoginChk
      @ResponseBody
      public String chkPhoneToId(String phone) {
    	  int result = service.selectPhoneToId(phone);
    	  
    	  return String.valueOf(result);
      }
      
      @PostMapping(value="findPwFrm.do")
      @NoLoginChk
      public String findPwFrm() {
    	  
    	  return "emp/findPwFrm";
      }
      
      
      @PostMapping(value="chkIdSendPhone.do", produces="application/json; charset=utf-8")
      @NoLoginChk
      @ResponseBody
      public String chkIdSendPhone(String empId) {
    	  
    	  String resultCode = service.chkIdSendCodeMsg(empId);
    	  
    	  return new Gson().toJson(resultCode);
      }
      
      
      @PostMapping(value="codeChk.do")
      @NoLoginChk
      public String codeChk(String code, String empId, Model model) {
    	  
    	  model.addAttribute("code", code);
    	  model.addAttribute("empId", empId);
    	  
    	  return "emp/codeChk";
      }
      
      @PostMapping(value="changePwFrm.do")
      @NoLoginChk
      public String changePwFrm(String empId, Model model) {
    	  
    	  model.addAttribute("empId", empId);
    	  return "emp/changePw";
      }
      
      @PostMapping(value="changePw.do", produces="application/json; charset=utf-8")
      @NoLoginChk
      @ResponseBody
      public String changePw(String empId, String newPw) {
    	  int result = service.changePw(empId, newPw);
    	  
    	  
    	  return String.valueOf(result);
      }
      
      
     
}
