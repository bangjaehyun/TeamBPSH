package kr.or.iei.emp.model.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.iei.document.model.vo.Document;
import kr.or.iei.emp.model.dao.EmpDao;
import kr.or.iei.emp.model.vo.Alarm;
import kr.or.iei.emp.model.vo.Chat;
import kr.or.iei.emp.model.vo.ChatGroup;
import kr.or.iei.emp.model.vo.Commute;
import kr.or.iei.emp.model.vo.DailyReport;
import kr.or.iei.emp.model.vo.Dept;
import kr.or.iei.emp.model.vo.DeptLeader;
import kr.or.iei.emp.model.vo.DevelopPrice;
import kr.or.iei.emp.model.vo.Emp;
import kr.or.iei.emp.model.vo.Rank;
import kr.or.iei.emp.model.vo.Team;

@Service("empService")
public class EmpService {

	@Autowired
	@Qualifier("empDao")
	private EmpDao dao;

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

	public void chkAdmin() {
		int result = dao.idCheck("admin");
		if(result == 0) {
			String pw = BCrypt.hashpw("1234", BCrypt.gensalt());
			Emp emp = new Emp();
			emp.setEmpId("admin");
			emp.setEmpPw(pw);
			emp.setTeamCode("G1");
			emp.setRankCode("J6");
			emp.setEmpName("배재현");
			emp.setEmpPhone("01012341234");
			emp.setEmpRetire("n");
			result = dao.insertAdmin(emp);
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
			result = dao.updateSalary(emp);
			System.out.println(result);
			if(result > 0) {
				result = dao.updateVacation(emp);
				System.out.println(result);
			}
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

	public ArrayList<Alarm> loadAlarmList(String empCode) {
		return (ArrayList<Alarm>)dao.loadAlarmList(empCode);
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

	public DeptLeader selectDeptLeaderList() {
		ArrayList<Emp> leaderList = (ArrayList<Emp>)dao.selectDeptLeaderList();
		ArrayList<Emp> empList = (ArrayList<Emp>)dao.selectEmpList();
		
		return new DeptLeader(leaderList, empList);
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

}
