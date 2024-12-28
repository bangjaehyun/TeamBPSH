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
import kr.or.iei.emp.model.vo.Chat;
import kr.or.iei.emp.model.vo.DailyReport;
import kr.or.iei.emp.model.vo.Dept;
import kr.or.iei.emp.model.vo.Emp;
import kr.or.iei.emp.model.vo.Rank;
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
	
    public List<Emp> chatEmpList() {
        return sqlSession.selectList("emp.chatEmpList");
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

	public int updateEmp(Emp emp) {
		return sqlSession.update("emp.updateEmp", emp);
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




}
