package kr.or.iei.emp.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mindrot.jbcrypt.BCrypt;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import kr.or.iei.document.model.vo.Document;
import kr.or.iei.document.model.vo.Sales;
import kr.or.iei.document.model.vo.Spending;
import kr.or.iei.emp.model.vo.Alarm;
import kr.or.iei.emp.model.vo.AlarmPaging;
import kr.or.iei.emp.model.vo.Chat;
import kr.or.iei.emp.model.vo.Check;
import kr.or.iei.emp.model.vo.Commute;
import kr.or.iei.emp.model.vo.DailyReport;
import kr.or.iei.emp.model.vo.Dept;
import kr.or.iei.emp.model.vo.DevelopPrice;
import kr.or.iei.emp.model.vo.Disciplinary;
import kr.or.iei.emp.model.vo.Emp;
import kr.or.iei.emp.model.vo.Rank;
import kr.or.iei.emp.model.vo.Salary;
import kr.or.iei.emp.model.vo.Team;

@Repository("empDao")
public class EmpDao {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSessionTemplate sqlSession;


	public Emp login(Emp emp) {
		return sqlSession.selectOne("emp.loginEmp",emp);
		
	}
		
	public int selectAdmin(String empCode) {
		return sqlSession.selectOne("emp.adminChk",empCode);
	}

