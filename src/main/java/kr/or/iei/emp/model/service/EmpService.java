package kr.or.iei.emp.model.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import org.apache.commons.lang.time.DateUtils;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.iei.common.SMS;
import kr.or.iei.document.model.vo.Document;
import kr.or.iei.document.model.vo.Sales;
import kr.or.iei.document.model.vo.Spending;
import kr.or.iei.emp.model.dao.EmpDao;
import kr.or.iei.emp.model.vo.Alarm;
import kr.or.iei.emp.model.vo.AlarmPaging;
import kr.or.iei.emp.model.vo.Chat;
import kr.or.iei.emp.model.vo.ChatGroup;
import kr.or.iei.emp.model.vo.Check;
import kr.or.iei.emp.model.vo.Commute;
import kr.or.iei.emp.model.vo.DailyReport;
import kr.or.iei.emp.model.vo.Dept;
import kr.or.iei.emp.model.vo.DevelopPrice;
import kr.or.iei.emp.model.vo.Disciplinary;
import kr.or.iei.emp.model.vo.Emp;
import kr.or.iei.emp.model.vo.Leader;
import kr.or.iei.emp.model.vo.Rank;
import kr.or.iei.emp.model.vo.Salary;
import kr.or.iei.emp.model.vo.SalesSpending;
import kr.or.iei.emp.model.vo.Team;
import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.exception.NurigoMessageNotReceivedException;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.service.DefaultMessageService;

@Service("empService")
public class EmpService {

	@Autowired
	@Qualifier("empDao")
	private EmpDao dao;
	
	
	//매일 자정에 로직 수행
	@Scheduled(cron = "0 0 0 * * *")
//	@Scheduled(fixedRate = 1000)
	@Transactional
	public void disciplinaryCheckSchelduler() {
		//징게 목록에서 완료가 되지 않은 사원의 리스트
	    ArrayList<Disciplinary> list = (ArrayList<Disciplinary>)dao.selectDisciplinaryCheck();
	    
	    
	    for(Disciplinary disciplinary : list) {
	    	//징계 받기전 salary 가져오기
	    	String salary = dao.selectSalaryCheck(disciplinary.getEmpCode());
	    	
	    	HashMap<String, String> map = new HashMap<String, String>();
	    	map.put("empCode", disciplinary.getEmpCode());
	    	map.put("salary", salary);
	    	
	    	//징계받기전 salary로 변경
	    	int result = dao.returnDisciplinarySalary(map);
	    	
	    	if(result > 0) {
	    		//징계 완료 처리
	    		result = dao.updateComplateDisciplinary(disciplinary);
	    	}
	    }
	}

	public Emp login(Emp emp) {
		Emp loginEmp = dao.login(emp);
		 if(loginEmp!=null) {
				boolean checkPw=BCrypt.checkpw(emp.getEmpPw(), loginEmp.getEmpPw());
				if(checkPw) {
				loginEmp.setEmpPw(emp.getEmpPw());
					if (loginEmp.getTeamCode()!=null){
						if (loginEmp.getTeamCode().equals("G1")) {
							int adminChk = dao.selectAdmin(loginEmp.getEmpCode());
							
							if (adminChk > 0) {
								loginEmp.setAdmin(true);
							}
						}
					}
					int alaramCount = dao.selectAlarmCount(loginEmp.getEmpCode());
					loginEmp.setAlarmCount(alaramCount);
					
				 }else {
					return null; 
				 }
		 }
		 return loginEmp;
	}

	public int idCheck(String empId) {
		// TODO Auto-generated method stub
		
		return dao.idCheck(empId);
	}

	public int join(Emp emp) {
		// TODO Auto-generated method stub
		return dao.join(emp);
	}

	public ArrayList<Emp> empWaitList() {
		return (ArrayList<Emp>) dao.empWaitList();
	}
	
	public ArrayList<Dept> loadDept() {
		return (ArrayList<Dept>)dao.loadDept();
	}

	public ArrayList<Team> loadTeam() {
		return (ArrayList<Team>)dao.loadTeam();
	}

	public ArrayList<Rank> loadRank() {
		return (ArrayList<Rank>)dao.loadRank();
	}

