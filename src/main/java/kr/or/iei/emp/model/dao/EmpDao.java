package kr.or.iei.emp.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mindrot.jbcrypt.BCrypt;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import kr.or.iei.emp.model.vo.Chat;
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

    public int insertChatGroup(String empCode) {
        return sqlSession.insert("emp.insertChatGroup", empCode);
    }

    public List<Chat> selectChatList(String groupNo) {
        return sqlSession.selectList("emp.selectChatList", groupNo);
    }


}