	public int idCheck(String empId) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("emp.idCheck", empId);
	}

	public int join(Emp emp) {
		// TODO Auto-generated method stub
		return sqlSession.insert("emp.join",emp);
	}

	public List<Emp> empWaitList() {
		return sqlSession.selectList("emp.empWaitList");
	}
	
	public List<Dept> loadDept() {
		return sqlSession.selectList("emp.deptList");
	}

	public List<Team> loadTeam() {
		return sqlSession.selectList("emp.teamList");
	}

	public List<Rank> loadRank() {
		return sqlSession.selectList("emp.rankList");
	}

	public int approvalEmp(Emp emp) {
		return sqlSession.update("emp.approvalEmp",emp);
	}

	public int insertSalary(HashMap<String, String> map) {
		return sqlSession.insert("emp.insertSalary", map);
	}

	public int deleteWait(String empCode) {
		return sqlSession.delete("emp.deleteWait", empCode);
	}

	public int insertAdmin(Emp emp) {
		return sqlSession.insert("emp.insertAdmin", emp);
	}
	
	 public List<Emp> chatEmpList(String empCode) {
		 	System.out.println(empCode);
	        return sqlSession.selectList("emp.chatEmpList", empCode);
    }

    public String selectChatGroup(HashMap<String, String> map) {
        System.out.println(map);
        return sqlSession.selectOne("emp.selectChatGroup", map);
    }

    public int insertChatGroup(HashMap<String, String> groupMap) {
        return sqlSession.insert("emp.insertChatGroup", groupMap);
    }

    public List<Chat> selectChatList(String groupNo) {
        return sqlSession.selectList("emp.selectChatList", groupNo);
    }


    //main 화면 출력할 메소드
    public List<Document> docMain(String empCode) {
        return sqlSession.selectList("document.docMain",empCode);
    }

	public int insertChat(Chat chat) {
		return sqlSession.insert("emp.insertChat", chat);
	}

	public String selectGroupNo() {
		return sqlSession.selectOne("emp.getGroupNo");
	}

	public List<Emp> empManagerList() {
		return sqlSession.selectList("emp.empManagerList");
	}

	public int insertVacation(String empCode) {
		return sqlSession.insert("emp.insertVacation", empCode);
	}

	public int adminUpdateEmp(Emp emp) {
		return sqlSession.update("emp.adminUpdateEmp", emp);
	}

	public int updateSalary(Emp emp) {
		return sqlSession.update("emp.updateSalary", emp);
	}

	public int updateVacation(Emp emp) {
		return sqlSession.update("emp.updateVacation", emp);
	}
	
	public int reportCreate(DailyReport daily) {
		System.out.println(daily.getEmpCode());
		return sqlSession.insert("emp.reportCreate", daily);
	}

	public void chatAddReadCount(Chat chat) {
	    sqlSession.update("emp.chatAddReadCount", chat);
	}

	public int chatResetReadCount(HashMap<String, String> groupMap) {
	    return sqlSession.update("emp.chatReSetReadCount", groupMap);
	}

	public DailyReport dailyReportUpdate(String empCode) {
		
		return sqlSession.selectOne("emp.dailyReportView",empCode);
	}

	public int empCheckReport(String empCode) {
		
		return sqlSession.selectOne("emp.checkReport",empCode);
	}

	public int dailyReportUpd(DailyReport dailyReport) {
		
		return sqlSession.update("emp.dailyReportUpdate", dailyReport);
	}

	public List<Alarm> loadAlarmList(AlarmPaging alarmPaging) {
		return sqlSession.selectList("emp.loadAlarmList", alarmPaging);
	}

	public int readAlarm(String alarmNo) {
		return sqlSession.update("emp.alarmRead", alarmNo);
	}

	public int chkOnWorkToday(HashMap<String, String> map) {
		return sqlSession.selectOne("emp.chkOnWorkToday", map);
	}

	public int insertOnWork(String empCode) {
		// TODO Auto-generated method stub
		return sqlSession.insert("emp.insertOnWork", empCode);
	}

	public Commute selectToday(HashMap<String, String> map) {
		return sqlSession.selectOne("emp.selectToday", map);
	}

	public int updateOffWork(HashMap<String, String> map) {
		return sqlSession.update("emp.updateOffWork", map);
	}

	public int updateEmp(Emp emp) {
		return sqlSession.update("emp.updateEmp", emp);
	}

	public Emp selectEmp(String empCode) {
		return sqlSession.selectOne("emp.selectEmp", empCode);
	}

	public String selectPw(String empCode) {
		return sqlSession.selectOne("emp.selectPw",empCode);
	}

	public int updatePw(Emp emp) {
		return sqlSession.update("emp.updatePw", emp);
	}

	public List<DevelopPrice> selectDevelopsPrice() {
		return sqlSession.selectList("emp.selectDevelopsPrice");
	}

	public int selectDevelopPriceChk(DevelopPrice price) {
		return sqlSession.selectOne("emp.selectDevelopPriceChk", price);
	}

	public int updateDevelopPrice(DevelopPrice price) {
		return sqlSession.update("emp.updateDevelopPrice", price);
	}

	public int insertDevelopPrice(DevelopPrice price) {
		return sqlSession.insert("emp.insertDevelopPrice", price);
	}

	public List<Emp> selectDeptLeaderList() {
		return sqlSession.selectList("emp.selectDeptLeaderList");
	}
	
	public List<Emp> selectTeamLeaderList() {
		return sqlSession.selectList("emp.selectTeamLeaderList");
	}

	public List<Emp> selectEmpList() {
		return sqlSession.selectList("emp.selectEmpList");
	}

	public int selectLeader(Emp emp) {
		return sqlSession.selectOne("emp.selectLeader", emp);
	}

	public int updateLeader(Emp emp) {
		return sqlSession.update("emp.updateLeader", emp);
	}

	public int insertLeader(Emp emp) {
		return sqlSession.insert("emp.insertLeader",emp);
	}
	
	public int selectTeamLeader(Emp emp) {
		return sqlSession.selectOne("emp.selectTeamLeader", emp);
	}

	public int updateTeamLeader(Emp emp) {
		return sqlSession.update("emp.updateTeamLeader", emp);
	}

	public int insertTeamLeader(Emp emp) {
		return sqlSession.insert("emp.insertTeamLeader",emp);
	}
	

	public int selectAlarmCount(String empCode) {
		return sqlSession.selectOne("emp.selectAlarmCount", empCode);
	}

	public List<Check> empCheckMonth(HashMap<String, String> map) {
		return sqlSession.selectList("emp.empCheckMonth", map);
	}

	public List<Sales> selectSalesMonth(String yearMonth) {
		return sqlSession.selectList("emp.selectSalesMonth", yearMonth);
	}

	public List<Spending> selectSpendingMonth(String yearMonth) {
		return sqlSession.selectList("emp.selectSpendingMonth", yearMonth);
	}

	public String selectAdminEmpCode() {
		return sqlSession.selectOne("emp.selectAdminEmpCode");
	}

	public List<Salary> selectSalaryHisotry(String empCode) {
		return sqlSession.selectList("emp.selectSalaryHistory", empCode);
	}

	public List<HashMap<String, String>> selectDisciplinary() {
		return sqlSession.selectList("emp.selectDisciplinary");
	}

	public int insertDisciplinaryDi(Disciplinary disciplinary) {
		return sqlSession.insert("emp.insertDisciplinaryDi", disciplinary);
	}

	public int updateEmpDi(String empCode) {
		return sqlSession.update("emp.updateEmpDi", empCode);
	}

	public int insertDisciplinaryCu(Disciplinary disciplinary) {
		return sqlSession.insert("emp.insertDisciplinaryCu", disciplinary);
	}

	public int insertCheckDisciplinary(HashMap<String, String> map) {
		return sqlSession.insert("emp.insertCheckDisciplinary", map);
	}

	public int updateDisciplinarySalary(Disciplinary disciplinary) {
		return sqlSession.update("emp.updateDisciplinarySalary", disciplinary);
	}

	public int insertDisciplinarySu(Disciplinary disciplinary) {
		return sqlSession.insert("emp.insertDisciplinarySu",disciplinary);
	}

	public List<Disciplinary> selectDisciplinaryCheck() {
		return sqlSession.selectList("emp.selectDisciplinaryCheck");
	}

	public String selectSalaryCheck(String empCode) {
		return sqlSession.selectOne("emp.selectSalaryCheck", empCode);
	}

	public int returnDisciplinarySalary(HashMap<String, String> map) {
		return sqlSession.update("emp.returnDisciplinarySalary", map);
	}

	public int updateComplateDisciplinary(Disciplinary disciplinary) {
		return sqlSession.update("emp.updateComplateDisciplinary", disciplinary);
	}

	public int selectAlarmListTotalCount(String empCode) {
		return sqlSession.selectOne("emp.selectAlarmListTotalCount", empCode);
	}

	public List<Emp> selectEmpSalaryList() {
		return sqlSession.selectList("emp.selectEmpSalaryList");
	}

	public String phoneSelectEmp(String phone) {
		return sqlSession.selectOne("emp.phoneSelectEmp", phone);
	}

	public String selectChkId(String empId) {
		return sqlSession.selectOne("emp.selectChkId",empId);
	}

	public int changePw(HashMap<String, String> map) {
		return sqlSession.update("emp.changePw",map);
	}

	public String getEmpCode() {
		return sqlSession.selectOne("emp.getEmpCode");
	}

}