	@Transactional
	public int approval(Emp emp) {
		int result = dao.approvalEmp(emp);
		
		if(result > 0) {
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("empCode", emp.getEmpCode());
			map.put("salary", emp.getSalary());
			
			result = dao.insertSalary(map);
			
			if(result > 0) {
				
				result = dao.insertVacation(emp.getEmpCode());
				if(result > 0) {
					result = dao.deleteWait(emp.getEmpCode());
				}
			}
		}
		return result;
	}

	@Transactional
	public void chkAdmin() {
		int result = dao.idCheck("admin");
		if(result == 0) {
			String pw = BCrypt.hashpw("1234", BCrypt.gensalt());
			Emp emp = new Emp();
			emp.setEmpId("admin");
			emp.setEmpPw(pw);
			emp.setTeamCode("G1");
			emp.setDeptCode("GD");
			emp.setRankCode("J6");
			emp.setEmpName("배재현");
			emp.setSalary("50000000");
			emp.setEmpPhone("01012341234");
			emp.setEmpRetire("n");
			result = dao.insertAdmin(emp);
			
			if(result > 0) {
				result = dao.insertLeader(emp);
				if(result > 0) {
					String empCode = dao.selectAdminEmpCode();
					HashMap<String, String> map = new HashMap<String, String>();
					map.put("empCode", empCode);
					map.put("salary", emp.getSalary());
					result = dao.insertSalary(map);
					if(result > 0) {
						result = dao.insertVacation(empCode);
					}
				}
			}
			
		}
	}

	public ArrayList<Emp> chatEmpList(String empCode) {
        return (ArrayList<Emp>)dao.chatEmpList(empCode);
	}
	
	@Transactional
	public ChatGroup selectChatList(String fromEmpCode, String toEmpCode) {
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("from", fromEmpCode);
		map.put("to", toEmpCode);
		
		ChatGroup chatGroup = new ChatGroup(); 
		String groupNo = dao.selectChatGroup(map);
		if(groupNo == null) {
			groupNo = dao.selectGroupNo();
			chatGroup.setGroupNo(groupNo);
			for(String key : map.keySet()) {
				HashMap<String, String> groupMap = new HashMap<String, String>();
				groupMap.put("groupNo", groupNo);
				groupMap.put("empCode", map.get(key));
				int result = dao.insertChatGroup(groupMap);
				if(result < 1) {
					break;
				}
			}
		}else {
			  HashMap<String,String> groupMap = new HashMap<String, String>();
	            groupMap.put("empCode", fromEmpCode);
	            groupMap.put("groupNo", groupNo);
	            int result = dao.chatResetReadCount(groupMap);
	            if(result > 0) {
	                ArrayList<Chat> chatList = new ArrayList<Chat>();
	                chatList = (ArrayList<Chat>)dao.selectChatList(groupNo);
	                
	                chatGroup.setGroupNo(groupNo);
	                chatGroup.setChatList(chatList);
	            }
	        }
		
		return chatGroup;
	}

	
	 public ArrayList<Document> docMain(String empCode) {
		 
	        return (ArrayList<Document>) dao.docMain(empCode);
	    }


	public int insertChat(Chat chat) {
		return dao.insertChat(chat);
	}

	public ArrayList<Emp> empManagerList() {
		return (ArrayList<Emp>)dao.empManagerList();
	}

	@Transactional
	public int changeEmp(Emp emp) {
		int result = dao.adminUpdateEmp(emp);
		System.out.println(result);
		if(result > 0) {
			result = dao.updateVacation(emp);
			System.out.println(result);
		}
		
		return result;
	}

	public int reportCreate(DailyReport daily) {
		int result = dao.reportCreate(daily);
		return result;
	}
	
	 public void chatAddReadCount(Chat chat) {
	        
	        dao.chatAddReadCount(chat);
	    }

	public DailyReport dailyReportUpdate(String empCode) {
		
		return dao.dailyReportUpdate(empCode);
	}

	public boolean empCheckReport(String empCode) {
		
		return dao.empCheckReport(empCode) > 0;
	}
	//db에 update
	public int dailyReportUpd(DailyReport dailyReport) {
		
		return dao.dailyReportUpd(dailyReport);
	}

	public AlarmPaging loadAlarmList(AlarmPaging alarmNavi) {
		
		AlarmPaging paging = new AlarmPaging();
		
		int totalCount = dao.selectAlarmListTotalCount(alarmNavi.getEmpCode());
		paging.setTotalCount(totalCount);
		
		if(totalCount > 0) {
			ArrayList<Alarm> list = (ArrayList<Alarm>)dao.loadAlarmList(alarmNavi);
			paging.setAlarmList(list);
			paging.setStartCount(alarmNavi.getStartCount());
			paging.setEndCount(alarmNavi.getEndCount());
		}
		
		return paging;
	}

	public int readAlarm(String alarmNo) {
		return dao.readAlarm(alarmNo);
	}

	public int onWork(String empCode) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		Date date = new Date();
		String toDay = sdf.format(date);
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("empCode", empCode);
		map.put("day", toDay);
		
		int result = dao.chkOnWorkToday(map);
		if(result > 0) {
			return -1;
		}else {
			result = dao.insertOnWork(empCode);
		}
		
		
		return result;
	}


	public int offWork(String empCode) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		Date date = new Date();
		String toDay = sdf.format(date);

		HashMap<String, String> map = new HashMap<String, String>();
		map.put("empCode", empCode);
		map.put("day", toDay);

		Commute commute = dao.selectToday(map);
		int result = 0;
		if (commute == null) {
			return -1;
		} else {
			result = dao.updateOffWork(map);
		}

		return result;
	}

	public Commute selectCommute(String empCode) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		Date date = new Date();
		String toDay = sdf.format(date);

		HashMap<String, String> map = new HashMap<String, String>();
		map.put("empCode", empCode);
		map.put("day", toDay);

		return dao.selectToday(map);
	}

	public Emp updateEmp(Emp emp) {
		int result = dao.updateEmp(emp);

		Emp loginEmp = null;
		if (result > 0) {
			loginEmp = dao.selectEmp(emp.getEmpCode());
		}
		return loginEmp;
	}

	public int updatePw(Emp emp, String oldPw, String newPw) {
		boolean checkPw = BCrypt.checkpw(oldPw, emp.getEmpPw());
		int result = 0;

		if (checkPw) {
			String newEmpPw = BCrypt.hashpw(newPw, BCrypt.gensalt());
			emp.setEmpPw(newEmpPw);
			result = dao.updatePw(emp);
		} else {
			result = -1;
		}
		return result;
	}

	public ArrayList<DevelopPrice> selectDevelopsPrice() {
		return ( ArrayList<DevelopPrice>)dao.selectDevelopsPrice();
	}

	public int changePrice(DevelopPrice price) {
		System.out.println(price);
		int result =  dao.selectDevelopPriceChk(price);
		if(result > 0) {
			result = dao.updateDevelopPrice(price);
		}else {
			result = dao.insertDevelopPrice(price);
		}
		return 1;
	}

	public Leader selectDeptLeaderList() {
		ArrayList<Emp> leaderList = (ArrayList<Emp>)dao.selectDeptLeaderList();
		ArrayList<Emp> empList = (ArrayList<Emp>)dao.selectEmpList();
		
		return new Leader(leaderList, empList);
	}
	
	public Leader selectTeamLeaderList() {
		ArrayList<Emp> leaderList = (ArrayList<Emp>)dao.selectTeamLeaderList();
		ArrayList<Emp> empList = (ArrayList<Emp>)dao.selectEmpList();
		
		return new Leader(leaderList, empList);
	}

	public int chageLeader(Emp emp) {
		int result = dao.selectLeader(emp);
		
		if(result > 0) {
			result = dao.updateLeader(emp);
		}else {
			result = dao.insertLeader(emp);
		}
		
		return result;
	}
	
	public int chageTeamLeader(Emp emp) {
		int result = dao.selectTeamLeader(emp);
		
		if(result > 0) {
			result = dao.updateTeamLeader(emp);
		}else {
			result = dao.insertTeamLeader(emp);
		}
		
		return result;
	}

	public ArrayList<Emp> empCheckMonth(String yearMonth) {
		ArrayList<Emp> empList = (ArrayList<Emp>)dao.selectEmpList();
		for(int i = empList.size()-1; i >= 0; i--) {
				//입사년월
				int empYearMonth = Integer.parseInt(empList.get(i).getEmpDate().substring(0, 7).replace("-", ""));
				//찾으려는 출퇴근 기록부 년월 보다 입사일이 늦으면 찾지 않음
		        if (Integer.parseInt(yearMonth) < empYearMonth) {
		        	empList.remove(i);
		        	continue;
		        } 
			
			HashMap<String,String> map = new HashMap<String, String>();
			map.put("empCode", empList.get(i).getEmpCode());
			map.put("yearMonth", yearMonth);
			//해당 사원의 해당월의 기록 가져오기
			ArrayList<Check> checkList = (ArrayList<Check>)dao.empCheckMonth(map);
			empList.get(i).setCheckList(checkList);
		}
		
		return empList;
	}

	public SalesSpending selectSalesManager(String yearMonth) {
		SalesSpending salesSpending = new SalesSpending();
		ArrayList<Sales> salesList = (ArrayList<Sales>)dao.selectSalesMonth(yearMonth);
		ArrayList<Spending> spendingList = (ArrayList<Spending>)dao.selectSpendingMonth(yearMonth);
		salesSpending.setSalesList(salesList);
		salesSpending.setSpendingList(spendingList);
		
		return salesSpending;
	}

	public ArrayList<Salary> selectSalaryHisotry(String empCode) {
		return (ArrayList<Salary>)dao.selectSalaryHisotry(empCode);
	}

	public ArrayList<HashMap<String, String>> selectDisciplinary() {
		return (ArrayList<HashMap<String, String>>)dao.selectDisciplinary();
	}
	
	@Transactional
	public int doDisciplinary(Disciplinary disciplinary) {
		int result = 0;
		
		switch (disciplinary.getTypeCode()) {
			case "su":
				result = dao.insertDisciplinarySu(disciplinary);
				
				int totalDay = Integer.parseInt(disciplinary.getValue());
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				Date day = new Date();
				for(int i = 1; i < totalDay; i++) {
					day = DateUtils.addDays(day, 1);
					String dayValue = sdf.format(day);
					
					HashMap<String, String> map = new HashMap<String, String>();
					map.put("empCode", disciplinary.getEmpCode());
					map.put("day", dayValue);
					map.put("value", "정직");
					
					result = dao.insertCheckDisciplinary(map);
					if(result < 0) {
						break;
					}
				}
				break;
	
			case "cu":
				result = dao.insertDisciplinaryCu(disciplinary);
				
				if(result > 0) {
					result = dao.updateDisciplinarySalary(disciplinary);
				}
				
				break;
	
			case "di":
				result = dao.insertDisciplinaryDi(disciplinary);
				
				if(result > 0) {
					result = dao.updateEmpDi(disciplinary.getEmpCode());
				}
				break;

		default:
			break;
		}
		
		return result;
	}

	public ArrayList<Emp> selectEmpSalaryList() {
		return (ArrayList<Emp>) dao.selectEmpSalaryList();
	}

	public int sendMsg(Emp emp) {
		int result = 0;
		
		DefaultMessageService messageService =  NurigoApp.INSTANCE.initialize(SMS.apiKey, SMS.apiSecretKey, SMS.smsUrl);
		
		Message message = new Message();
		message.setFrom(SMS.SendPhone);
		message.setTo(emp.getEmpPhone());
		
		String msg = emp.getEmpName() + "님 월급 " +emp.getSalary() + "원이 입금 되었습니다";
		
		message.setText(msg);
		
		try {
		  // send 메소드로 ArrayList<Message> 객체를 넣어도 동작합니다!
		  messageService.send(message);
		  result = 1;
		} catch (NurigoMessageNotReceivedException exception) {
		  // 발송에 실패한 메시지 목록을 확인할 수 있습니다!
		  System.out.println(exception.getFailedMessageList());
		  System.out.println(exception.getMessage());
		} catch (Exception exception) {
		  System.out.println(exception.getMessage());
		}
		
		return result;
	}

	public int updateSalary(Emp emp) {
		return dao.updateSalary(emp);
	}

}
